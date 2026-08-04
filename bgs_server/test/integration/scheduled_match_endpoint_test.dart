import 'package:bgs_server/src/generated/protocol.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given ScheduledMatch endpoint', (sessionBuilder, endpoints) {
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

    Future<League> createLeague(TestSessionBuilder ownerSession, Organization org) {
      return endpoints.league.create(
        ownerSession,
        organizationId: org.id!,
        name: 'Fall Volleyball',
        slug: 'fall-volleyball-${DateTime.now().microsecondsSinceEpoch}',
        sport: Sport.volleyballIndoor,
        teamFeeCents: 15000,
      );
    }

    /// Sets up an org, a league, and two teams within it -- the fixture
    /// nearly every test here needs.
    Future<
      ({
        TestSessionBuilder ownerSession,
        League league,
        Team teamA,
        Team teamB,
      })
    >
    setUpLeagueWithTwoTeams() async {
      final ownerSession = await authedSessionFor(sessionBuilder);
      final org = await createOrg(ownerSession);
      final league = await createLeague(ownerSession, org);
      final teamA = await endpoints.team.create(
        ownerSession,
        leagueId: league.id!,
        name: 'Team A',
      );
      final teamB = await endpoints.team.create(
        ownerSession,
        leagueId: league.id!,
        name: 'Team B',
      );
      return (
        ownerSession: ownerSession,
        league: league,
        teamA: teamA,
        teamB: teamB,
      );
    }

    test(
      'when an org admin schedules a match then it starts as scheduled',
      () async {
        final fixture = await setUpLeagueWithTwoTeams();

        final match = await endpoints.scheduledMatch.create(
          fixture.ownerSession,
          leagueId: fixture.league.id!,
          homeTeamId: fixture.teamA.id!,
          awayTeamId: fixture.teamB.id!,
          scheduledAt: DateTime.now().add(const Duration(days: 3)),
        );

        expect(match.status, MatchStatus.scheduled);
        expect(match.homeTeamId, fixture.teamA.id);
        expect(match.awayTeamId, fixture.teamB.id);
      },
    );

    test(
      'when a non-member tries to schedule a match then it is denied',
      () async {
        final fixture = await setUpLeagueWithTwoTeams();
        final outsiderSession = await authedSessionFor(sessionBuilder);

        expect(
          () => endpoints.scheduledMatch.create(
            outsiderSession,
            leagueId: fixture.league.id!,
            homeTeamId: fixture.teamA.id!,
            awayTeamId: fixture.teamB.id!,
            scheduledAt: DateTime.now().add(const Duration(days: 3)),
          ),
          throwsA(isA<OrganizationAccessDeniedException>()),
        );
      },
    );

    test(
      'when scheduling a match with the same team on both sides then it '
      'throws',
      () async {
        final fixture = await setUpLeagueWithTwoTeams();

        expect(
          () => endpoints.scheduledMatch.create(
            fixture.ownerSession,
            leagueId: fixture.league.id!,
            homeTeamId: fixture.teamA.id!,
            awayTeamId: fixture.teamA.id!,
            scheduledAt: DateTime.now().add(const Duration(days: 3)),
          ),
          throwsA(isA<SameTeamMatchException>()),
        );
      },
    );

    test(
      'when scheduling a match with a team from another league then it '
      'throws',
      () async {
        final fixture = await setUpLeagueWithTwoTeams();
        final otherLeague = await createLeague(
          fixture.ownerSession,
          await createOrg(fixture.ownerSession),
        );
        final outsideTeam = await endpoints.team.create(
          fixture.ownerSession,
          leagueId: otherLeague.id!,
          name: 'Outside Team',
        );

        expect(
          () => endpoints.scheduledMatch.create(
            fixture.ownerSession,
            leagueId: fixture.league.id!,
            homeTeamId: fixture.teamA.id!,
            awayTeamId: outsideTeam.id!,
            scheduledAt: DateTime.now().add(const Duration(days: 3)),
          ),
          throwsA(isA<TeamNotInLeagueException>()),
        );
      },
    );

    test(
      'when rescheduling a match then its fields change',
      () async {
        final fixture = await setUpLeagueWithTwoTeams();
        final match = await endpoints.scheduledMatch.create(
          fixture.ownerSession,
          leagueId: fixture.league.id!,
          homeTeamId: fixture.teamA.id!,
          awayTeamId: fixture.teamB.id!,
          scheduledAt: DateTime.now().add(const Duration(days: 3)),
        );
        final newTime = DateTime.now().add(const Duration(days: 10));

        final updated = await endpoints.scheduledMatch.update(
          fixture.ownerSession,
          match.id!,
          scheduledAt: newTime,
          location: 'Court 2',
        );

        expect(updated.location, 'Court 2');
      },
    );

    test(
      'when an org admin cancels a scheduled match then its status becomes '
      'cancelled',
      () async {
        final fixture = await setUpLeagueWithTwoTeams();
        final match = await endpoints.scheduledMatch.create(
          fixture.ownerSession,
          leagueId: fixture.league.id!,
          homeTeamId: fixture.teamA.id!,
          awayTeamId: fixture.teamB.id!,
          scheduledAt: DateTime.now().add(const Duration(days: 3)),
        );

        final cancelled = await endpoints.scheduledMatch.cancel(
          fixture.ownerSession,
          match.id!,
        );

        expect(cancelled.status, MatchStatus.cancelled);
      },
    );

    test(
      'when cancelling an already-cancelled match then it throws',
      () async {
        final fixture = await setUpLeagueWithTwoTeams();
        final match = await endpoints.scheduledMatch.create(
          fixture.ownerSession,
          leagueId: fixture.league.id!,
          homeTeamId: fixture.teamA.id!,
          awayTeamId: fixture.teamB.id!,
          scheduledAt: DateTime.now().add(const Duration(days: 3)),
        );
        await endpoints.scheduledMatch.cancel(fixture.ownerSession, match.id!);

        expect(
          () => endpoints.scheduledMatch.cancel(
            fixture.ownerSession,
            match.id!,
          ),
          throwsA(isA<MatchActionNotAllowedException>()),
        );
      },
    );

    test(
      'when recording a result then the match completes and both teams '
      'get standings',
      () async {
        final fixture = await setUpLeagueWithTwoTeams();
        final match = await endpoints.scheduledMatch.create(
          fixture.ownerSession,
          leagueId: fixture.league.id!,
          homeTeamId: fixture.teamA.id!,
          awayTeamId: fixture.teamB.id!,
          scheduledAt: DateTime.now().add(const Duration(days: 3)),
        );

        final completed = await endpoints.scheduledMatch.recordResult(
          fixture.ownerSession,
          matchId: match.id!,
          homeScore: 21,
          awayScore: 15,
        );

        expect(completed.status, MatchStatus.completed);

        final standings = await endpoints.standing.listByLeague(
          fixture.ownerSession,
          fixture.league.id!,
        );
        final teamAStanding = standings.firstWhere(
          (s) => s.teamId == fixture.teamA.id,
        );
        final teamBStanding = standings.firstWhere(
          (s) => s.teamId == fixture.teamB.id,
        );

        expect(teamAStanding.wins, 1);
        expect(teamAStanding.losses, 0);
        expect(teamAStanding.pointsFor, 21);
        expect(teamAStanding.pointsAgainst, 15);

        expect(teamBStanding.wins, 0);
        expect(teamBStanding.losses, 1);
        expect(teamBStanding.pointsFor, 15);
        expect(teamBStanding.pointsAgainst, 21);
      },
    );

    test(
      'when a match result is a tie then both teams get a tie recorded',
      () async {
        final fixture = await setUpLeagueWithTwoTeams();
        final match = await endpoints.scheduledMatch.create(
          fixture.ownerSession,
          leagueId: fixture.league.id!,
          homeTeamId: fixture.teamA.id!,
          awayTeamId: fixture.teamB.id!,
          scheduledAt: DateTime.now().add(const Duration(days: 3)),
        );

        await endpoints.scheduledMatch.recordResult(
          fixture.ownerSession,
          matchId: match.id!,
          homeScore: 10,
          awayScore: 10,
        );

        final standings = await endpoints.standing.listByLeague(
          fixture.ownerSession,
          fixture.league.id!,
        );
        final teamAStanding = standings.firstWhere(
          (s) => s.teamId == fixture.teamA.id,
        );

        expect(teamAStanding.ties, 1);
        expect(teamAStanding.wins, 0);
        expect(teamAStanding.losses, 0);
      },
    );

    test(
      'when recording a result for an already-completed match then it '
      'throws',
      () async {
        final fixture = await setUpLeagueWithTwoTeams();
        final match = await endpoints.scheduledMatch.create(
          fixture.ownerSession,
          leagueId: fixture.league.id!,
          homeTeamId: fixture.teamA.id!,
          awayTeamId: fixture.teamB.id!,
          scheduledAt: DateTime.now().add(const Duration(days: 3)),
        );
        await endpoints.scheduledMatch.recordResult(
          fixture.ownerSession,
          matchId: match.id!,
          homeScore: 21,
          awayScore: 15,
        );

        expect(
          () => endpoints.scheduledMatch.recordResult(
            fixture.ownerSession,
            matchId: match.id!,
            homeScore: 21,
            awayScore: 18,
          ),
          throwsA(isA<MatchActionNotAllowedException>()),
        );
      },
    );

    test(
      'when a team wins twice then their standing accumulates across '
      'matches',
      () async {
        final fixture = await setUpLeagueWithTwoTeams();
        final firstMatch = await endpoints.scheduledMatch.create(
          fixture.ownerSession,
          leagueId: fixture.league.id!,
          homeTeamId: fixture.teamA.id!,
          awayTeamId: fixture.teamB.id!,
          scheduledAt: DateTime.now().add(const Duration(days: 3)),
        );
        final secondMatch = await endpoints.scheduledMatch.create(
          fixture.ownerSession,
          leagueId: fixture.league.id!,
          homeTeamId: fixture.teamA.id!,
          awayTeamId: fixture.teamB.id!,
          scheduledAt: DateTime.now().add(const Duration(days: 10)),
        );
        await endpoints.scheduledMatch.recordResult(
          fixture.ownerSession,
          matchId: firstMatch.id!,
          homeScore: 21,
          awayScore: 10,
        );
        await endpoints.scheduledMatch.recordResult(
          fixture.ownerSession,
          matchId: secondMatch.id!,
          homeScore: 21,
          awayScore: 12,
        );

        final standings = await endpoints.standing.listByLeague(
          fixture.ownerSession,
          fixture.league.id!,
        );
        final teamAStanding = standings.firstWhere(
          (s) => s.teamId == fixture.teamA.id,
        );

        expect(teamAStanding.wins, 2);
        expect(teamAStanding.pointsFor, 42);
        expect(teamAStanding.pointsAgainst, 22);
      },
    );

    test(
      'when anyone (even non-members) reads matches then it succeeds',
      () async {
        final fixture = await setUpLeagueWithTwoTeams();
        final match = await endpoints.scheduledMatch.create(
          fixture.ownerSession,
          leagueId: fixture.league.id!,
          homeTeamId: fixture.teamA.id!,
          awayTeamId: fixture.teamB.id!,
          scheduledAt: DateTime.now().add(const Duration(days: 3)),
        );
        final outsiderSession = await authedSessionFor(sessionBuilder);

        final byId = await endpoints.scheduledMatch.getById(
          outsiderSession,
          match.id!,
        );
        expect(byId?.id, match.id);

        final listed = await endpoints.scheduledMatch.listByLeague(
          outsiderSession,
          fixture.league.id!,
        );
        expect(listed.map((m) => m.id), contains(match.id));
      },
    );
  });
}
