import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../theme/app_theme.dart';
import '../../utils/format.dart';
import '../../widgets/team_crest.dart';
import '../dashboard/invite_player_screen.dart';
import 'match_detail_screen.dart';

/// Read-only public team page: record + standings position, a short
/// schedule summary, roster, and an "invite player" action. Reached from
/// league detail's team list, search results, or a player's "My Teams"
/// list -- not just the manager's roster-management flow
/// (`team_roster_screen.dart`), which stays separate since it's the
/// dedicated full-roster-management screen.
///
/// Standings position is computed client-side (sorted by wins, then point
/// differential) since `Standing` has no rank field -- teams with no
/// recorded games yet are included at 0-0-0 so the position is accurate
/// even before any results exist.
///
/// The mockups' `team_detail` chat button isn't built -- no messaging
/// feature exists in the domain (see BUILD_PLAN.md).
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
  final int? position;
  final int leagueTeamCount;
  final List<ScheduledMatch> upcomingMatches;
  final Map<UuidValue, String> teamNames;
  final List<TeamMembership> roster;

  _TeamDetailData({
    required this.team,
    required this.league,
    required this.standing,
    required this.position,
    required this.leagueTeamCount,
    required this.upcomingMatches,
    required this.teamNames,
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
      client.team.listByLeague(team.leagueId),
      client.scheduledMatch.listByLeague(team.leagueId),
    ]);

    final league = results[0] as League?;
    final standings = results[1] as List<Standing>;
    final roster = results[2] as List<TeamMembership>;
    final leagueTeams = results[3] as List<Team>;
    final matches = results[4] as List<ScheduledMatch>;

    final standingByTeam = {for (final s in standings) s.teamId: s};
    final ranked = leagueTeams
        .map(
          (t) =>
              standingByTeam[t.id] ??
              Standing(leagueId: team.leagueId, teamId: t.id!, wins: 0, losses: 0, ties: 0, pointsFor: 0, pointsAgainst: 0),
        )
        .toList()
      ..sort((a, b) {
        final winsCompare = b.wins.compareTo(a.wins);
        if (winsCompare != 0) return winsCompare;
        return (b.pointsFor - b.pointsAgainst).compareTo(a.pointsFor - a.pointsAgainst);
      });
    final position = ranked.indexWhere((s) => s.teamId == widget.teamId);

    final upcomingMatches = matches
        .where(
          (m) =>
              m.status == MatchStatus.scheduled &&
              (m.homeTeamId == widget.teamId || m.awayTeamId == widget.teamId),
        )
        .toList()
      ..sort((a, b) => a.scheduledAt.compareTo(b.scheduledAt));

    return _TeamDetailData(
      team: team,
      league: league,
      standing: standingByTeam[widget.teamId],
      position: position == -1 ? null : position + 1,
      leagueTeamCount: leagueTeams.length,
      upcomingMatches: upcomingMatches.take(3).toList(),
      teamNames: {for (final t in leagueTeams) t.id!: t.name},
      roster: roster.where((m) => m.status == MembershipStatus.active).toList(),
    );
  }

  Future<void> _refresh() async {
    final data = await _load();
    if (!mounted) return;
    setState(() => _future = Future.value(data));
  }

  Future<void> _invite(BuildContext context, Team team) async {
    final invited = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => InvitePlayerScreen(teamId: team.id!, teamName: team.name),
      ),
    );
    if (invited == true) await _refresh();
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

          return Stack(
            children: [
              CustomScrollView(
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
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(AppRadius.md),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.standing == null
                                        ? '0-0-0'
                                        : '${data.standing!.wins}-${data.standing!.losses}-${data.standing!.ties}',
                                    style: theme.textTheme.headlineMedium,
                                  ),
                                  Text('CURRENT RECORD', style: theme.textTheme.labelMedium),
                                ],
                              ),
                              if (data.position != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '#${data.position}',
                                      style: theme.textTheme.headlineMedium?.copyWith(
                                        color: theme.colorScheme.secondary,
                                      ),
                                    ),
                                    Text(
                                      'OF ${data.leagueTeamCount}',
                                      style: theme.textTheme.labelMedium,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        Text('Upcoming Schedule', style: theme.textTheme.headlineSmall),
                        const SizedBox(height: AppSpacing.md),
                        if (data.upcomingMatches.isEmpty)
                          Text(
                            'No upcoming matches scheduled.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          )
                        else
                          for (final match in data.upcomingMatches)
                            Card(
                              child: ListTile(
                                title: Text(
                                  '${data.teamNames[match.homeTeamId] ?? 'TBD'} vs '
                                  '${data.teamNames[match.awayTeamId] ?? 'TBD'}',
                                ),
                                subtitle: Text(formatDateTime(match.scheduledAt)),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MatchDetailScreen(
                                      match: match,
                                      homeTeamName: data.teamNames[match.homeTeamId] ?? 'TBD',
                                      awayTeamName: data.teamNames[match.awayTeamId] ?? 'TBD',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        const SizedBox(height: AppSpacing.xl),
                        Text('Roster', style: theme.textTheme.headlineSmall),
                        const SizedBox(height: AppSpacing.md),
                        if (data.roster.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                            child: Text(
                              'No players on this roster yet.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          )
                        else
                          Wrap(
                            spacing: AppSpacing.md,
                            runSpacing: AppSpacing.md,
                            children: [
                              for (final member in data.roster)
                                SizedBox(
                                  width: 96,
                                  child: Column(
                                    children: [
                                      TeamCrest(name: data.team.name, size: 56),
                                      const SizedBox(height: AppSpacing.sm),
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
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: FloatingActionButton.extended(
                  onPressed: () => _invite(context, data.team),
                  icon: const Icon(Icons.person_add),
                  label: const Text('Invite'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
