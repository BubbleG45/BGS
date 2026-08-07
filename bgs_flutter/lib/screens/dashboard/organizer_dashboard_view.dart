import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/format.dart';
import '../../widgets/dashboard_section.dart';
import '../../widgets/entity_card.dart';
import '../../widgets/status_chip.dart';
import '../../widgets/team_crest.dart';
import '../browse/event_detail_screen.dart';
import '../browse/org_home_screen.dart';
import 'create_event_screen.dart';
import 'create_league_screen.dart';
import 'create_organization_screen.dart';
import 'league_teams_screen.dart';
import 'schedule_match_screen.dart';

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
/// Tiles use the shared [EntityCard] (leading crest, title/subtitle,
/// trailing status chip + actions) laid out via [DashboardSection]'s
/// [ResponsiveGrid], instead of the bespoke `Card`+`ListTile` markup this
/// screen used to hand-roll three times over.
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

  Future<void> _createEvent(BuildContext context) async {
    final created = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => CreateEventScreen(organizations: dashboard.organizations),
      ),
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
              _OrganizationCard(membership: membership, onRefresh: onRefresh),
          ],
        ),
        DashboardSection(
          title: 'Leagues',
          emptyMessage: 'No leagues yet.',
          children: [
            for (final league in dashboard.leagues)
              _LeagueCard(league: league, onRefresh: onRefresh),
          ],
        ),
        DashboardSection(
          title: 'Events',
          emptyMessage: 'No events yet.',
          trailing: IconButton(
            onPressed: () => _createEvent(context),
            icon: const Icon(Icons.add),
            tooltip: 'New event',
          ),
          children: [
            for (final event in dashboard.events)
              _EventCard(event: event, onRefresh: onRefresh),
          ],
        ),
      ],
    );
  }
}

class _OrganizationCard extends StatelessWidget {
  final OrganizationMembership membership;
  final Future<void> Function() onRefresh;

  const _OrganizationCard({required this.membership, required this.onRefresh});

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
    return EntityCard(
      leading: TeamCrest(name: membership.organization.name, size: 44),
      title: membership.organization.name,
      subtitle: membership.organization.description,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OrgHomeScreen(organizationId: membership.organization.id!),
        ),
      ),
      trailing: [
        StatusChip(formatEnumLabel(membership.role.name)),
        IconButton(
          onPressed: () => _createLeague(context),
          icon: const Icon(Icons.add),
          tooltip: 'New league',
        ),
      ],
    );
  }
}

class _LeagueCard extends StatelessWidget {
  final League league;
  final Future<void> Function() onRefresh;

  const _LeagueCard({required this.league, required this.onRefresh});

  void _openTeams(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LeagueTeamsScreen(leagueId: league.id!, leagueName: league.name),
      ),
    );
  }

  Future<void> _scheduleMatch(BuildContext context) async {
    final scheduled = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ScheduleMatchScreen(leagueId: league.id!, leagueName: league.name),
      ),
    );
    if (scheduled == true) await onRefresh();
  }

  Future<void> _activate(BuildContext context) async {
    try {
      await client.league.activate(league.id!);
      await onRefresh();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not activate the league: $e')));
    }
  }

  Future<void> _complete(BuildContext context) async {
    try {
      await client.league.complete(league.id!);
      await onRefresh();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not complete the league: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return EntityCard(
      leading: TeamCrest(name: league.name, size: 44),
      title: league.name,
      subtitle: [
        formatEnumLabel(league.sport.name),
        if (league.location != null) league.location!,
      ].join(' · '),
      onTap: () => _openTeams(context),
      trailing: [
        StatusChip(
          formatEnumLabel(league.status.name),
          tone: _leagueTone(league.status),
        ),
        PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'teams':
                _openTeams(context);
              case 'schedule':
                _scheduleMatch(context);
              case 'activate':
                _activate(context);
              case 'complete':
                _complete(context);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'teams', child: Text('View / add teams')),
            const PopupMenuItem(value: 'schedule', child: Text('Schedule match')),
            if (league.status == LeagueStatus.draft)
              const PopupMenuItem(value: 'activate', child: Text('Activate league')),
            if (league.status == LeagueStatus.active)
              const PopupMenuItem(value: 'complete', child: Text('Mark season complete')),
          ],
        ),
      ],
    );
  }
}

class _EventCard extends StatelessWidget {
  final Event event;
  final Future<void> Function() onRefresh;

  const _EventCard({required this.event, required this.onRefresh});

  Future<void> _publish(BuildContext context) async {
    try {
      await client.event.publish(event.id!);
      await onRefresh();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not publish the event: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return EntityCard(
      leading: TeamCrest(name: event.name, size: 44),
      title: event.name,
      subtitle: [
        formatEnumLabel(event.sport.name),
        formatDateTime(event.startAt),
      ].join(' · '),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => EventDetailScreen(eventId: event.id!)),
      ),
      trailing: [
        StatusChip(
          formatEnumLabel(event.status.name),
          tone: _eventTone(event.status),
        ),
        if (event.status == EventStatus.draft)
          IconButton(
            onPressed: () => _publish(context),
            icon: const Icon(Icons.publish),
            tooltip: 'Publish',
          ),
      ],
    );
  }
}
