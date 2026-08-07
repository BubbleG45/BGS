import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../theme/app_theme.dart';
import '../../utils/format.dart';

/// Lets a team's manager (or an org admin) pick one of that team's matches,
/// then mark each active roster member present/absent -- the "lightweight
/// v1" attendance checklist. Roster rows show role + invited date rather
/// than a name, same limitation as `TeamRosterScreen` (`TeamMembership`
/// carries no display name -- see BUILD_PLAN.md).
class TakeAttendanceScreen extends StatefulWidget {
  final UuidValue teamId;
  final String teamName;
  final UuidValue leagueId;

  const TakeAttendanceScreen({
    super.key,
    required this.teamId,
    required this.teamName,
    required this.leagueId,
  });

  @override
  State<TakeAttendanceScreen> createState() => _TakeAttendanceScreenState();
}

class _TakeAttendanceScreenState extends State<TakeAttendanceScreen> {
  late Future<List<ScheduledMatch>> _matchesFuture;

  @override
  void initState() {
    super.initState();
    _matchesFuture = _loadMatches();
  }

  Future<List<ScheduledMatch>> _loadMatches() async {
    final matches = await client.scheduledMatch.listByLeague(widget.leagueId);
    return matches
        .where((m) => m.homeTeamId == widget.teamId || m.awayTeamId == widget.teamId)
        .toList()
      ..sort((a, b) => b.scheduledAt.compareTo(a.scheduledAt));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance -- ${widget.teamName}')),
      body: FutureBuilder<List<ScheduledMatch>>(
        future: _matchesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Could not load matches: ${snapshot.error}'));
          }

          final matches = snapshot.data!;
          if (matches.isEmpty) {
            return const Center(child: Text('No matches for this team yet.'));
          }

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              for (final match in matches)
                Card(
                  child: ListTile(
                    title: Text(formatDateTime(match.scheduledAt)),
                    subtitle: Text(formatEnumLabel(match.status.name)),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => _AttendanceChecklistScreen(
                          teamId: widget.teamId,
                          match: match,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _AttendanceChecklistScreen extends StatefulWidget {
  final UuidValue teamId;
  final ScheduledMatch match;

  const _AttendanceChecklistScreen({required this.teamId, required this.match});

  @override
  State<_AttendanceChecklistScreen> createState() => _AttendanceChecklistScreenState();
}

class _AttendanceChecklistScreenState extends State<_AttendanceChecklistScreen> {
  late Future<
      ({List<TeamMembership> roster, Map<UuidValue, AttendanceStatus> attendance})
  > _future;
  final _saving = <UuidValue>{};

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<({List<TeamMembership> roster, Map<UuidValue, AttendanceStatus> attendance})> _load() async {
    final results = await Future.wait([
      client.team.listMembers(widget.teamId),
      client.attendance.listForMatch(matchId: widget.match.id!, teamId: widget.teamId),
    ]);
    final roster = (results[0] as List<TeamMembership>)
        .where((m) => m.status == MembershipStatus.active)
        .toList();
    final records = results[1] as List<MatchAttendance>;
    final attendance = {for (final record in records) record.teamMembershipId: record.status};
    return (roster: roster, attendance: attendance);
  }

  Future<void> _setStatus(UuidValue membershipId, AttendanceStatus status) async {
    setState(() => _saving.add(membershipId));
    try {
      await client.attendance.record(
        matchId: widget.match.id!,
        teamMembershipId: membershipId,
        status: status,
      );
      final data = await _future;
      if (!mounted) return;
      setState(() {
        _future = Future.value((
          roster: data.roster,
          attendance: {...data.attendance, membershipId: status},
        ));
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not save attendance: $e')));
    } finally {
      if (mounted) setState(() => _saving.remove(membershipId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(formatDateTime(widget.match.scheduledAt))),
      body: FutureBuilder<({List<TeamMembership> roster, Map<UuidValue, AttendanceStatus> attendance})>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Could not load the roster: ${snapshot.error}'));
          }

          final data = snapshot.data!;
          if (data.roster.isEmpty) {
            return const Center(child: Text('No active roster members yet.'));
          }

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              for (final membership in data.roster)
                Card(
                  child: ListTile(
                    title: Text(formatEnumLabel(membership.role.name)),
                    subtitle: Text('Joined ${membership.joinedAt != null ? formatDateTime(membership.joinedAt!) : 'recently'}'),
                    trailing: _saving.contains(membership.id)
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : SegmentedButton<AttendanceStatus>(
                            segments: const [
                              ButtonSegment(value: AttendanceStatus.present, label: Text('Present')),
                              ButtonSegment(value: AttendanceStatus.absent, label: Text('Absent')),
                            ],
                            selected: {
                              if (data.attendance[membership.id] != null) data.attendance[membership.id]!,
                            },
                            emptySelectionAllowed: true,
                            onSelectionChanged: (selected) {
                              if (selected.isEmpty) return;
                              _setStatus(membership.id!, selected.first);
                            },
                          ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
