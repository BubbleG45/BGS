import 'package:bgs_server/src/generated/protocol.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Attendance endpoint', (sessionBuilder, endpoints) {
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

    /// Same email-lookup requirement as TeamEndpoint.invitePlayer.
    Future<(TestSessionBuilder, String email)> authedPlayerSessionFor(
      TestSessionBuilder builder,
    ) async {
      final session = builder.build();
      final authUser = await const AuthUsers().create(session);
      final email = '${authUser.id}@example.com';
      await const UserProfiles().createUserProfile(
        session,
        authUser.id,
        UserProfileData(email: email),
      );
      return (
        builder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            authUser.id.toString(),
            {},
          ),
        ),
        email,
      );
    }

    /// Org, league, one team with a roster of two active player memberships,
    /// and a scheduled match between that team and an opponent.
    Future<
      ({
        TestSessionBuilder ownerSession,
        League league,
        Team team,
        Team opponent,
        TeamMembership playerA,
        TeamMembership playerB,
        ScheduledMatch match,
      })
    >
    setUpFixture() async {
      final ownerSession = await authedSessionFor(sessionBuilder);
      final unique = DateTime.now().microsecondsSinceEpoch;
      final org = await endpoints.organization.create(
        ownerSession,
        name: 'Attendance Test Co',
        slug: 'attendance-test-$unique',
      );
      final league = await endpoints.league.create(
        ownerSession,
        organizationId: org.id!,
        name: 'Attendance League',
        slug: 'attendance-league-$unique',
        sport: Sport.volleyballIndoor,
        teamFeeCents: 15000,
      );
      final team = await endpoints.team.create(
        ownerSession,
        leagueId: league.id!,
        name: 'Attendance Team',
      );
      final opponent = await endpoints.team.create(
        ownerSession,
        leagueId: league.id!,
        name: 'Opponent Team',
      );

      final (playerASession, playerAEmail) = await authedPlayerSessionFor(
        sessionBuilder,
      );
      final playerAInvite = await endpoints.team.invitePlayer(
        ownerSession,
        teamId: team.id!,
        email: playerAEmail,
      );
      final playerA = await endpoints.team.acceptInvite(
        playerASession,
        playerAInvite.id!,
      );

      final (playerBSession, playerBEmail) = await authedPlayerSessionFor(
        sessionBuilder,
      );
      final playerBInvite = await endpoints.team.invitePlayer(
        ownerSession,
        teamId: team.id!,
        email: playerBEmail,
      );
      final playerB = await endpoints.team.acceptInvite(
        playerBSession,
        playerBInvite.id!,
      );

      final match = await endpoints.scheduledMatch.create(
        ownerSession,
        leagueId: league.id!,
        homeTeamId: team.id!,
        awayTeamId: opponent.id!,
        scheduledAt: DateTime.now().add(const Duration(days: 3)),
      );

      return (
        ownerSession: ownerSession,
        league: league,
        team: team,
        opponent: opponent,
        playerA: playerA,
        playerB: playerB,
        match: match,
      );
    }

    test(
      'when an org admin records attendance then it is stored',
      () async {
        final fixture = await setUpFixture();

        final recorded = await endpoints.attendance.record(
          fixture.ownerSession,
          matchId: fixture.match.id!,
          teamMembershipId: fixture.playerA.id!,
          status: AttendanceStatus.present,
        );

        expect(recorded.status, AttendanceStatus.present);
        expect(recorded.teamMembershipId, fixture.playerA.id);
      },
    );

    test(
      'when recording attendance twice for the same player then it updates '
      'rather than duplicating',
      () async {
        final fixture = await setUpFixture();

        await endpoints.attendance.record(
          fixture.ownerSession,
          matchId: fixture.match.id!,
          teamMembershipId: fixture.playerA.id!,
          status: AttendanceStatus.present,
        );
        await endpoints.attendance.record(
          fixture.ownerSession,
          matchId: fixture.match.id!,
          teamMembershipId: fixture.playerA.id!,
          status: AttendanceStatus.absent,
        );

        final list = await endpoints.attendance.listForMatch(
          fixture.ownerSession,
          matchId: fixture.match.id!,
          teamId: fixture.team.id!,
        );

        final forPlayerA = list.where(
          (a) => a.teamMembershipId == fixture.playerA.id,
        );
        expect(forPlayerA, hasLength(1));
        expect(forPlayerA.single.status, AttendanceStatus.absent);
      },
    );

    test(
      'when listing attendance for a team then only that team\'s roster '
      'shows up',
      () async {
        final fixture = await setUpFixture();
        await endpoints.attendance.record(
          fixture.ownerSession,
          matchId: fixture.match.id!,
          teamMembershipId: fixture.playerA.id!,
          status: AttendanceStatus.present,
        );
        await endpoints.attendance.record(
          fixture.ownerSession,
          matchId: fixture.match.id!,
          teamMembershipId: fixture.playerB.id!,
          status: AttendanceStatus.absent,
        );

        final list = await endpoints.attendance.listForMatch(
          fixture.ownerSession,
          matchId: fixture.match.id!,
          teamId: fixture.team.id!,
        );

        expect(
          list.map((a) => a.teamMembershipId),
          containsAll([fixture.playerA.id, fixture.playerB.id]),
        );
      },
    );

    test(
      'when a team\'s active manager records attendance for their own team '
      'then it succeeds without org-admin access',
      () async {
        final fixture = await setUpFixture();
        final (managerSession, managerEmail) = await authedPlayerSessionFor(
          sessionBuilder,
        );
        final invite = await endpoints.team.invitePlayer(
          fixture.ownerSession,
          teamId: fixture.team.id!,
          email: managerEmail,
          role: TeamMemberRole.manager,
        );
        await endpoints.team.acceptInvite(managerSession, invite.id!);

        final recorded = await endpoints.attendance.record(
          managerSession,
          matchId: fixture.match.id!,
          teamMembershipId: fixture.playerA.id!,
          status: AttendanceStatus.present,
        );

        expect(recorded.status, AttendanceStatus.present);
      },
    );

    test(
      'when a non-manager non-admin tries to record attendance then it is '
      'denied',
      () async {
        final fixture = await setUpFixture();
        final outsiderSession = await authedSessionFor(sessionBuilder);

        expect(
          () => endpoints.attendance.record(
            outsiderSession,
            matchId: fixture.match.id!,
            teamMembershipId: fixture.playerA.id!,
            status: AttendanceStatus.present,
          ),
          throwsA(isA<TeamAccessDeniedException>()),
        );
      },
    );

    test(
      'when recording attendance for a membership on a team not playing in '
      'the match then it throws',
      () async {
        final fixture = await setUpFixture();
        final (outsidePlayerSession, outsidePlayerEmail) =
            await authedPlayerSessionFor(sessionBuilder);
        final otherTeam = await endpoints.team.create(
          fixture.ownerSession,
          leagueId: fixture.league.id!,
          name: 'Unrelated Team',
        );
        final invite = await endpoints.team.invitePlayer(
          fixture.ownerSession,
          teamId: otherTeam.id!,
          email: outsidePlayerEmail,
        );
        final outsideMembership = await endpoints.team.acceptInvite(
          outsidePlayerSession,
          invite.id!,
        );

        expect(
          () => endpoints.attendance.record(
            fixture.ownerSession,
            matchId: fixture.match.id!,
            teamMembershipId: outsideMembership.id!,
            status: AttendanceStatus.present,
          ),
          throwsA(isA<TeamNotInLeagueException>()),
        );
      },
    );

    test(
      'when a team\'s active manager records the final score for their own '
      'match then it succeeds without org-admin access',
      () async {
        final fixture = await setUpFixture();
        final (managerSession, managerEmail) = await authedPlayerSessionFor(
          sessionBuilder,
        );
        final invite = await endpoints.team.invitePlayer(
          fixture.ownerSession,
          teamId: fixture.team.id!,
          email: managerEmail,
          role: TeamMemberRole.manager,
        );
        await endpoints.team.acceptInvite(managerSession, invite.id!);

        final completed = await endpoints.scheduledMatch.recordResult(
          managerSession,
          matchId: fixture.match.id!,
          homeScore: 21,
          awayScore: 15,
        );

        expect(completed.status, MatchStatus.completed);
      },
    );
  });
}
