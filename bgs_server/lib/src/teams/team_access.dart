import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

import '../generated/protocol.dart';
import '../organizations/organization_access.dart';

/// Throws [TeamAccessDeniedException] unless the signed-in user can manage
/// [teamId] -- either as at least `admin` on the team's league's
/// organization, or as an active `manager` on the team itself. The second
/// path is what actually makes the Manager Dashboard's "manager functions"
/// (recording scores, taking attendance) usable by an actual team manager,
/// not just an org admin.
///
/// Assumes the calling endpoint has `requireLogin => true`, so
/// `session.authenticated` is non-null.
Future<void> requireTeamManageAccess(Session session, UuidValue teamId) async {
  final authUserId = session.authenticated!.authUserId;

  final activeManager = await TeamMembership.db.findFirstRow(
    session,
    where: (t) =>
        t.teamId.equals(teamId) &
        t.authUserId.equals(authUserId) &
        t.role.equals(TeamMemberRole.manager) &
        t.status.equals(MembershipStatus.active),
  );
  if (activeManager != null) return;

  final team = await Team.db.findById(session, teamId);
  if (team == null) {
    throw TeamNotFoundException(teamId: teamId);
  }
  final league = await League.db.findById(session, team.leagueId);
  if (league == null) {
    throw LeagueNotFoundException(leagueId: team.leagueId);
  }

  final authUserIdForOrg = session.authenticated!.authUserId;
  final orgMembership = await OrganizationMember.db.findFirstRow(
    session,
    where: (t) =>
        t.organizationId.equals(league.organizationId) &
        t.authUserId.equals(authUserIdForOrg),
  );
  if (orgMembership == null ||
      !orgRoleSatisfies(orgMembership.role, OrgMemberRole.admin)) {
    throw TeamAccessDeniedException(teamId: teamId);
  }
}
