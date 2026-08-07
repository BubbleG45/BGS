import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../widgets/team_crest.dart';
import '../browse/team_detail_screen.dart';

/// The Teams nav destination -- every team the signed-in user belongs to,
/// whether as a player or a manager. Composed client-side from the same
/// `DashboardEndpoint` calls the Home destination already makes; no new
/// server surface needed.
class MyTeamsView extends StatefulWidget {
  const MyTeamsView({super.key});

  @override
  State<MyTeamsView> createState() => _MyTeamsViewState();
}

class _MyTeamsViewState extends State<MyTeamsView> {
  late Future<List<Team>> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<List<Team>> _load() async {
    final results = await Future.wait([
      client.dashboard.player(),
      client.dashboard.manager(),
    ]);
    final player = results[0] as PlayerDashboard;
    final manager = results[1] as ManagerDashboard;

    final teams = <UuidValue, Team>{};
    for (final membership in player.teamMemberships) {
      final team = membership.team;
      if (team?.id != null) teams[team!.id!] = team;
    }
    for (final membership in manager.managedTeams) {
      final team = membership.team;
      if (team?.id != null) teams[team!.id!] = team;
    }
    return teams.values.toList();
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
      child: FutureBuilder<List<Team>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Could not load your teams: ${snapshot.error}'));
          }

          final teams = snapshot.data!;
          if (teams.isEmpty) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    "You're not on any teams yet.",
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
              for (final team in teams)
                Card(
                  child: ListTile(
                    leading: TeamCrest(name: team.name, size: 40),
                    title: Text(team.name),
                    subtitle: team.league?.name == null ? null : Text(team.league!.name),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TeamDetailScreen(teamId: team.id!)),
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
