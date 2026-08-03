import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

import '../generated/protocol.dart';

/// Organizations are the top-level entity organizers create leagues and
/// events under. See BUILD_PLAN.md for the domain model.
class OrganizationEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Creates a new organization and makes the calling user its owner.
  Future<Organization> create(
    Session session, {
    required String name,
    required String slug,
    String? description,
  }) async {
    final authUserId = session.authenticated!.authUserId;

    return session.db.transaction((transaction) async {
      // Pre-check for a friendlier error than a raw DB constraint violation.
      // The unique index on Organization.slug remains the real backstop
      // against a race between two concurrent creates of the same slug.
      final existing = await Organization.db.findFirstRow(
        session,
        where: (t) => t.slug.equals(slug),
        transaction: transaction,
      );
      if (existing != null) {
        throw OrganizationSlugTakenException(slug: slug);
      }

      final organization = await Organization.db.insertRow(
        session,
        Organization(name: name, slug: slug, description: description),
        transaction: transaction,
      );

      await OrganizationMember.db.insertRow(
        session,
        OrganizationMember(
          organizationId: organization.id!,
          authUserId: authUserId,
          role: OrgMemberRole.owner,
        ),
        transaction: transaction,
      );

      return organization;
    });
  }

  /// Returns a single organization by id.
  ///
  /// Organizations are public (an org homepage is a public page), so no
  /// membership check is required to read one.
  Future<Organization?> getById(
    Session session,
    UuidValue organizationId,
  ) async {
    return Organization.db.findById(session, organizationId);
  }

  /// Returns a single organization by its public URL slug.
  Future<Organization?> getBySlug(Session session, String slug) async {
    return Organization.db.findFirstRow(
      session,
      where: (t) => t.slug.equals(slug),
    );
  }

  /// Returns the organizations the calling user is a member of, paired with
  /// their role in each. Backs the Organizer Dashboard.
  Future<List<OrganizationMembership>> listMine(Session session) async {
    final authUserId = session.authenticated!.authUserId;

    final memberships = await OrganizationMember.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      include: OrganizationMember.include(organization: Organization.include()),
    );

    return [
      for (final membership in memberships)
        OrganizationMembership(
          organization: membership.organization!,
          role: membership.role,
        ),
    ];
  }
}
