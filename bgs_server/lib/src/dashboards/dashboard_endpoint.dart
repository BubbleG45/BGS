import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

import '../generated/protocol.dart';

/// Composed, self-scoped reads backing the three dashboards from
/// BUILD_PLAN.md §6. Deliberately server-side rather than assembled
/// client-side, to keep the Flutter app thin and avoid N+1-style chains of
/// calls from the client for what's fundamentally one screen's worth of
/// data.
///
/// No writes and no new typed exceptions here -- everything is a read
/// scoped to the calling user via `session.authenticated`, composed from
/// tables that already exist.
class DashboardEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// "My teams/events" -- team memberships (any status, so pending invites
  /// show up too), event registrations, and upcoming matches for teams the
  /// player is actively on.
  Future<PlayerDashboard> player(Session session) async {
    final authUserId = session.authenticated!.authUserId;

    final teamMemberships = await TeamMembership.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      include: TeamMembership.include(
        team: Team.include(
          league: League.include(organization: Organization.include()),
        ),
      ),
      orderBy: (t) => t.invitedAt,
      orderDescending: true,
    );

    final eventRegistrations = await EventRegistration.db.find(
      session,
      where: (t) => t.registeredByAuthUserId.equals(authUserId),
      include: EventRegistration.include(event: Event.include()),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );

    final activeTeamIds = teamMemberships
        .where((m) => m.status == MembershipStatus.active)
        .map((m) => m.teamId)
        .toSet();

    final upcomingMatches = await ScheduledMatch.db.find(
      session,
      where: (t) =>
          (t.homeTeamId.inSet(activeTeamIds) |
              t.awayTeamId.inSet(activeTeamIds)) &
          t.status.equals(MatchStatus.scheduled),
      include: ScheduledMatch.include(homeTeam: Team.include(), awayTeam: Team.include()),
      orderBy: (t) => t.scheduledAt,
      limit: 10,
    );

    return PlayerDashboard(
      teamMemberships: teamMemberships,
      eventRegistrations: eventRegistrations,
      upcomingMatches: upcomingMatches,
    );
  }

  /// "My orgs/leagues/events" -- organizations the caller is a member of
  /// (with their role), leagues across those orgs, and events (org-scoped
  /// across those orgs, plus any orgless events the caller created).
  Future<OrganizerDashboard> organizer(Session session) async {
    final authUserId = session.authenticated!.authUserId;

    final orgMemberships = await OrganizationMember.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      include: OrganizationMember.include(organization: Organization.include()),
    );

    final organizations = [
      for (final membership in orgMemberships)
        OrganizationMembership(
          organization: membership.organization!,
          role: membership.role,
        ),
    ];

    final orgIds = orgMemberships.map((m) => m.organizationId).toSet();

    final leagues = await League.db.find(
      session,
      where: (t) => t.organizationId.inSet(orgIds),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );

    final events = await Event.db.find(
      session,
      where: (t) =>
          t.organizationId.inSet(orgIds) |
          (t.organizationId.equals(null) &
              t.createdByAuthUserId.equals(authUserId)),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );

    return OrganizerDashboard(
      organizations: organizations,
      leagues: leagues,
      events: events,
    );
  }

  /// "My team(s)" -- the teams the caller actively manages.
  Future<ManagerDashboard> manager(Session session) async {
    final authUserId = session.authenticated!.authUserId;

    final managedTeams = await TeamMembership.db.find(
      session,
      where: (t) =>
          t.authUserId.equals(authUserId) &
          t.role.equals(TeamMemberRole.manager) &
          t.status.equals(MembershipStatus.active),
      include: TeamMembership.include(
        team: Team.include(
          league: League.include(organization: Organization.include()),
        ),
      ),
      orderBy: (t) => t.invitedAt,
      orderDescending: true,
    );

    return ManagerDashboard(managedTeams: managedTeams);
  }
}
