import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../utils/format.dart';
import '../../widgets/dashboard_section.dart';
import '../../widgets/status_chip.dart';

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

  const OrganizerDashboardView({super.key, required this.dashboard});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        DashboardSection(
          title: 'My Organizations',
          emptyMessage: "You don't belong to any organizations yet.",
          children: [
            for (final membership in dashboard.organizations)
              _OrganizationTile(membership: membership),
          ],
        ),
        DashboardSection(
          title: 'Leagues',
          emptyMessage: 'No leagues yet.',
          children: [
            for (final league in dashboard.leagues) _LeagueTile(league: league),
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

  const _OrganizationTile({required this.membership});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(membership.organization.name),
        subtitle: membership.organization.description == null
            ? null
            : Text(membership.organization.description!),
        trailing: StatusChip(formatEnumLabel(membership.role.name)),
      ),
    );
  }
}

class _LeagueTile extends StatelessWidget {
  final League league;

  const _LeagueTile({required this.league});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(league.name),
        subtitle: Text([
          formatEnumLabel(league.sport.name),
          if (league.location != null) league.location!,
        ].join(' · ')),
        trailing: StatusChip(
          formatEnumLabel(league.status.name),
          tone: _leagueTone(league.status),
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
