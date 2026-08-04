import 'package:bgs_server/src/generated/protocol.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Dashboard endpoint', (sessionBuilder, endpoints) {
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

    Future<Organization> createOrg(TestSessionBuilder ownerSession) {
      return endpoints.organization.create(
        ownerSession,
        name: 'Riverside Rec League',
        slug: 'riverside-rec-${DateTime.now().microsecondsSinceEpoch}',
      );
    }

    Future<League> createLeague(
      TestSessionBuilder ownerSession,
      Organization org,
    ) {
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
      'when a player checks their dashboard then it includes their teams, '
      'registrations, and upcoming matches',
      () async {
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
        final (playerSession, playerEmail) = await authedPlayerSessionFor(
          sessionBuilder,
        );
        final membership = await endpoints.team.invitePlayer(
          ownerSession,
          teamId: teamA.id!,
          email: playerEmail,
        );
        await endpoints.team.acceptInvite(playerSession, membership.id!);
        final match = await endpoints.scheduledMatch.create(
          ownerSession,
          leagueId: league.id!,
          homeTeamId: teamA.id!,
          awayTeamId: teamB.id!,
          scheduledAt: DateTime.now().add(const Duration(days: 5)),
        );
        final event = await endpoints.event.create(
          ownerSession,
          name: 'Pickup Pickleball',
          slug: 'pickup-pickleball-${DateTime.now().microsecondsSinceEpoch}',
          sport: Sport.pickleball,
          startAt: DateTime.now().add(const Duration(days: 2)),
          teamFeeCents: 0,
        );
        await endpoints.event.publish(ownerSession, event.id!);
        final registration = await endpoints.event.register(
          playerSession,
          eventId: event.id!,
        );

        final dashboard = await endpoints.dashboard.player(playerSession);

        expect(
          dashboard.teamMemberships.map((m) => m.id),
          contains(membership.id),
        );
        expect(
          dashboard.eventRegistrations.map((r) => r.id),
          contains(registration.id),
        );
        expect(dashboard.upcomingMatches.map((m) => m.id), contains(match.id));
        // Nested includes are populated, not just the ids.
        final teamMembership = dashboard.teamMemberships.firstWhere(
          (m) => m.id == membership.id,
        );
        expect(teamMembership.team?.league?.organization?.id, org.id);
      },
    );

    test(
      'when a player has only a pending (not yet accepted) team invite '
      'then upcoming matches for that team are excluded',
      () async {
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
        final (playerSession, playerEmail) = await authedPlayerSessionFor(
          sessionBuilder,
        );
        await endpoints.team.invitePlayer(
          ownerSession,
          teamId: teamA.id!,
          email: playerEmail,
        );
        await endpoints.scheduledMatch.create(
          ownerSession,
          leagueId: league.id!,
          homeTeamId: teamA.id!,
          awayTeamId: teamB.id!,
          scheduledAt: DateTime.now().add(const Duration(days: 5)),
        );

        final dashboard = await endpoints.dashboard.player(playerSession);

        expect(dashboard.upcomingMatches, isEmpty);
      },
    );

    test(
      'when an organizer checks their dashboard then it includes their '
      'orgs, leagues, and events',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await createLeague(ownerSession, org);
        final orgEvent = await endpoints.event.create(
          ownerSession,
          organizationId: org.id!,
          name: 'Org Kickball Night',
          slug: 'org-kickball-${DateTime.now().microsecondsSinceEpoch}',
          sport: Sport.kickball,
          startAt: DateTime.now().add(const Duration(days: 3)),
          teamFeeCents: 2000,
        );
        final orglessEvent = await endpoints.event.create(
          ownerSession,
          name: 'Pickup Game',
          slug: 'pickup-game-${DateTime.now().microsecondsSinceEpoch}',
          sport: Sport.pickleball,
          startAt: DateTime.now().add(const Duration(days: 1)),
          teamFeeCents: 0,
        );

        final dashboard = await endpoints.dashboard.organizer(ownerSession);

        expect(
          dashboard.organizations.map((m) => m.organization.id),
          contains(org.id),
        );
        final orgMembership = dashboard.organizations.firstWhere(
          (m) => m.organization.id == org.id,
        );
        expect(orgMembership.role, OrgMemberRole.owner);
        expect(dashboard.leagues.map((l) => l.id), contains(league.id));
        expect(
          dashboard.events.map((e) => e.id),
          containsAll([orgEvent.id, orglessEvent.id]),
        );
      },
    );

    test(
      "when an organizer checks their dashboard then it excludes other "
      "organizers' orgless events",
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        await createOrg(ownerSession);
        final otherSession = await authedSessionFor(sessionBuilder);
        final otherEvent = await endpoints.event.create(
          otherSession,
          name: 'Someone Else\'s Pickup Game',
          slug: 'someone-else-${DateTime.now().microsecondsSinceEpoch}',
          sport: Sport.pickleball,
          startAt: DateTime.now().add(const Duration(days: 1)),
          teamFeeCents: 0,
        );

        final dashboard = await endpoints.dashboard.organizer(ownerSession);

        expect(dashboard.events.map((e) => e.id), isNot(contains(otherEvent.id)));
      },
    );

    test(
      'when a manager checks their dashboard then it includes only active '
      'teams they manage',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await createLeague(ownerSession, org);
        final teamA = await endpoints.team.create(
          ownerSession,
          leagueId: league.id!,
          name: 'Team A',
        );
        final (managerSession, managerEmail) = await authedPlayerSessionFor(
          sessionBuilder,
        );
        final membership = await endpoints.team.invitePlayer(
          ownerSession,
          teamId: teamA.id!,
          email: managerEmail,
          role: TeamMemberRole.manager,
        );

        // Not accepted yet -- shouldn't show up as an active managed team.
        final beforeAccept = await endpoints.dashboard.manager(
          managerSession,
        );
        expect(beforeAccept.managedTeams, isEmpty);

        await endpoints.team.acceptInvite(managerSession, membership.id!);
        final afterAccept = await endpoints.dashboard.manager(managerSession);

        expect(
          afterAccept.managedTeams.map((m) => m.id),
          contains(membership.id),
        );
        expect(afterAccept.managedTeams.first.team?.id, teamA.id);
      },
    );

    test(
      'when anyone reads a team roster then it includes all memberships '
      'regardless of status',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final league = await createLeague(ownerSession, org);
        final teamA = await endpoints.team.create(
          ownerSession,
          leagueId: league.id!,
          name: 'Team A',
        );
        final (_, playerEmail) = await authedPlayerSessionFor(sessionBuilder);
        final membership = await endpoints.team.invitePlayer(
          ownerSession,
          teamId: teamA.id!,
          email: playerEmail,
        );
        final outsiderSession = await authedSessionFor(sessionBuilder);

        final roster = await endpoints.team.listMembers(
          outsiderSession,
          teamA.id!,
        );

        expect(roster.map((m) => m.id), contains(membership.id));
        final rosterEntry = roster.firstWhere((m) => m.id == membership.id);
        expect(rosterEntry.status, MembershipStatus.invited);
      },
    );
  });
}
