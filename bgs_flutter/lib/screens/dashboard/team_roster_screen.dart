import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/format.dart';
import '../../widgets/dashboard_tab_view.dart';
import '../../widgets/status_chip.dart';
import 'invite_player_screen.dart';

StatusTone _membershipTone(MembershipStatus status) => switch (status) {
      MembershipStatus.active => StatusTone.positive,
      MembershipStatus.invited => StatusTone.neutral,
      MembershipStatus.declined => StatusTone.negative,
    };

/// A team's roster (all memberships, any status), with an "invite player"
/// action. Reached from [LeagueTeamsScreen].
class TeamRosterScreen extends StatelessWidget {
  final UuidValue teamId;
  final String teamName;

  const TeamRosterScreen({super.key, required this.teamId, required this.teamName});

  Future<void> _invite(BuildContext context, Future<void> Function() refresh) async {
    final invited = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => InvitePlayerScreen(teamId: teamId, teamName: teamName),
      ),
    );
    if (invited == true) await refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(teamName)),
      body: DashboardTabView<List<TeamMembership>>(
        fetch: () => client.team.listMembers(teamId),
        builder: (context, members, refresh) => Stack(
          children: [
            members.isEmpty
                ? ListView(
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          'No players on this roster yet.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                : ListView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
                    children: [
                      for (final membership in members) _MemberTile(membership: membership),
                    ],
                  ),
            Positioned(
              right: 16,
              bottom: 16,
              child: FloatingActionButton(
                onPressed: () => _invite(context, refresh),
                tooltip: 'Invite player',
                child: const Icon(Icons.person_add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemberTile extends StatelessWidget {
  final TeamMembership membership;

  const _MemberTile({required this.membership});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(formatEnumLabel(membership.role.name)),
        subtitle: Text('Invited ${formatDateTime(membership.invitedAt)}'),
        trailing: StatusChip(
          formatEnumLabel(membership.status.name),
          tone: _membershipTone(membership.status),
        ),
      ),
    );
  }
}
