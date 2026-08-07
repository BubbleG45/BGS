import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/format.dart';
import '../../widgets/dashboard_section.dart';
import '../../widgets/entity_card.dart';
import '../../widgets/registration_info_card.dart';
import '../../widgets/status_chip.dart';
import '../../widgets/team_crest.dart';
import 'match_detail_screen.dart';
import 'team_detail_screen.dart';

StatusTone _leagueTone(LeagueStatus status) => switch (status) {
      LeagueStatus.active => StatusTone.positive,
      LeagueStatus.draft => StatusTone.neutral,
      LeagueStatus.completed => StatusTone.neutral,
      LeagueStatus.cancelled => StatusTone.negative,
    };

StatusTone _matchTone(MatchStatus status) => switch (status) {
      MatchStatus.completed => StatusTone.positive,
      MatchStatus.scheduled => StatusTone.neutral,
      MatchStatus.cancelled => StatusTone.negative,
    };

class _LeagueDetailData {
  final League league;
  final List<Team> teams;
  final List<Standing> standings;
  final List<ScheduledMatch> matches;

  _LeagueDetailData({
    required this.league,
    required this.teams,
    required this.standings,
    required this.matches,
  });
}

/// Read-only public league page: info, standings, schedule, and team list.
/// Reached from an org homepage or search results.
///
/// The mockups' "Register Now" CTA isn't built -- there's no self-serve
/// league join path today (team membership is invite-only; see
/// BUILD_PLAN.md Phase 4 for the deferred fair/transparent captain
/// registration feature).
class LeagueDetailScreen extends StatefulWidget {
  final UuidValue leagueId;

  const LeagueDetailScreen({super.key, required this.leagueId});

  @override
  State<LeagueDetailScreen> createState() => _LeagueDetailScreenState();
}

class _LeagueDetailScreenState extends State<LeagueDetailScreen> {
  late Future<_LeagueDetailData> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_LeagueDetailData> _load() async {
    final results = await Future.wait([
      client.league.getById(widget.leagueId),
      client.team.listByLeague(widget.leagueId),
      client.standing.listByLeague(widget.leagueId),
      client.scheduledMatch.listByLeague(widget.leagueId),
    ]);

    final league = results[0] as League?;
    if (league == null) {
      throw StateError('League not found');
    }

    return _LeagueDetailData(
      league: league,
      teams: results[1] as List<Team>,
      standings: results[2] as List<Standing>,
      matches: results[3] as List<ScheduledMatch>,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('League')),
      body: FutureBuilder<_LeagueDetailData>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Could not load this league: ${snapshot.error}'));
          }

          final data = snapshot.data!;
          final teamNames = {for (final team in data.teams) team.id: team.name};

          return ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            data.league.name,
                            style: theme.textTheme.headlineLarge,
                          ),
                        ),
                        StatusChip(
                          formatEnumLabel(data.league.status.name),
                          tone: _leagueTone(data.league.status),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      [
                        formatEnumLabel(data.league.sport.name),
                        if (data.league.skillLevel != null)
                          formatEnumLabel(data.league.skillLevel!.name),
                        if (data.league.location != null) data.league.location!,
                      ].join(' · '),
                      style: theme.textTheme.bodyMedium,
                    ),
                    if (data.league.description != null) ...[
                      const SizedBox(height: 8),
                      Text(data.league.description!),
                    ],
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: RegistrationInfoCard(
                  teamFeeCents: data.league.teamFeeCents,
                  seasonStartAt: data.league.seasonStartAt,
                  seasonEndAt: data.league.seasonEndAt,
                  registrationOpensAt: data.league.registrationOpensAt,
                  registrationClosesAt: data.league.registrationClosesAt,
                  rulesUrl: data.league.rulesUrl,
                ),
              ),
              DashboardSection(
                title: 'Standings',
                emptyMessage: 'No results recorded yet.',
                children: [
                  if (data.standings.isNotEmpty)
                    Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text('TEAM', style: theme.textTheme.labelMedium),
                                ),
                                Expanded(
                                  child: Text('W', textAlign: TextAlign.center, style: theme.textTheme.labelMedium),
                                ),
                                Expanded(
                                  child: Text('L', textAlign: TextAlign.center, style: theme.textTheme.labelMedium),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text('PTS', textAlign: TextAlign.end, style: theme.textTheme.labelMedium),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 1),
                          for (final standing in data.standings)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Row(
                                children: [
                                  TeamCrest(
                                    name: teamNames[standing.teamId] ?? '?',
                                    size: 32,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      teamNames[standing.teamId] ?? 'Unknown team',
                                      style: theme.textTheme.bodyLarge,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${standing.wins}',
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${standing.losses}',
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      '${standing.wins * 2 + standing.ties}',
                                      textAlign: TextAlign.end,
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        color: theme.colorScheme.secondary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
              DashboardSection(
                title: 'Schedule',
                emptyMessage: 'No matches scheduled yet.',
                children: [
                  for (final match in data.matches)
                    Card(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MatchDetailScreen(
                              match: match,
                              homeTeamName: teamNames[match.homeTeamId] ?? 'TBD',
                              awayTeamName: teamNames[match.awayTeamId] ?? 'TBD',
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              '${teamNames[match.homeTeamId] ?? 'TBD'} vs '
                              '${teamNames[match.awayTeamId] ?? 'TBD'}',
                            ),
                            subtitle: Text([
                              formatDateTime(match.scheduledAt),
                              if (match.location != null) match.location!,
                              if (match.status == MatchStatus.completed)
                                '${match.homeScore}-${match.awayScore}',
                            ].join(' · ')),
                            trailing: StatusChip(
                              formatEnumLabel(match.status.name),
                              tone: _matchTone(match.status),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              DashboardSection(
                title: 'Teams',
                emptyMessage: 'No teams yet.',
                children: [
                  for (final team in data.teams)
                    EntityCard(
                      leading: TeamCrest(name: team.name, size: 40),
                      title: team.name,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TeamDetailScreen(teamId: team.id!)),
                      ),
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
