import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../theme/app_theme.dart';
import '../../utils/format.dart';
import '../../widgets/dashboard_section.dart';
import '../../widgets/entity_card.dart';
import '../../widgets/team_crest.dart';
import 'event_detail_screen.dart';
import 'league_detail_screen.dart';

class _OrgHomeData {
  final Organization organization;
  final List<League> leagues;
  final List<Event> events;

  _OrgHomeData({required this.organization, required this.leagues, required this.events});
}

/// Read-only public org homepage: info, leagues, and events -- leagues and
/// events split into Active/Upcoming/Past sections (leagues bucket by
/// `status` + `seasonStartAt`; events bucket by `startAt` vs. now).
/// Reached from search results or an organizer's own dashboard.
class OrgHomeScreen extends StatelessWidget {
  final UuidValue organizationId;

  const OrgHomeScreen({super.key, required this.organizationId});

  Future<_OrgHomeData> _load() async {
    final results = await Future.wait([
      client.organization.getById(organizationId),
      client.league.listByOrganization(organizationId),
      client.event.listByOrganization(organizationId),
    ]);

    final organization = results[0] as Organization?;
    if (organization == null) {
      throw StateError('Organization not found');
    }

    return _OrgHomeData(
      organization: organization,
      leagues: results[1] as List<League>,
      events: results[2] as List<Event>,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Organization')),
      body: FutureBuilder<_OrgHomeData>(
        future: _load(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Could not load this organization: ${snapshot.error}'));
          }

          final data = snapshot.data!;
          final now = DateTime.now();

          final pastLeagues = data.leagues.where((l) => l.status == LeagueStatus.completed).toList();
          final upcomingLeagues = data.leagues
              .where(
                (l) =>
                    l.status == LeagueStatus.active &&
                    l.seasonStartAt != null &&
                    l.seasonStartAt!.isAfter(now),
              )
              .toList();
          final activeLeagues = data.leagues
              .where((l) => l.status == LeagueStatus.active && !upcomingLeagues.contains(l))
              .toList();

          final publishedEvents = data.events.where((e) => e.status == EventStatus.published);
          final pastEvents = publishedEvents.where((e) => e.startAt.isBefore(now)).toList();
          final upcomingEvents = publishedEvents.where((e) => e.startAt.isAfter(now)).toList();

          Widget leagueCard(League league) => EntityCard(
                leading: TeamCrest(name: league.name, size: 44),
                title: league.name,
                subtitle: [
                  formatEnumLabel(league.sport.name),
                  if (league.location != null) league.location!,
                ].join(' · '),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LeagueDetailScreen(leagueId: league.id!)),
                ),
              );

          Widget eventCard(Event event) => EntityCard(
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
              );

          return ListView(
            padding: const EdgeInsets.only(bottom: AppSpacing.xl),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.xl,
                  AppSpacing.lg,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.organization.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    if (data.organization.description != null) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Text(data.organization.description!),
                    ],
                  ],
                ),
              ),
              DashboardSection(
                title: 'Active Leagues',
                emptyMessage: 'No active leagues right now.',
                children: [for (final league in activeLeagues) leagueCard(league)],
              ),
              DashboardSection(
                title: 'Upcoming Leagues',
                emptyMessage: 'No upcoming leagues.',
                children: [for (final league in upcomingLeagues) leagueCard(league)],
              ),
              DashboardSection(
                title: 'Past Leagues',
                emptyMessage: 'No past leagues yet.',
                children: [for (final league in pastLeagues) leagueCard(league)],
              ),
              DashboardSection(
                title: 'Upcoming Events',
                emptyMessage: 'No upcoming events.',
                children: [for (final event in upcomingEvents) eventCard(event)],
              ),
              DashboardSection(
                title: 'Past Events',
                emptyMessage: 'No past events yet.',
                children: [for (final event in pastEvents) eventCard(event)],
              ),
            ],
          );
        },
      ),
    );
  }
}
