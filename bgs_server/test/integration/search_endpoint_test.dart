import 'package:bgs_server/src/generated/protocol.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Search endpoint', (sessionBuilder, endpoints) {
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
    /// one *published* event, and one *draft* event -- a fixture that lets
    /// every test assert both what should and shouldn't come back.
    Future<
      ({
        TestSessionBuilder ownerSession,
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
        name: 'Riverside Rec Searchable Co',
        slug: 'riverside-rec-search-$unique',
      );
      final activeLeague = await endpoints.league.create(
        ownerSession,
        organizationId: org.id!,
        name: 'Fall Volleyball Searchable',
        slug: 'fall-volleyball-searchable-$unique',
        sport: Sport.volleyballIndoor,
        teamFeeCents: 15000,
      );
      await endpoints.league.activate(ownerSession, activeLeague.id!);
      final draftLeague = await endpoints.league.create(
        ownerSession,
        organizationId: org.id!,
        name: 'Winter Draft Searchable',
        slug: 'winter-draft-searchable-$unique',
        sport: Sport.volleyballIndoor,
        teamFeeCents: 15000,
      );
      final publishedEvent = await endpoints.event.create(
        ownerSession,
        organizationId: org.id!,
        name: 'Summer Kickball Searchable',
        slug: 'summer-kickball-searchable-$unique',
        sport: Sport.kickball,
        startAt: DateTime.now().add(const Duration(days: 5)),
        teamFeeCents: 2000,
      );
      await endpoints.event.publish(ownerSession, publishedEvent.id!);
      final draftEvent = await endpoints.event.create(
        ownerSession,
        organizationId: org.id!,
        name: 'Hidden Draft Searchable',
        slug: 'hidden-draft-searchable-$unique',
        sport: Sport.kickball,
        startAt: DateTime.now().add(const Duration(days: 5)),
        teamFeeCents: 2000,
      );

      return (
        ownerSession: ownerSession,
        org: org,
        activeLeague: activeLeague,
        draftLeague: draftLeague,
        publishedEvent: publishedEvent,
        draftEvent: draftEvent,
      );
    }

    test(
      'when searching by a name substring then matching orgs/leagues/events '
      'are returned, case-insensitively',
      () async {
        final fixture = await setUpFixture();

        final results = await endpoints.search.search(
          fixture.ownerSession,
          query: 'searchable',
        );

        expect(
          results.organizations.map((o) => o.id),
          contains(fixture.org.id),
        );
        expect(
          results.leagues.map((l) => l.id),
          contains(fixture.activeLeague.id),
        );
        expect(
          results.events.map((e) => e.id),
          contains(fixture.publishedEvent.id),
        );
      },
    );

    test(
      'when searching then draft leagues and draft events are excluded '
      'even if their name matches',
      () async {
        final fixture = await setUpFixture();

        final results = await endpoints.search.search(
          fixture.ownerSession,
          query: 'searchable',
        );

        expect(
          results.leagues.map((l) => l.id),
          isNot(contains(fixture.draftLeague.id)),
        );
        expect(
          results.events.map((e) => e.id),
          isNot(contains(fixture.draftEvent.id)),
        );
      },
    );

    test(
      'when filtering by sport with no query then it matches leagues and '
      'events of that sport but excludes organizations entirely',
      () async {
        final fixture = await setUpFixture();

        final results = await endpoints.search.search(
          fixture.ownerSession,
          sport: Sport.kickball,
        );

        expect(
          results.events.map((e) => e.id),
          contains(fixture.publishedEvent.id),
        );
        expect(
          results.leagues.map((l) => l.id),
          isNot(contains(fixture.activeLeague.id)),
        );
        expect(results.organizations, isEmpty);
      },
    );

    test(
      'when combining a name query with a non-matching sport then it '
      'excludes results of the wrong sport',
      () async {
        final fixture = await setUpFixture();

        final results = await endpoints.search.search(
          fixture.ownerSession,
          query: 'searchable',
          sport: Sport.pickleball,
        );

        expect(
          results.leagues.map((l) => l.id),
          isNot(contains(fixture.activeLeague.id)),
        );
        expect(
          results.events.map((e) => e.id),
          isNot(contains(fixture.publishedEvent.id)),
        );
      },
    );

    test(
      'when a query contains a literal percent sign then it is treated as '
      'literal text, not a wildcard',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final unique = DateTime.now().microsecondsSinceEpoch;
        final org = await endpoints.organization.create(
          ownerSession,
          name: '50% Off Rec League $unique',
          slug: 'fifty-percent-off-$unique',
        );

        final literalMatch = await endpoints.search.search(
          ownerSession,
          query: '50%',
        );
        final noMatch = await endpoints.search.search(
          ownerSession,
          query: '50X',
        );

        expect(literalMatch.organizations.map((o) => o.id), contains(org.id));
        expect(
          noMatch.organizations.map((o) => o.id),
          isNot(contains(org.id)),
        );
      },
    );

    test(
      'when searching with no query and no sport then it returns results '
      'without error',
      () async {
        final fixture = await setUpFixture();

        final results = await endpoints.search.search(fixture.ownerSession);

        expect(
          results.leagues.map((l) => l.id),
          contains(fixture.activeLeague.id),
        );
      },
    );
  });
}
