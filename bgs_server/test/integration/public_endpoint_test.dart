import 'package:bgs_server/src/generated/protocol.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Public endpoint', (sessionBuilder, endpoints) {
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

    /// Sets up one organization, one *active* league, one *draft* league,
    /// one *published* event, and one *draft* event, created by an
    /// authenticated owner -- but every assertion below calls [PublicEndpoint]
    /// through the bare, unauthenticated [sessionBuilder], since that's the
    /// whole point of this endpoint.
    Future<
      ({
        Organization org,
        League activeLeague,
        League draftLeague,
        Event publishedEvent,
        Event draftEvent,
      })
    >
    setUpFixture() async {
      final ownerSession = await authedSessionFor(sessionBuilder);
      final unique = DateTime.now().microsecondsSinceEpoch;
      final org = await endpoints.organization.create(
        ownerSession,
        name: 'Riverside Rec Public Co',
        slug: 'riverside-rec-public-$unique',
      );
      final activeLeague = await endpoints.league.create(
        ownerSession,
        organizationId: org.id!,
        name: 'Fall Volleyball Public',
        slug: 'fall-volleyball-public-$unique',
        sport: Sport.volleyballIndoor,
        teamFeeCents: 15000,
      );
      await endpoints.league.activate(ownerSession, activeLeague.id!);
      final draftLeague = await endpoints.league.create(
        ownerSession,
        organizationId: org.id!,
        name: 'Winter Draft Public',
        slug: 'winter-draft-public-$unique',
        sport: Sport.volleyballIndoor,
        teamFeeCents: 15000,
      );
      final publishedEvent = await endpoints.event.create(
        ownerSession,
        organizationId: org.id!,
        name: 'Summer Kickball Public',
        slug: 'summer-kickball-public-$unique',
        sport: Sport.kickball,
        startAt: DateTime.now().add(const Duration(days: 5)),
        teamFeeCents: 2000,
      );
      await endpoints.event.publish(ownerSession, publishedEvent.id!);
      final draftEvent = await endpoints.event.create(
        ownerSession,
        organizationId: org.id!,
        name: 'Hidden Draft Public',
        slug: 'hidden-draft-public-$unique',
        sport: Sport.kickball,
        startAt: DateTime.now().add(const Duration(days: 5)),
        teamFeeCents: 2000,
      );

      return (
        org: org,
        activeLeague: activeLeague,
        draftLeague: draftLeague,
        publishedEvent: publishedEvent,
        draftEvent: draftEvent,
      );
    }

    test(
      'when looking up an organization by slug with no session at all '
      'then it is returned',
      () async {
        final fixture = await setUpFixture();

        final found = await endpoints.public.organizationBySlug(
          sessionBuilder,
          fixture.org.slug,
        );

        expect(found?.id, fixture.org.id);
      },
    );

    test(
      'when a slug does not match any organization then null is returned',
      () async {
        final found = await endpoints.public.organizationBySlug(
          sessionBuilder,
          'no-such-org-slug',
        );

        expect(found, isNull);
      },
    );

    test(
      'when listing an organization\'s active leagues with no session then '
      'the active league is included and the draft league is excluded',
      () async {
        final fixture = await setUpFixture();

        final leagues = await endpoints.public.activeLeaguesByOrganization(
          sessionBuilder,
          fixture.org.id!,
        );

        expect(leagues.map((l) => l.id), contains(fixture.activeLeague.id));
        expect(
          leagues.map((l) => l.id),
          isNot(contains(fixture.draftLeague.id)),
        );
      },
    );

    test(
      'when listing an organization\'s published events with no session '
      'then the published event is included and the draft event is '
      'excluded',
      () async {
        final fixture = await setUpFixture();

        final events = await endpoints.public.publishedEventsByOrganization(
          sessionBuilder,
          fixture.org.id!,
        );

        expect(events.map((e) => e.id), contains(fixture.publishedEvent.id));
        expect(
          events.map((e) => e.id),
          isNot(contains(fixture.draftEvent.id)),
        );
      },
    );
  });
}
