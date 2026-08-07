import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../theme/app_theme.dart';
import '../../utils/format.dart';

/// Lets a team's manager (or an org admin) enter the final score for one of
/// that team's still-`scheduled` matches -- wires up the already-working
/// `ScheduledMatchEndpoint.recordResult`, which just had no screen calling
/// it until now. `recordResult` itself now accepts either org-admin access
/// or an active manager on either side of the match (widened alongside this
/// screen -- see `bgs_server/lib/src/scheduling/scheduled_match_endpoint.dart`).
class RecordMatchResultScreen extends StatefulWidget {
  final UuidValue teamId;
  final String teamName;
  final UuidValue leagueId;

  const RecordMatchResultScreen({
    super.key,
    required this.teamId,
    required this.teamName,
    required this.leagueId,
  });

  @override
  State<RecordMatchResultScreen> createState() => _RecordMatchResultScreenState();
}

class _RecordMatchResultScreenState extends State<RecordMatchResultScreen> {
  late Future<List<ScheduledMatch>> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<List<ScheduledMatch>> _load() async {
    final matches = await client.scheduledMatch.listByLeague(widget.leagueId);
    return matches
        .where(
          (m) =>
              m.status == MatchStatus.scheduled &&
              (m.homeTeamId == widget.teamId || m.awayTeamId == widget.teamId),
        )
        .toList();
  }

  Future<void> _refresh() async {
    final matches = await _load();
    if (!mounted) return;
    setState(() => _future = Future.value(matches));
  }

  Future<void> _recordResult(ScheduledMatch match) async {
    final homeController = TextEditingController();
    final awayController = TextEditingController();

    final submitted = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Record final score'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: homeController,
              decoration: const InputDecoration(labelText: 'Home score'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: awayController,
              decoration: const InputDecoration(labelText: 'Away score'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (submitted != true) return;

    final homeScore = int.tryParse(homeController.text.trim());
    final awayScore = int.tryParse(awayController.text.trim());
    if (homeScore == null || awayScore == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter a whole number for both scores.')));
      return;
    }

    try {
      await client.scheduledMatch.recordResult(
        matchId: match.id!,
        homeScore: homeScore,
        awayScore: awayScore,
      );
      await _refresh();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not record the score: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Record score -- ${widget.teamName}')),
      body: FutureBuilder<List<ScheduledMatch>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Could not load matches: ${snapshot.error}'));
          }

          final matches = snapshot.data!;
          if (matches.isEmpty) {
            return const Center(child: Text('No scheduled matches waiting for a result.'));
          }

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              for (final match in matches)
                Card(
                  child: ListTile(
                    title: Text(formatDateTime(match.scheduledAt)),
                    subtitle: match.location == null ? null : Text(match.location!),
                    trailing: const Icon(Icons.edit),
                    onTap: () => _recordResult(match),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
