import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/format.dart';
import '../../widgets/dashboard_section.dart';
import '../../widgets/status_chip.dart';
import 'event_detail_screen.dart';
import 'league_detail_screen.dart';

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

class _OrgHomeData {
  final Organization organization;
  final List<League> leagues;
  final List<Event> events;

  _OrgHomeData({required this.organization, required this.leagues, required this.events});
}

/// Read-only public org homepage: info, leagues, and events. Reached from
/// search results or an organizer's own dashboard.
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

          return ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.organization.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    if (data.organization.description != null) ...[
                      const SizedBox(height: 8),
                      Text(data.organization.description!),
                    ],
                  ],
                ),
              ),
              DashboardSection(
                title: 'Leagues',
                emptyMessage: 'No leagues yet.',
                children: [
                  for (final league in data.leagues)
                    Card(
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
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LeagueDetailScreen(leagueId: league.id!),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              DashboardSection(
                title: 'Events',
                emptyMessage: 'No events yet.',
                children: [
                  for (final event in data.events)
                    Card(
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
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EventDetailScreen(eventId: event.id!),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
