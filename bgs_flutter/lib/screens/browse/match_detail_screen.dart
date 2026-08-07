import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../utils/format.dart';
import '../../widgets/status_chip.dart';
import '../../widgets/team_crest.dart';

StatusTone _matchTone(MatchStatus status) => switch (status) {
      MatchStatus.completed => StatusTone.positive,
      MatchStatus.scheduled => StatusTone.neutral,
      MatchStatus.cancelled => StatusTone.negative,
    };

/// Read-only match detail: teams, date/time, location. The mockups' "Add to
/// Calendar" button and live directions map aren't built -- no calendar or
/// maps integration exists (see BUILD_PLAN.md open items).
///
/// Team names are passed in explicitly rather than read from
/// `match.homeTeam`/`match.awayTeam` -- not every caller's `ScheduledMatch`
/// has those relations included (`ScheduledMatchEndpoint.listByLeague`
/// doesn't, `DashboardEndpoint.player`'s `upcomingMatches` does), so relying
/// on the relation silently shows "TBD" for callers that don't include it.
class MatchDetailScreen extends StatelessWidget {
  final ScheduledMatch match;
  final String homeTeamName;
  final String awayTeamName;

  const MatchDetailScreen({
    super.key,
    required this.match,
    required this.homeTeamName,
    required this.awayTeamName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeName = homeTeamName;
    final awayName = awayTeamName;

    return Scaffold(
      appBar: AppBar(title: const Text('Match')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: StatusChip(
              formatEnumLabel(match.status.name),
              tone: _matchTone(match.status),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  children: [
                    TeamCrest(name: homeName, size: 72),
                    const SizedBox(height: 8),
                    Text(
                      homeName,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium,
                    ),
                    if (match.status == MatchStatus.completed)
                      Text('${match.homeScore ?? 0}', style: theme.textTheme.displayLarge?.copyWith(fontSize: 40)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'VS',
                  style: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.secondary),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    TeamCrest(name: awayName, size: 72),
                    const SizedBox(height: 8),
                    Text(
                      awayName,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium,
                    ),
                    if (match.status == MatchStatus.completed)
                      Text('${match.awayScore ?? 0}', style: theme.textTheme.displayLarge?.copyWith(fontSize: 40)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Symbols.calendar_today, color: theme.colorScheme.onSurfaceVariant),
                    const SizedBox(width: 12),
                    Text(formatDateTime(match.scheduledAt), style: theme.textTheme.bodyLarge),
                  ],
                ),
                if (match.location != null) ...[
                  const Divider(height: 24),
                  Row(
                    children: [
                      Icon(Symbols.location_on, color: theme.colorScheme.onSurfaceVariant),
                      const SizedBox(width: 12),
                      Expanded(child: Text(match.location!, style: theme.textTheme.bodyLarge)),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
