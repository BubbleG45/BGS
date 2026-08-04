import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

import '../generated/protocol.dart';
import '../organizations/organization_access.dart';

/// Teams compete within a single [League]. See BUILD_PLAN.md for the domain
/// model.
///
/// Two authorization patterns live side by side here: [create] and
/// [invitePlayer] use [requireOrgRole] (same pattern as League), while
/// [acceptInvite]/[declineInvite] use a simpler check -- is the calling user
/// the [AuthUser] on the membership row being acted on. That second pattern
/// is new to the app: it's the first player-side write, and there's no org
/// role to check because the player usually isn't an org member at all.
class TeamEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Creates a new team within a league. Requires at least `admin` on the
  /// league's organization.
  Future<Team> create(
    Session session, {
    required UuidValue leagueId,
    required String name,
  }) async {
    final league = await _findLeagueOrThrow(session, leagueId);

    await requireOrgRole(
      session,
      league.organizationId,
      minRole: OrgMemberRole.admin,
    );

    return Team.db.insertRow(session, Team(leagueId: leagueId, name: name));
  }

  /// Returns a single team by id. Public -- team pages are public.
  Future<Team?> getById(Session session, UuidValue teamId) async {
    return Team.db.findById(session, teamId);
  }

  /// Returns all teams for a league. Public.
  Future<List<Team>> listByLeague(
    Session session,
    UuidValue leagueId,
  ) async {
    return Team.db.find(
      session,
      where: (t) => t.leagueId.equals(leagueId),
      orderBy: (t) => t.createdAt,
    );
  }

  /// Returns a team's roster (all memberships, any status). Public -- team
  /// rosters are public, same as team/league pages.
  Future<List<TeamMembership>> listMembers(
    Session session,
    UuidValue teamId,
  ) async {
    return TeamMembership.db.find(
      session,
      where: (t) => t.teamId.equals(teamId),
      orderBy: (t) => t.invitedAt,
    );
  }

  /// Invites an existing BGS user (by their verified email) to join a team,
  /// as a `player` by default or as a `manager` if [role] is given. Requires
  /// at least `admin` on the team's league's organization.
  ///
  /// The invited player must already have a BGS account -- inviting someone
  /// who hasn't signed up yet is a later enhancement.
  Future<TeamMembership> invitePlayer(
    Session session, {
    required UuidValue teamId,
    required String email,
    TeamMemberRole? role,
  }) async {
    final team = await _findTeamOrThrow(session, teamId);
    final league = await _findLeagueOrThrow(session, team.leagueId);

    await requireOrgRole(
      session,
      league.organizationId,
      minRole: OrgMemberRole.admin,
    );

    final normalizedEmail = email.toLowerCase();

    final profile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.email.equals(normalizedEmail),
    );
    if (profile == null) {
      throw PlayerNotFoundException(email: email);
    }

    return session.db.transaction((transaction) async {
      final existing = await TeamMembership.db.findFirstRow(
        session,
        where: (t) =>
            t.teamId.equals(teamId) & t.authUserId.equals(profile.authUserId),
        transaction: transaction,
      );
      if (existing != null) {
        throw TeamMembershipAlreadyExistsException(
          teamId: teamId,
          email: email,
        );
      }

      return TeamMembership.db.insertRow(
        session,
        TeamMembership(
          teamId: teamId,
          authUserId: profile.authUserId,
          role: role ?? TeamMemberRole.player,
        ),
        transaction: transaction,
      );
    });
  }

  /// Accepts a pending invite. Callable only by the invited player
  /// themselves -- see the class doc for why this isn't an org-role check.
  Future<TeamMembership> acceptInvite(
    Session session,
    UuidValue membershipId,
  ) async {
    return _resolveInvite(
      session,
      membershipId,
      status: MembershipStatus.active,
      setJoinedAt: true,
    );
  }

  /// Declines a pending invite. Callable only by the invited player
  /// themselves.
  Future<TeamMembership> declineInvite(
    Session session,
    UuidValue membershipId,
  ) async {
    return _resolveInvite(
      session,
      membershipId,
      status: MembershipStatus.declined,
      setJoinedAt: false,
    );
  }

  /// Returns the calling user's own team memberships, across all teams.
  /// Backs the Player Dashboard ("my teams").
  Future<List<TeamMembership>> listMine(Session session) async {
    final authUserId = session.authenticated!.authUserId;

    return TeamMembership.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      orderBy: (t) => t.invitedAt,
      orderDescending: true,
    );
  }

  Future<TeamMembership> _resolveInvite(
    Session session,
    UuidValue membershipId, {
    required MembershipStatus status,
    required bool setJoinedAt,
  }) async {
    final membership = await TeamMembership.db.findById(
      session,
      membershipId,
    );
    if (membership == null) {
      throw TeamMembershipNotFoundException(membershipId: membershipId);
    }

    final authUserId = session.authenticated!.authUserId;
    if (membership.authUserId != authUserId) {
      throw TeamMembershipAccessDeniedException(membershipId: membershipId);
    }

    if (membership.status != MembershipStatus.invited) {
      throw TeamMembershipActionNotAllowedException(
        membershipId: membershipId,
        currentStatus: membership.status,
      );
    }

    return TeamMembership.db.updateRow(
      session,
      membership.copyWith(
        status: status,
        joinedAt: setJoinedAt ? DateTime.now().toUtc() : membership.joinedAt,
      ),
    );
  }

  Future<Team> _findTeamOrThrow(Session session, UuidValue teamId) async {
    final team = await Team.db.findById(session, teamId);
    if (team == null) {
      throw TeamNotFoundException(teamId: teamId);
    }
    return team;
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
}
