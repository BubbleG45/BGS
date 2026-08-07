import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/format.dart';
import '../../widgets/team_crest.dart';

/// Read-only public team page: record, roster. Reached from league detail's
/// team list, search results, or a player's "My Teams" list -- not just the
/// manager's roster-management flow (`team_roster_screen.dart`), which
/// stays separate since it has write actions (invite) this screen doesn't.
///
/// The mockups' `team_detail` chat button isn't built -- no messaging
/// feature exists in the domain (see BUILD_PLAN.md Phase 4).
class TeamDetailScreen extends StatefulWidget {
  final UuidValue teamId;

  const TeamDetailScreen({super.key, required this.teamId});

  @override
  State<TeamDetailScreen> createState() => _TeamDetailScreenState();
}

class _TeamDetailData {
  final Team team;
  final League? league;
  final Standing? standing;
  final List<TeamMembership> roster;

  _TeamDetailData({
    required this.team,
    required this.league,
    required this.standing,
    required this.roster,
  });
}

class _TeamDetailScreenState extends State<TeamDetailScreen> {
  late Future<_TeamDetailData> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_TeamDetailData> _load() async {
    final team = await client.team.getById(widget.teamId);
    if (team == null) throw StateError('Team not found');

    // `getById` doesn't `.include()` the league relation, but the FK
    // itself (`leagueId`) is always set -- every team belongs to exactly
    // one league -- so fetch the league separately rather than relying on
    // `team.league` being populated.
    final results = await Future.wait([
      client.league.getById(team.leagueId),
      client.standing.listByLeague(team.leagueId),
      client.team.listMembers(widget.teamId),
    ]);

    final league = results[0] as League?;
    final standings = results[1] as List<Standing>;
    final roster = results[2] as List<TeamMembership>;
    Standing? standing;
    for (final s in standings) {
      if (s.teamId == widget.teamId) {
        standing = s;
        break;
      }
    }

    return _TeamDetailData(
      team: team,
      league: league,
      standing: standing,
      roster: roster.where((m) => m.status == MembershipStatus.active).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: FutureBuilder<_TeamDetailData>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(child: Text('Could not load this team: ${snapshot.error}')),
            );
          }

          final data = snapshot.data!;
          final league = data.league;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 180,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (league != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              league.name,
                              style: theme.textTheme.labelMedium?.copyWith(color: Colors.white),
                            ),
                          ),
                        const SizedBox(height: 8),
                        Text(
                          data.team.name,
                          style: theme.textTheme.headlineLarge?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    if (data.standing != null)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data.standing!.wins}-${data.standing!.losses}-${data.standing!.ties}',
                                  style: theme.textTheme.headlineMedium,
                                ),
                                Text(
                                  'CURRENT RECORD',
                                  style: theme.textTheme.labelMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 24),
                    Text('Roster', style: theme.textTheme.headlineSmall),
                    const SizedBox(height: 12),
                    if (data.roster.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'No players on this roster yet.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      )
                    else
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          for (final member in data.roster)
                            SizedBox(
                              width: 96,
                              child: Column(
                                children: [
                                  TeamCrest(name: data.team.name, size: 56),
                                  const SizedBox(height: 8),
                                  Text(
                                    formatEnumLabel(member.role.name),
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.labelMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
