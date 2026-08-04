import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../utils/format.dart';
import '../../widgets/dashboard_section.dart';
import '../../widgets/status_chip.dart';
import 'create_league_screen.dart';
import 'create_organization_screen.dart';
import 'create_team_screen.dart';

StatusTone _leagueTone(LeagueStatus status) => switch (status) {
      LeagueStatus.active => StatusTone.positive,
      LeagueStatus.draft => StatusTone.neutral,
      LeagueStatus.completed => StatusTone.neutral,
      LeagueStatus.cancelled => StatusTone.negative,
    };

StatusTone _eventTone(EventStatus status) => switch (status) {
      EventStatus.published => StatusTone.positive,
      EventStatus.draft => StatusTone.neutral,
      EventStatus.cancelled => StatusTone.negative,
    };

/// "My orgs/leagues/events" -- backs the Organizer tab of [DashboardScreen].
class OrganizerDashboardView extends StatelessWidget {
  final OrganizerDashboard dashboard;
  final Future<void> Function() onRefresh;

  const OrganizerDashboardView({super.key, required this.dashboard, required this.onRefresh});

  Future<void> _createOrganization(BuildContext context) async {
    final created = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const CreateOrganizationScreen()),
    );
    if (created == true) await onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        DashboardSection(
          title: 'My Organizations',
          emptyMessage: "You don't belong to any organizations yet.",
          trailing: IconButton(
            onPressed: () => _createOrganization(context),
            icon: const Icon(Icons.add),
            tooltip: 'New organization',
          ),
          children: [
            for (final membership in dashboard.organizations)
              _OrganizationTile(membership: membership, onRefresh: onRefresh),
          ],
        ),
        DashboardSection(
          title: 'Leagues',
          emptyMessage: 'No leagues yet.',
          children: [
            for (final league in dashboard.leagues)
              _LeagueTile(league: league, onRefresh: onRefresh),
          ],
        ),
        DashboardSection(
          title: 'Events',
          emptyMessage: 'No events yet.',
          children: [
            for (final event in dashboard.events) _EventTile(event: event),
          ],
        ),
      ],
    );
  }
}

class _OrganizationTile extends StatelessWidget {
  final OrganizationMembership membership;
  final Future<void> Function() onRefresh;

  const _OrganizationTile({required this.membership, required this.onRefresh});

  Future<void> _createLeague(BuildContext context) async {
    final created = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => CreateLeagueScreen(
          organizationId: membership.organization.id!,
          organizationName: membership.organization.name,
        ),
      ),
    );
    if (created == true) await onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(membership.organization.name),
        subtitle: membership.organization.description == null
            ? null
            : Text(membership.organization.description!),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatusChip(formatEnumLabel(membership.role.name)),
            IconButton(
              onPressed: () => _createLeague(context),
              icon: const Icon(Icons.add),
              tooltip: 'New league',
            ),
          ],
        ),
      ),
    );
  }
}

class _LeagueTile extends StatelessWidget {
  final League league;
  final Future<void> Function() onRefresh;

  const _LeagueTile({required this.league, required this.onRefresh});

  Future<void> _createTeam(BuildContext context) async {
    final created = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => CreateTeamScreen(leagueId: league.id!, leagueName: league.name),
      ),
    );
    if (created == true) await onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(league.name),
        subtitle: Text([
          formatEnumLabel(league.sport.name),
          if (league.location != null) league.location!,
        ].join(' · ')),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatusChip(
              formatEnumLabel(league.status.name),
              tone: _leagueTone(league.status),
            ),
            IconButton(
              onPressed: () => _createTeam(context),
              icon: const Icon(Icons.add),
              tooltip: 'New team',
            ),
          ],
        ),
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  final Event event;

  const _EventTile({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(event.name),
        subtitle: Text([
          formatEnumLabel(event.sport.name),
          formatDateTime(event.startAt),
        ].join(' · ')),
        trailing: StatusChip(
          formatEnumLabel(event.status.name),
          tone: _eventTone(event.status),
        ),
      ),
    );
  }
}
