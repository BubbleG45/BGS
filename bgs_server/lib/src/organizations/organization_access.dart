import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

import '../generated/protocol.dart';

/// Whether an [OrganizationMember.role] satisfies a required minimum role.
///
/// [OrgMemberRole.owner] satisfies any requirement; [OrgMemberRole.admin]
/// only satisfies an `admin` requirement.
bool orgRoleSatisfies(OrgMemberRole actual, OrgMemberRole required) {
  if (actual == OrgMemberRole.owner) return true;
  return actual == required;
}

/// Throws [OrganizationAccessDeniedException] unless the signed-in user is
/// an [OrganizationMember] of [organizationId] with at least [minRole].
///
/// Assumes the calling endpoint has `requireLogin => true`, so
/// `session.authenticated` is non-null.
Future<OrganizationMember> requireOrgRole(
  Session session,
  UuidValue organizationId, {
  required OrgMemberRole minRole,
}) async {
  final authUserId = session.authenticated!.authUserId;

  final membership = await OrganizationMember.db.findFirstRow(
    session,
    where: (t) =>
        t.organizationId.equals(organizationId) &
        t.authUserId.equals(authUserId),
  );

  if (membership == null || !orgRoleSatisfies(membership.role, minRole)) {
    throw OrganizationAccessDeniedException(organizationId: organizationId);
  }

  return membership;
}
