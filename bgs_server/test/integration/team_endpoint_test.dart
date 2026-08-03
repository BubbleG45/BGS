import 'package:bgs_server/src/generated/protocol.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Team endpoint', (sessionBuilder, endpoints) {
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

    /// Creates an authed session for a brand-new user *with a profile email
    /// set*, since [TeamEndpoint.invitePlayer] looks players up by email.
    Future<(TestSessionBuilder, String email)> authedPlayerSessionFor(
      TestSessionBuilder builder,
    ) async {
      final session = builder.build();
      final authUser = await const AuthUsers().create(session);
      final email =
          '${authUser.id}@example.com'; // unique per test-created user
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

    test(
      'when an org admin creates a team then it belongs to the league',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await createLeague(ownerSession, org);

        final team = await endpoints.team.create(
          ownerSession,
          leagueId: league.id!,
          name: 'The Spikers',
        );

        expect(team.leagueId, league.id);
      },
    );

    test(
      'when a non-member tries to create a team then it is denied',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await createLeague(ownerSession, org);

        final outsiderSession = await authedSessionFor(sessionBuilder);

        expect(
          () => endpoints.team.create(
            outsiderSession,
            leagueId: league.id!,
            name: 'Sneaky Team',
          ),
          throwsA(isA<OrganizationAccessDeniedException>()),
        );
      },
    );

    test(
      'when inviting an existing user by email then a pending membership is '
      'created',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await createLeague(ownerSession, org);
        final team = await endpoints.team.create(
          ownerSession,
          leagueId: league.id!,
          name: 'The Spikers',
        );

        final (_, playerEmail) = await authedPlayerSessionFor(sessionBuilder);

        final membership = await endpoints.team.invitePlayer(
          ownerSession,
          teamId: team.id!,
          email: playerEmail,
        );

        expect(membership.status, MembershipStatus.invited);
        expect(membership.teamId, team.id);
      },
    );

    test(
      'when inviting an email with no matching account then it throws',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await createLeague(ownerSession, org);
        final team = await endpoints.team.create(
          ownerSession,
          leagueId: league.id!,
          name: 'The Spikers',
        );

        expect(
          () => endpoints.team.invitePlayer(
            ownerSession,
            teamId: team.id!,
            email: 'nobody@example.com',
          ),
          throwsA(isA<PlayerNotFoundException>()),
        );
      },
    );

    test(
      'when inviting the same player twice then it throws',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await createLeague(ownerSession, org);
        final team = await endpoints.team.create(
          ownerSession,
          leagueId: league.id!,
          name: 'The Spikers',
        );
        final (_, playerEmail) = await authedPlayerSessionFor(sessionBuilder);

        await endpoints.team.invitePlayer(
          ownerSession,
          teamId: team.id!,
          email: playerEmail,
        );

        expect(
          () => endpoints.team.invitePlayer(
            ownerSession,
            teamId: team.id!,
            email: playerEmail,
          ),
          throwsA(isA<TeamMembershipAlreadyExistsException>()),
        );
      },
    );

    test(
      'when the invited player accepts then their membership becomes active',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await createLeague(ownerSession, org);
        final team = await endpoints.team.create(
          ownerSession,
          leagueId: league.id!,
          name: 'The Spikers',
        );
        final (playerSession, playerEmail) = await authedPlayerSessionFor(
          sessionBuilder,
        );
        final membership = await endpoints.team.invitePlayer(
          ownerSession,
          teamId: team.id!,
          email: playerEmail,
        );

        final accepted = await endpoints.team.acceptInvite(
          playerSession,
          membership.id!,
        );

        expect(accepted.status, MembershipStatus.active);
        expect(accepted.joinedAt, isNotNull);
      },
    );

    test(
      'when the invited player declines then their membership is declined',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await createLeague(ownerSession, org);
        final team = await endpoints.team.create(
          ownerSession,
          leagueId: league.id!,
          name: 'The Spikers',
        );
        final (playerSession, playerEmail) = await authedPlayerSessionFor(
          sessionBuilder,
        );
        final membership = await endpoints.team.invitePlayer(
          ownerSession,
          teamId: team.id!,
          email: playerEmail,
        );

        final declined = await endpoints.team.declineInvite(
          playerSession,
          membership.id!,
        );

        expect(declined.status, MembershipStatus.declined);
      },
    );

    test(
      'when someone other than the invited player tries to accept then it '
      'is denied',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await createLeague(ownerSession, org);
        final team = await endpoints.team.create(
          ownerSession,
          leagueId: league.id!,
          name: 'The Spikers',
        );
        final (_, playerEmail) = await authedPlayerSessionFor(sessionBuilder);
        final membership = await endpoints.team.invitePlayer(
          ownerSession,
          teamId: team.id!,
          email: playerEmail,
        );

        // Not the invited player, and not an org admin either.
        final outsiderSession = await authedSessionFor(sessionBuilder);

        expect(
          () => endpoints.team.acceptInvite(outsiderSession, membership.id!),
          throwsA(isA<TeamMembershipAccessDeniedException>()),
        );
      },
    );

    test(
      'when accepting an already-resolved invite then it throws',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await createLeague(ownerSession, org);
        final team = await endpoints.team.create(
          ownerSession,
          leagueId: league.id!,
          name: 'The Spikers',
        );
        final (playerSession, playerEmail) = await authedPlayerSessionFor(
          sessionBuilder,
        );
        final membership = await endpoints.team.invitePlayer(
          ownerSession,
          teamId: team.id!,
          email: playerEmail,
        );
        await endpoints.team.acceptInvite(playerSession, membership.id!);

        expect(
          () => endpoints.team.acceptInvite(playerSession, membership.id!),
          throwsA(isA<TeamMembershipActionNotAllowedException>()),
        );
      },
    );

    test(
      'when a player checks listMine then it includes their memberships',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await createLeague(ownerSession, org);
        final team = await endpoints.team.create(
          ownerSession,
          leagueId: league.id!,
          name: 'The Spikers',
        );
        final (playerSession, playerEmail) = await authedPlayerSessionFor(
          sessionBuilder,
        );
        final membership = await endpoints.team.invitePlayer(
          ownerSession,
          teamId: team.id!,
          email: playerEmail,
        );

        final mine = await endpoints.team.listMine(playerSession);

        expect(mine.map((m) => m.id), contains(membership.id));
      },
    );

    test(
      'when anyone (even non-members) reads teams then it succeeds',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await createLeague(ownerSession, org);
        final team = await endpoints.team.create(
          ownerSession,
          leagueId: league.id!,
          name: 'Public Team',
        );

        final outsiderSession = await authedSessionFor(sessionBuilder);

        final byId = await endpoints.team.getById(outsiderSession, team.id!);
        expect(byId?.id, team.id);

        final listed = await endpoints.team.listByLeague(
          outsiderSession,
          league.id!,
        );
        expect(listed.map((t) => t.id), contains(team.id));
      },
    );
  });
}
