import 'package:bgs_server/src/generated/protocol.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given PlayerProfile endpoint', (sessionBuilder, endpoints) {
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

    test(
      'when a new user checks their profile then null is returned',
      () async {
        final session = await authedSessionFor(sessionBuilder);

        final profile = await endpoints.playerProfile.getMine(session);

        expect(profile, isNull);
      },
    );

    test(
      'when a user sets a bio then getMine reflects it',
      () async {
        final session = await authedSessionFor(sessionBuilder);

        await endpoints.playerProfile.updateBio(
          session,
          'Plays volleyball on weekends.',
        );
        final profile = await endpoints.playerProfile.getMine(session);

        expect(profile?.bio, 'Plays volleyball on weekends.');
      },
    );

    test(
      'when a user updates their bio a second time then it overwrites '
      'rather than duplicating',
      () async {
        final session = await authedSessionFor(sessionBuilder);

        await endpoints.playerProfile.updateBio(session, 'First bio.');
        await endpoints.playerProfile.updateBio(session, 'Second bio.');
        final profile = await endpoints.playerProfile.getMine(session);

        expect(profile?.bio, 'Second bio.');
      },
    );

    test(
      'when a player with no teams checks stats then zeros are returned',
      () async {
        final session = await authedSessionFor(sessionBuilder);

        final stats = await endpoints.playerProfile.stats(session);

        expect(stats.wins, 0);
        expect(stats.losses, 0);
        expect(stats.ties, 0);
        expect(stats.teamCount, 0);
      },
    );

    test(
      'when a player is on a team with recorded results then stats '
      'aggregate that team\'s standing',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final unique = DateTime.now().microsecondsSinceEpoch;
        final org = await endpoints.organization.create(
          ownerSession,
          name: 'Stats Test Co',
          slug: 'stats-test-$unique',
        );
        final league = await endpoints.league.create(
          ownerSession,
          organizationId: org.id!,
          name: 'Stats League',
          slug: 'stats-league-$unique',
          sport: Sport.volleyballIndoor,
          teamFeeCents: 15000,
        );
        final team = await endpoints.team.create(
          ownerSession,
          leagueId: league.id!,
          name: 'Stats Team',
        );
        final opponent = await endpoints.team.create(
          ownerSession,
          leagueId: league.id!,
          name: 'Stats Opponent',
        );

        final playerSession = sessionBuilder.build();
        final authUser = await const AuthUsers().create(playerSession);
        final email = '${authUser.id}@example.com';
        await const UserProfiles().createUserProfile(
          playerSession,
          authUser.id,
          UserProfileData(email: email),
        );
        final playerBuilder = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            authUser.id.toString(),
            {},
          ),
        );
        final invite = await endpoints.team.invitePlayer(
          ownerSession,
          teamId: team.id!,
          email: email,
        );
        await endpoints.team.acceptInvite(playerBuilder, invite.id!);

        final match = await endpoints.scheduledMatch.create(
          ownerSession,
          leagueId: league.id!,
          homeTeamId: team.id!,
          awayTeamId: opponent.id!,
          scheduledAt: DateTime.now().add(const Duration(days: 3)),
        );
        await endpoints.scheduledMatch.recordResult(
          ownerSession,
          matchId: match.id!,
          homeScore: 21,
          awayScore: 15,
        );

        final stats = await endpoints.playerProfile.stats(playerBuilder);

        expect(stats.wins, 1);
        expect(stats.losses, 0);
        expect(stats.teamCount, 1);
      },
    );
  });
}
