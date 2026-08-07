import 'package:bgs_server/src/generated/protocol.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given League endpoint', (sessionBuilder, endpoints) {
    Future<TestSessionBuilder> authedSessionFor(
      TestSessionBuilder builder,
    ) async {
      final authUser = await const AuthUsers().create(builder.build());
      return builder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          authUser.id.toString(),
          {},
        ),
      );
    }

    Future<Organization> createOrg(TestSessionBuilder ownerSession) {
      return endpoints.organization.create(
        ownerSession,
        name: 'Riverside Rec League',
        slug: 'riverside-rec-${DateTime.now().microsecondsSinceEpoch}',
      );
    }

    test(
      'when an org admin creates a league then it starts in draft status',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);

        final league = await endpoints.league.create(
          ownerSession,
          organizationId: org.id!,
          name: 'Fall Volleyball',
          slug: 'fall-volleyball',
          sport: Sport.volleyballIndoor,
          teamFeeCents: 15000,
        );

        expect(league.status, LeagueStatus.draft);
        expect(league.organizationId, org.id);
      },
    );

    test(
      'when a non-member tries to create a league then it is denied',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);

        final outsiderSession = await authedSessionFor(sessionBuilder);

        expect(
          () => endpoints.league.create(
            outsiderSession,
            organizationId: org.id!,
            name: 'Sneaky League',
            slug: 'sneaky-league',
            sport: Sport.kickball,
            teamFeeCents: 5000,
          ),
          throwsA(isA<OrganizationAccessDeniedException>()),
        );
      },
    );

    test(
      'when creating a league with a slug already used in that org then it throws',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);

        await endpoints.league.create(
          ownerSession,
          organizationId: org.id!,
          name: 'Spring Kickball',
          slug: 'spring-kickball',
          sport: Sport.kickball,
          teamFeeCents: 5000,
        );

        expect(
          () => endpoints.league.create(
            ownerSession,
            organizationId: org.id!,
            name: 'Spring Kickball Redux',
            slug: 'spring-kickball',
            sport: Sport.kickball,
            teamFeeCents: 6000,
          ),
          throwsA(isA<LeagueSlugTakenException>()),
        );
      },
    );

    test(
      'when activating a draft league then its status becomes active',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await endpoints.league.create(
          ownerSession,
          organizationId: org.id!,
          name: 'Summer Soccer',
          slug: 'summer-soccer',
          sport: Sport.soccer,
          teamFeeCents: 8000,
        );

        final activated = await endpoints.league.activate(
          ownerSession,
          league.id!,
        );

        expect(activated.status, LeagueStatus.active);
      },
    );

    test(
      'when activating an already-active league then it throws',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await endpoints.league.create(
          ownerSession,
          organizationId: org.id!,
          name: 'Winter Dodgeball',
          slug: 'winter-dodgeball',
          sport: Sport.dodgeball,
          teamFeeCents: 4000,
        );
        await endpoints.league.activate(ownerSession, league.id!);

        expect(
          () => endpoints.league.activate(ownerSession, league.id!),
          throwsA(isA<LeagueActivationNotAllowedException>()),
        );
      },
    );

    test(
      'when updating a league then its fields change',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await endpoints.league.create(
          ownerSession,
          organizationId: org.id!,
          name: 'Original Name',
          slug: 'original-name',
          sport: Sport.pickleball,
          teamFeeCents: 3000,
        );

        final updated = await endpoints.league.update(
          ownerSession,
          league.id!,
          name: 'Updated Name',
          teamFeeCents: 3500,
        );

        expect(updated.name, 'Updated Name');
        expect(updated.teamFeeCents, 3500);
        // Untouched fields survive the partial update.
        expect(updated.sport, Sport.pickleball);
      },
    );

    test(
      'when creating a league with season/registration dates and a rules '
      'link then they are stored',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final seasonStart = DateTime.now().toUtc().add(const Duration(days: 14));
        final seasonEnd = DateTime.now().toUtc().add(const Duration(days: 90));
        final regOpens = DateTime.now().toUtc().add(const Duration(days: 1));
        final regCloses = DateTime.now().toUtc().add(const Duration(days: 10));

        final league = await endpoints.league.create(
          ownerSession,
          organizationId: org.id!,
          name: 'Dated League',
          slug: 'dated-league',
          sport: Sport.volleyballIndoor,
          teamFeeCents: 15000,
          seasonStartAt: seasonStart,
          seasonEndAt: seasonEnd,
          registrationOpensAt: regOpens,
          registrationClosesAt: regCloses,
          rulesUrl: 'https://example.com/rules',
        );

        expect(league.seasonStartAt, seasonStart);
        expect(league.seasonEndAt, seasonEnd);
        expect(league.registrationOpensAt, regOpens);
        expect(league.registrationClosesAt, regCloses);
        expect(league.rulesUrl, 'https://example.com/rules');
      },
    );

    test(
      'when an org admin completes an active league then its status '
      'becomes completed',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await endpoints.league.create(
          ownerSession,
          organizationId: org.id!,
          name: 'Season To Complete',
          slug: 'season-to-complete',
          sport: Sport.volleyballIndoor,
          teamFeeCents: 15000,
        );
        await endpoints.league.activate(ownerSession, league.id!);

        final completed = await endpoints.league.complete(
          ownerSession,
          league.id!,
        );

        expect(completed.status, LeagueStatus.completed);
      },
    );

    test(
      'when completing a league that is still draft then it throws',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await endpoints.league.create(
          ownerSession,
          organizationId: org.id!,
          name: 'Still Draft',
          slug: 'still-draft',
          sport: Sport.volleyballIndoor,
          teamFeeCents: 15000,
        );

        expect(
          () => endpoints.league.complete(ownerSession, league.id!),
          throwsA(isA<LeagueCompletionNotAllowedException>()),
        );
      },
    );

    test(
      'when anyone (even non-members) reads a league then it succeeds',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await endpoints.league.create(
          ownerSession,
          organizationId: org.id!,
          name: 'Public League',
          slug: 'public-league',
          sport: Sport.tennis,
          teamFeeCents: 2000,
        );

        final outsiderSession = await authedSessionFor(sessionBuilder);

        final byId = await endpoints.league.getById(
          outsiderSession,
          league.id!,
        );
        expect(byId?.id, league.id);

        final bySlug = await endpoints.league.getByOrgAndSlug(
          outsiderSession,
          organizationId: org.id!,
          slug: 'public-league',
        );
        expect(bySlug?.id, league.id);

        final listed = await endpoints.league.listByOrganization(
          outsiderSession,
          org.id!,
        );
        expect(listed.map((l) => l.id), contains(league.id));
      },
    );
  });
}
