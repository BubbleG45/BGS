import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../widgets/dashboard_tab_view.dart';
import 'create_team_screen.dart';
import 'team_roster_screen.dart';

/// A league's teams, with "create team" and "view roster / invite" actions.
/// Reached by tapping a league on the Organizer dashboard.
class LeagueTeamsScreen extends StatelessWidget {
  final UuidValue leagueId;
  final String leagueName;

  const LeagueTeamsScreen({super.key, required this.leagueId, required this.leagueName});

  Future<void> _createTeam(BuildContext context, Future<void> Function() refresh) async {
    final created = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => CreateTeamScreen(leagueId: leagueId, leagueName: leagueName),
      ),
    );
    if (created == true) await refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(leagueName)),
      body: DashboardTabView<List<Team>>(
        fetch: () => client.team.listByLeague(leagueId),
        builder: (context, teams, refresh) => Stack(
          children: [
            teams.isEmpty
                ? ListView(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(24),
                        child: Text('No teams in this league yet.', textAlign: TextAlign.center),
                      ),
                    ],
                  )
                : ListView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
                    children: [
                      for (final team in teams)
                        Card(
                          child: ListTile(
                            title: Text(team.name),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TeamRosterScreen(
                                  teamId: team.id!,
                                  teamName: team.name,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
            Positioned(
              right: 16,
              bottom: 16,
              child: FloatingActionButton(
                onPressed: () => _createTeam(context, refresh),
                tooltip: 'New team',
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
