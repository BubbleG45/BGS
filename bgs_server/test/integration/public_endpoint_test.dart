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

    /// Sets up one organization, one *active* league, one *completed*
    /// league, one *draft* league, one *published* event, and one *draft*
    /// event, created by an authenticated owner -- but every assertion below
    /// calls [PublicEndpoint] through the bare, unauthenticated
    /// [sessionBuilder], since that's the whole point of this endpoint.
    Future<
      ({
        TestSessionBuilder ownerSession,
        Organization org,
        League activeLeague,
        League completedLeague,
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
      final completedLeagueDraft = await endpoints.league.create(
        ownerSession,
        organizationId: org.id!,
        name: 'Spring Volleyball Public',
        slug: 'spring-volleyball-public-$unique',
        sport: Sport.volleyballIndoor,
        teamFeeCents: 15000,
      );
      await endpoints.league.activate(ownerSession, completedLeagueDraft.id!);
      final completedLeague = await endpoints.league.complete(
        ownerSession,
        completedLeagueDraft.id!,
      );
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
        ownerSession: ownerSession,
        org: org,
        activeLeague: activeLeague,
        completedLeague: completedLeague,
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
      'when listing an organization\'s leagues with no session then the '
      'active and completed leagues are included but the draft league is '
      'excluded',
      () async {
        final fixture = await setUpFixture();

        final leagues = await endpoints.public.leaguesByOrganization(
          sessionBuilder,
          fixture.org.id!,
        );

        expect(leagues.map((l) => l.id), contains(fixture.activeLeague.id));
        expect(
          leagues.map((l) => l.id),
          contains(fixture.completedLeague.id),
        );
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

    test(
      'when looking up a league by org slug + league slug with no session '
      'then the active league is returned',
      () async {
        final fixture = await setUpFixture();

        final found = await endpoints.public.leagueBySlug(
          sessionBuilder,
          organizationSlug: fixture.org.slug,
          leagueSlug: fixture.activeLeague.slug,
        );

        expect(found?.id, fixture.activeLeague.id);
      },
    );

    test(
      'when looking up a draft league by slug then null is returned even '
      'though it exists',
      () async {
        final fixture = await setUpFixture();

        final found = await endpoints.public.leagueBySlug(
          sessionBuilder,
          organizationSlug: fixture.org.slug,
          leagueSlug: fixture.draftLeague.slug,
        );

        expect(found, isNull);
      },
    );

    test(
      'when the org slug in a league lookup does not exist then null is '
      'returned',
      () async {
        final fixture = await setUpFixture();

        final found = await endpoints.public.leagueBySlug(
          sessionBuilder,
          organizationSlug: 'no-such-org-slug',
          leagueSlug: fixture.activeLeague.slug,
        );

        expect(found, isNull);
      },
    );

    test(
      'when reading teams/standings/matches for a league with no session '
      'then they succeed',
      () async {
        final fixture = await setUpFixture();
        final team = await endpoints.team.create(
          fixture.ownerSession,
          leagueId: fixture.activeLeague.id!,
          name: 'Riverside Spikers Public',
        );

        final teams = await endpoints.public.teamsByLeague(
          sessionBuilder,
          fixture.activeLeague.id!,
        );
        final standings = await endpoints.public.standingsByLeague(
          sessionBuilder,
          fixture.activeLeague.id!,
        );
        final matches = await endpoints.public.matchesByLeague(
          sessionBuilder,
          fixture.activeLeague.id!,
        );

        expect(teams.map((t) => t.id), contains(team.id));
        expect(standings, isEmpty);
        expect(matches, isEmpty);
      },
    );

    test(
      'when looking up a published event by slug with no session then it '
      'is returned',
      () async {
        final fixture = await setUpFixture();

        final found = await endpoints.public.eventBySlug(
          sessionBuilder,
          fixture.publishedEvent.slug,
        );

        expect(found?.id, fixture.publishedEvent.id);
      },
    );

    test(
      'when looking up a draft event by slug then null is returned even '
      'though it exists',
      () async {
        final fixture = await setUpFixture();

        final found = await endpoints.public.eventBySlug(
          sessionBuilder,
          fixture.draftEvent.slug,
        );

        expect(found, isNull);
      },
    );

    test(
      'when searching with no session then a matching active league is '
      'returned but a matching draft league is not',
      () async {
        final fixture = await setUpFixture();

        final results = await endpoints.public.search(
          sessionBuilder,
          query: fixture.activeLeague.name,
        );

        expect(
          results.leagues.map((l) => l.id),
          contains(fixture.activeLeague.id),
        );
      },
    );

    test(
      'when searching with no session then a matching published event is '
      'returned',
      () async {
        final fixture = await setUpFixture();

        final results = await endpoints.public.search(
          sessionBuilder,
          query: fixture.publishedEvent.name,
        );

        expect(
          results.events.map((e) => e.id),
          contains(fixture.publishedEvent.id),
        );
      },
    );

    test(
      'when searching for a draft league\'s exact name then it is excluded',
      () async {
        final fixture = await setUpFixture();

        final results = await endpoints.public.search(
          sessionBuilder,
          query: fixture.draftLeague.name,
        );

        expect(
          results.leagues.map((l) => l.id),
          isNot(contains(fixture.draftLeague.id)),
        );
      },
    );

    test(
      'when searching by location with no session then only leagues/events '
      'at a matching location are returned',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final unique = DateTime.now().microsecondsSinceEpoch;
        final org = await endpoints.organization.create(
          ownerSession,
          name: 'Riverside Location Co $unique',
          slug: 'riverside-location-$unique',
        );
        final league = await endpoints.league.create(
          ownerSession,
          organizationId: org.id!,
          name: 'Riverside Park League $unique',
          slug: 'riverside-park-league-$unique',
          sport: Sport.volleyballIndoor,
          teamFeeCents: 15000,
          location: 'Riverside Park Courts 1-3',
        );
        await endpoints.league.activate(ownerSession, league.id!);

        final matching = await endpoints.public.search(
          sessionBuilder,
          location: 'Riverside Park',
        );
        final nonMatching = await endpoints.public.search(
          sessionBuilder,
          location: 'Somewhere Else Entirely',
        );

        expect(matching.leagues.map((l) => l.id), contains(league.id));
        expect(
          nonMatching.leagues.map((l) => l.id),
          isNot(contains(league.id)),
        );
      },
    );

    test(
      'when listing registrations for a published event with no session '
      'then active registrations are returned',
      () async {
        final fixture = await setUpFixture();
        final playerSession = await authedSessionFor(sessionBuilder);
        await endpoints.event.register(
          playerSession,
          eventId: fixture.publishedEvent.id!,
          teamName: 'Public Registrants',
        );

        final registrations = await endpoints.public.registrationsByEvent(
          sessionBuilder,
          fixture.publishedEvent.id!,
        );

        expect(registrations.map((r) => r.teamName), contains('Public Registrants'));
      },
    );

    test(
      'when listing registrations for a draft event then an empty list is '
      'returned rather than an error',
      () async {
        final fixture = await setUpFixture();

        final registrations = await endpoints.public.registrationsByEvent(
          sessionBuilder,
          fixture.draftEvent.id!,
        );

        expect(registrations, isEmpty);
      },
    );
  });
}
