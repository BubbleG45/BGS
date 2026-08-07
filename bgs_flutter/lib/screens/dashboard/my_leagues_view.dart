import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/format.dart';
import '../browse/league_detail_screen.dart';

/// The Leagues nav destination -- every league the signed-in user touches,
/// whether as a player (via team membership) or an organizer. Composed
/// client-side from the same `DashboardEndpoint` calls the Home destination
/// already makes; no new server surface needed.
class MyLeaguesView extends StatefulWidget {
  const MyLeaguesView({super.key});

  @override
  State<MyLeaguesView> createState() => _MyLeaguesViewState();
}

class _MyLeaguesViewState extends State<MyLeaguesView> {
  late Future<List<League>> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<List<League>> _load() async {
    final results = await Future.wait([
      client.dashboard.player(),
      client.dashboard.organizer(),
    ]);
    final player = results[0] as PlayerDashboard;
    final organizer = results[1] as OrganizerDashboard;

    final leagues = <UuidValue, League>{};
    for (final membership in player.teamMemberships) {
      final league = membership.team?.league;
      if (league?.id != null) leagues[league!.id!] = league;
    }
    for (final league in organizer.leagues) {
      if (league.id != null) leagues[league.id!] = league;
    }
    return leagues.values.toList();
  }

  Future<void> _refresh() async {
    final result = await _load();
    if (!mounted) return;
    setState(() => _future = Future.value(result));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder<List<League>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Could not load your leagues: ${snapshot.error}'));
          }

          final leagues = snapshot.data!;
          if (leagues.isEmpty) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    "You're not part of any leagues yet.",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (final league in leagues)
                Card(
                  child: ListTile(
                    title: Text(league.name),
                    subtitle: Text([
                      formatEnumLabel(league.sport.name),
                      if (league.location != null) league.location!,
                    ].join(' · ')),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LeagueDetailScreen(leagueId: league.id!)),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
