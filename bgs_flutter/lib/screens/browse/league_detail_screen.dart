import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/format.dart';
import '../../widgets/dashboard_section.dart';
import '../../widgets/status_chip.dart';

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
                            style: Theme.of(context).textTheme.headlineSmall,
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
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (data.league.description != null) ...[
                      const SizedBox(height: 8),
                      Text(data.league.description!),
                    ],
                  ],
                ),
              ),
              DashboardSection(
                title: 'Standings',
                emptyMessage: 'No results recorded yet.',
                children: [
                  for (final standing in data.standings)
                    Card(
                      child: ListTile(
                        title: Text(teamNames[standing.teamId] ?? 'Unknown team'),
                        subtitle: Text('PF ${standing.pointsFor} · PA ${standing.pointsAgainst}'),
                        trailing: Text(
                          '${standing.wins}-${standing.losses}-${standing.ties}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
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
                      child: ListTile(
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
                ],
              ),
              DashboardSection(
                title: 'Teams',
                emptyMessage: 'No teams yet.',
                children: [
                  for (final team in data.teams)
                    Card(child: ListTile(title: Text(team.name))),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
