import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../organizations/organization_access.dart';
import '../teams/team_access.dart';

/// A single scheduled game between two teams within a [League]. Manual
/// scheduling only for Phase 1 -- no auto-scheduling algorithm yet. See
/// BUILD_PLAN.md for the domain model.
///
/// [recordResult] is the only place [Standing] rows get written -- they're
/// a recomputed aggregate, not a separate source of truth. See
/// StandingEndpoint for the (read-only) public surface.
class ScheduledMatchEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Schedules a match between two teams within a league. Requires at
  /// least `admin` on the league's organization. Both teams must already
  /// belong to the league.
  Future<ScheduledMatch> create(
    Session session, {
    required UuidValue leagueId,
    required UuidValue homeTeamId,
    required UuidValue awayTeamId,
    required DateTime scheduledAt,
    String? location,
  }) async {
    final league = await _findLeagueOrThrow(session, leagueId);
    await requireOrgRole(
      session,
      league.organizationId,
      minRole: OrgMemberRole.admin,
    );

    if (homeTeamId == awayTeamId) {
      throw SameTeamMatchException(teamId: homeTeamId);
    }

    await _requireTeamInLeague(session, leagueId, homeTeamId);
    await _requireTeamInLeague(session, leagueId, awayTeamId);

    return ScheduledMatch.db.insertRow(
      session,
      ScheduledMatch(
        leagueId: leagueId,
        homeTeamId: homeTeamId,
        awayTeamId: awayTeamId,
        scheduledAt: scheduledAt,
        location: location,
      ),
    );
  }

  /// Returns a single match by id. Public -- schedules are public.
  Future<ScheduledMatch?> getById(Session session, UuidValue matchId) async {
    return ScheduledMatch.db.findById(session, matchId);
  }

  /// Returns all matches for a league, soonest first. Public -- backs the
  /// league schedule page.
  Future<List<ScheduledMatch>> listByLeague(
    Session session,
    UuidValue leagueId,
  ) async {
    return ScheduledMatch.db.find(
      session,
      where: (t) => t.leagueId.equals(leagueId),
      orderBy: (t) => t.scheduledAt,
    );
  }

  /// Reschedules a match (time and/or location). Requires at least `admin`
  /// on the league's organization.
  Future<ScheduledMatch> update(
    Session session,
    UuidValue matchId, {
    DateTime? scheduledAt,
    String? location,
  }) async {
    final match = await _findMatchOrThrow(session, matchId);
    await _requireMatchManagePermission(session, match);

    return ScheduledMatch.db.updateRow(
      session,
      match.copyWith(
        scheduledAt: scheduledAt ?? match.scheduledAt,
        location: location ?? match.location,
      ),
    );
  }

  /// Cancels a scheduled match. Requires at least `admin` on the league's
  /// organization. Only allowed while the match is still `scheduled`.
  Future<ScheduledMatch> cancel(Session session, UuidValue matchId) async {
    final match = await _findMatchOrThrow(session, matchId);
    await _requireMatchManagePermission(session, match);

    if (match.status != MatchStatus.scheduled) {
      throw MatchActionNotAllowedException(
        matchId: matchId,
        currentStatus: match.status,
      );
    }

    return ScheduledMatch.db.updateRow(
      session,
      match.copyWith(status: MatchStatus.cancelled),
    );
  }

  /// Records a final score, marking the match `completed` and updating
  /// both teams' [Standing] rows for the league. Requires at least `admin`
  /// on the league's organization, OR an active `manager` membership on
  /// either the home or away team -- this is what makes the Manager
  /// Dashboard's "Record score" action usable by an actual team manager,
  /// not just an org admin. Only allowed while the match is still
  /// `scheduled` -- results aren't editable in Phase 1.
  Future<ScheduledMatch> recordResult(
    Session session, {
    required UuidValue matchId,
    required int homeScore,
    required int awayScore,
  }) async {
    final match = await _findMatchOrThrow(session, matchId);
    await _requireRecordResultPermission(session, match);

    if (match.status != MatchStatus.scheduled) {
      throw MatchActionNotAllowedException(
        matchId: matchId,
        currentStatus: match.status,
      );
    }

    return session.db.transaction((transaction) async {
      final updated = await ScheduledMatch.db.updateRow(
        session,
        match.copyWith(
          status: MatchStatus.completed,
          homeScore: homeScore,
          awayScore: awayScore,
        ),
        transaction: transaction,
      );

      await _applyResult(
        session,
        transaction: transaction,
        leagueId: match.leagueId,
        teamId: match.homeTeamId,
        pointsFor: homeScore,
        pointsAgainst: awayScore,
      );
      await _applyResult(
        session,
        transaction: transaction,
        leagueId: match.leagueId,
        teamId: match.awayTeamId,
        pointsFor: awayScore,
        pointsAgainst: homeScore,
      );

      return updated;
    });
  }

  /// Applies one side of a match result to that team's [Standing] row,
  /// creating it if this is the team's first recorded result in the
  /// league.
  Future<void> _applyResult(
    Session session, {
    required Transaction transaction,
    required UuidValue leagueId,
    required UuidValue teamId,
    required int pointsFor,
    required int pointsAgainst,
  }) async {
    final win = pointsFor > pointsAgainst ? 1 : 0;
    final loss = pointsFor < pointsAgainst ? 1 : 0;
    final tie = pointsFor == pointsAgainst ? 1 : 0;

    final existing = await Standing.db.findFirstRow(
      session,
      where: (t) => t.leagueId.equals(leagueId) & t.teamId.equals(teamId),
      transaction: transaction,
    );

    if (existing == null) {
      await Standing.db.insertRow(
        session,
        Standing(
          leagueId: leagueId,
          teamId: teamId,
          wins: win,
          losses: loss,
          ties: tie,
          pointsFor: pointsFor,
          pointsAgainst: pointsAgainst,
        ),
        transaction: transaction,
      );
      return;
    }

    await Standing.db.updateRow(
      session,
      existing.copyWith(
        wins: existing.wins + win,
        losses: existing.losses + loss,
        ties: existing.ties + tie,
        pointsFor: existing.pointsFor + pointsFor,
        pointsAgainst: existing.pointsAgainst + pointsAgainst,
      ),
      transaction: transaction,
    );
  }

  Future<void> _requireMatchManagePermission(
    Session session,
    ScheduledMatch match,
  ) async {
    final league = await _findLeagueOrThrow(session, match.leagueId);
    await requireOrgRole(
      session,
      league.organizationId,
      minRole: OrgMemberRole.admin,
    );
  }

  /// Org admin, or an active manager of either side of the match -- see
  /// [recordResult]'s doc comment.
  Future<void> _requireRecordResultPermission(
    Session session,
    ScheduledMatch match,
  ) async {
    try {
      await requireTeamManageAccess(session, match.homeTeamId);
      return;
    } on TeamAccessDeniedException {
      // Fall through to check the away team below.
    }
    await requireTeamManageAccess(session, match.awayTeamId);
  }

  Future<void> _requireTeamInLeague(
    Session session,
    UuidValue leagueId,
    UuidValue teamId,
  ) async {
    final team = await Team.db.findById(session, teamId);
    if (team == null) {
      throw TeamNotFoundException(teamId: teamId);
    }
    if (team.leagueId != leagueId) {
      throw TeamNotInLeagueException(leagueId: leagueId, teamId: teamId);
    }
  }

  Future<League> _findLeagueOrThrow(
    Session session,
    UuidValue leagueId,
  ) async {
    final league = await League.db.findById(session, leagueId);
    if (league == null) {
      throw LeagueNotFoundException(leagueId: leagueId);
    }
    return league;
  }

  Future<ScheduledMatch> _findMatchOrThrow(
    Session session,
    UuidValue matchId,
  ) async {
    final match = await ScheduledMatch.db.findById(session, matchId);
    if (match == null) {
      throw ScheduledMatchNotFoundException(matchId: matchId);
    }
    return match;
  }
}
