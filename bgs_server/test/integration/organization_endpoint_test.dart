import 'package:bgs_server/src/generated/protocol.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Organization endpoint', (sessionBuilder, endpoints) {
    test(
      'when creating an organization then the creator becomes its owner',
      () async {
        final authUser = await const AuthUsers().create(sessionBuilder.build());
        final authedSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            authUser.id.toString(),
            {},
          ),
        );

        final organization = await endpoints.organization.create(
          authedSession,
          name: 'Riverside Rec League',
          slug: 'riverside-rec',
          description: 'Adult rec sports in Riverside.',
        );

        expect(organization.name, 'Riverside Rec League');
        expect(organization.slug, 'riverside-rec');

        final mine = await endpoints.organization.listMine(authedSession);

        expect(mine, hasLength(1));
        expect(mine.single.organization.id, organization.id);
        expect(mine.single.role, OrgMemberRole.owner);
      },
    );

    test(
      'when creating an organization with a taken slug then it throws',
      () async {
        final firstUser = await const AuthUsers().create(sessionBuilder.build());
        final firstSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            firstUser.id.toString(),
            {},
          ),
        );
        await endpoints.organization.create(
          firstSession,
          name: 'Original Org',
          slug: 'taken-slug',
        );

        final secondUser = await const AuthUsers().create(sessionBuilder.build());
        final secondSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            secondUser.id.toString(),
            {},
          ),
        );

        expect(
          () => endpoints.organization.create(
            secondSession,
            name: 'Copycat Org',
            slug: 'taken-slug',
          ),
          throwsA(isA<OrganizationSlugTakenException>()),
        );
      },
    );

    test(
      'when a non-member checks org access then it is denied',
      () async {
        final ownerUser = await const AuthUsers().create(sessionBuilder.build());
        final ownerSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            ownerUser.id.toString(),
            {},
          ),
        );
        final organization = await endpoints.organization.create(
          ownerSession,
          name: 'Owner-Only Org',
          slug: 'owner-only-org',
        );

        final outsider = await const AuthUsers().create(sessionBuilder.build());
        final outsiderSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            outsider.id.toString(),
            {},
          ),
        );

        final mine = await endpoints.organization.listMine(outsiderSession);
        expect(mine, isEmpty);

        // getById stays readable by anyone (org homepages are public).
        final fetched = await endpoints.organization.getById(
          outsiderSession,
          organization.id!,
        );
        expect(fetched?.id, organization.id);
      },
    );
  });
}
