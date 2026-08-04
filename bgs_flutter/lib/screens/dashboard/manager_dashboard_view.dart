import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../widgets/dashboard_section.dart';
import '../browse/league_detail_screen.dart';

/// "My team(s)" -- backs the Manager tab of [DashboardScreen]. Roster
/// detail for a specific team (via `TeamEndpoint.listMembers`) is a
/// follow-up once team detail screens exist; this is the overview list.
class ManagerDashboardView extends StatelessWidget {
  final ManagerDashboard dashboard;

  const ManagerDashboardView({super.key, required this.dashboard});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        DashboardSection(
          title: 'My Teams',
          emptyMessage: "You don't manage any teams yet.",
          children: [
            for (final membership in dashboard.managedTeams)
              _ManagedTeamTile(membership: membership),
          ],
        ),
      ],
    );
  }
}

class _ManagedTeamTile extends StatelessWidget {
  final TeamMembership membership;

  const _ManagedTeamTile({required this.membership});

  @override
  Widget build(BuildContext context) {
    final team = membership.team;
    final league = team?.league;
    final subtitleParts = [
      if (league != null) league.name,
      if (league?.organization != null) league!.organization!.name,
    ];

    return Card(
      child: ListTile(
        title: Text(team?.name ?? 'Unknown team'),
        subtitle: subtitleParts.isEmpty ? null : Text(subtitleParts.join(' · ')),
        onTap: league == null
            ? null
            : () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => LeagueDetailScreen(leagueId: league.id!)),
                ),
      ),
    );
  }
}
