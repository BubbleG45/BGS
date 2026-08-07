import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../widgets/dashboard_section.dart';
import '../../widgets/entity_card.dart';
import '../../widgets/team_crest.dart';
import '../browse/league_detail_screen.dart';
import 'record_match_result_screen.dart';
import 'take_attendance_screen.dart';

/// "My team(s)" -- backs the Manager tab of [DashboardScreen]. Each card's
/// menu gives the actual manager functions: recording a final score
/// (already-working `recordResult`, just needed a screen) and taking
/// attendance (new, lightweight v1 -- present/absent per roster member).
/// Tapping the card itself goes to the league page for schedule/standings,
/// since those are already fully built there.
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
              _ManagedTeamCard(membership: membership),
          ],
        ),
      ],
    );
  }
}

class _ManagedTeamCard extends StatelessWidget {
  final TeamMembership membership;

  const _ManagedTeamCard({required this.membership});

  @override
  Widget build(BuildContext context) {
    final team = membership.team;
    final league = team?.league;
    final subtitleParts = [
      if (league != null) league.name,
      if (league?.organization != null) league!.organization!.name,
    ];

    return EntityCard(
      leading: TeamCrest(name: team?.name ?? '?', size: 44),
      title: team?.name ?? 'Unknown team',
      subtitle: subtitleParts.isEmpty ? null : subtitleParts.join(' · '),
      onTap: league == null
          ? null
          : () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LeagueDetailScreen(leagueId: league.id!)),
              ),
      trailing: [
        if (team != null && league != null)
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'score':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RecordMatchResultScreen(
                        teamId: team.id!,
                        teamName: team.name,
                        leagueId: league.id!,
                      ),
                    ),
                  );
                case 'attendance':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TakeAttendanceScreen(
                        teamId: team.id!,
                        teamName: team.name,
                        leagueId: league.id!,
                      ),
                    ),
                  );
                case 'schedule':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LeagueDetailScreen(leagueId: league.id!)),
                  );
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'score', child: Text('Record score')),
              PopupMenuItem(value: 'attendance', child: Text('Take attendance')),
              PopupMenuItem(value: 'schedule', child: Text('Schedule / standings')),
            ],
          ),
      ],
    );
  }
}
