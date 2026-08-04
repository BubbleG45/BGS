import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/format.dart';
import '../../widgets/dashboard_section.dart';
import 'event_detail_screen.dart';
import 'league_detail_screen.dart';
import 'org_home_screen.dart';

/// Basic search across organizations, active leagues, and published events,
/// by name and/or sport. Results link through to the read-only detail
/// screens.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _queryController = TextEditingController();
  Sport? _sport;
  Future<SearchResults>? _future;

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  void _search() {
    setState(() {
      _future = client.search.search(
        query: _queryController.text.trim().isEmpty ? null : _queryController.text.trim(),
        sport: _sport,
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
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _queryController,
                  decoration: const InputDecoration(
                    labelText: 'Search organizations, leagues, events',
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (_) => _search(),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<Sport?>(
                        initialValue: _sport,
                        decoration: const InputDecoration(labelText: 'Sport'),
                        items: [
                          const DropdownMenuItem(value: null, child: Text('Any sport')),
                          for (final sport in Sport.values)
                            DropdownMenuItem(
                              value: sport,
                              child: Text(formatEnumLabel(sport.name)),
                            ),
                        ],
                        onChanged: (v) => setState(() => _sport = v),
                      ),
                    ),
                    const SizedBox(width: 12),
                    FilledButton(onPressed: _search, child: const Text('Search')),
                  ],
                ),
              ],
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
                                Card(
                                  child: ListTile(
                                    title: Text(org.name),
                                    subtitle: org.description == null
                                        ? null
                                        : Text(org.description!),
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            OrgHomeScreen(organizationId: org.id!),
                                      ),
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
                                Card(
                                  child: ListTile(
                                    title: Text(league.name),
                                    subtitle: Text(formatEnumLabel(league.sport.name)),
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            LeagueDetailScreen(leagueId: league.id!),
                                      ),
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
                                Card(
                                  child: ListTile(
                                    title: Text(event.name),
                                    subtitle: Text([
                                      formatEnumLabel(event.sport.name),
                                      formatDateTime(event.startAt),
                                    ].join(' · ')),
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
          ),
        ],
      ),
    );
  }
}
