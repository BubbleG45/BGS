import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../theme/app_theme.dart';
import '../../utils/format.dart';
import '../../widgets/dashboard_section.dart';
import '../../widgets/entity_card.dart';
import '../../widgets/filter_bar.dart';
import '../../widgets/team_crest.dart';
import 'event_detail_screen.dart';
import 'league_detail_screen.dart';
import 'org_home_screen.dart';

/// Basic search across organizations, active leagues, and published events,
/// by name, sport, and/or location. Results link through to the read-only
/// detail screens.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _queryController = TextEditingController();
  final _locationController = TextEditingController();
  Sport? _sport;
  Future<SearchResults>? _future;

  @override
  void dispose() {
    _queryController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _search() {
    setState(() {
      _future = client.search.search(
        query: _queryController.text.trim().isEmpty ? null : _queryController.text.trim(),
        sport: _sport,
        location: _locationController.text.trim().isEmpty ? null : _locationController.text.trim(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: FilterBar(
              queryController: _queryController,
              queryHint: 'Search organizations, leagues, events',
              locationController: _locationController,
              selectedSport: _sport,
              onSportChanged: (sport) => setState(() => _sport = sport),
              onSearch: _search,
            ),
          ),
          Expanded(
            child: _future == null
                ? const Center(child: Text('Search for an organization, league, or event.'))
                : FutureBuilder<SearchResults>(
                    future: _future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Search failed: ${snapshot.error}'));
                      }

                      final results = snapshot.data!;
                      final noResults = results.organizations.isEmpty &&
                          results.leagues.isEmpty &&
                          results.events.isEmpty;
                      if (noResults) {
                        return const Center(child: Text('No results.'));
                      }

                      return ListView(
                        children: [
                          DashboardSection(
                            title: 'Organizations',
                            emptyMessage: 'No matching organizations.',
                            children: [
                              for (final org in results.organizations)
                                EntityCard(
                                  leading: TeamCrest(name: org.name, size: 44),
                                  title: org.name,
                                  subtitle: org.description,
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => OrgHomeScreen(organizationId: org.id!),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          DashboardSection(
                            title: 'Leagues',
                            emptyMessage: 'No matching leagues.',
                            children: [
                              for (final league in results.leagues)
                                EntityCard(
                                  leading: TeamCrest(name: league.name, size: 44),
                                  title: league.name,
                                  subtitle: formatEnumLabel(league.sport.name),
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => LeagueDetailScreen(leagueId: league.id!),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          DashboardSection(
                            title: 'Events',
                            emptyMessage: 'No matching events.',
                            children: [
                              for (final event in results.events)
                                EntityCard(
                                  leading: TeamCrest(name: event.name, size: 44),
                                  title: event.name,
                                  subtitle: [
                                    formatEnumLabel(event.sport.name),
                                    formatDateTime(event.startAt),
                                  ].join(' · '),
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => EventDetailScreen(eventId: event.id!),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
