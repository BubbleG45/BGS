import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../teams/team_access.dart';

/// Lightweight v1 attendance tracking -- a manager (org admin or the
/// team's active `manager`) marks each roster member present/absent for a
/// match after the fact. Not a player-facing RSVP; see BUILD_PLAN.md for
/// that deferred feature. Attendance is team-internal, not public data --
/// every method here requires manage access on the specific team.
class AttendanceEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Records (or updates) one roster member's attendance for a match.
  /// [teamMembershipId] must belong to a team that's actually playing in
  /// [matchId] (home or away); the caller must have manage access on that
  /// team.
  Future<MatchAttendance> record(
    Session session, {
    required UuidValue matchId,
    required UuidValue teamMembershipId,
    required AttendanceStatus status,
  }) async {
    final match = await _findMatchOrThrow(session, matchId);
    final membership = await _findMembershipOrThrow(
      session,
      teamMembershipId,
    );

    if (membership.teamId != match.homeTeamId &&
        membership.teamId != match.awayTeamId) {
      throw TeamNotInLeagueException(
        leagueId: match.leagueId,
        teamId: membership.teamId,
      );
    }
    await requireTeamManageAccess(session, membership.teamId);

    final existing = await MatchAttendance.db.findFirstRow(
      session,
      where: (t) =>
          t.matchId.equals(matchId) &
          t.teamMembershipId.equals(teamMembershipId),
    );

    if (existing == null) {
      return MatchAttendance.db.insertRow(
        session,
        MatchAttendance(
          matchId: matchId,
          teamMembershipId: teamMembershipId,
          status: status,
        ),
      );
    }

    return MatchAttendance.db.updateRow(
      session,
      existing.copyWith(status: status, recordedAt: DateTime.now().toUtc()),
    );
  }

  /// Returns every attendance record for [teamId]'s roster at [matchId].
  /// Requires manage access on [teamId] -- attendance is team-internal.
  Future<List<MatchAttendance>> listForMatch(
    Session session, {
    required UuidValue matchId,
    required UuidValue teamId,
  }) async {
    await requireTeamManageAccess(session, teamId);

    final memberships = await TeamMembership.db.find(
      session,
      where: (t) => t.teamId.equals(teamId),
    );
    final membershipIds = memberships.map((m) => m.id!).toList();

    return MatchAttendance.db.find(
      session,
      where: (t) =>
          t.matchId.equals(matchId) & t.teamMembershipId.inSet(membershipIds.toSet()),
    );
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

  Future<TeamMembership> _findMembershipOrThrow(
    Session session,
    UuidValue membershipId,
  ) async {
    final membership = await TeamMembership.db.findById(
      session,
      membershipId,
    );
    if (membership == null) {
      throw TeamMembershipNotFoundException(membershipId: membershipId);
    }
    return membership;
  }
}
