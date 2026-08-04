import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/format.dart';

/// Schedules a match between two of a league's teams. Requires at least two
/// teams to already exist in the league. Pops with `true` on success.
class ScheduleMatchScreen extends StatefulWidget {
  final UuidValue leagueId;
  final String leagueName;

  const ScheduleMatchScreen({super.key, required this.leagueId, required this.leagueName});

  @override
  State<ScheduleMatchScreen> createState() => _ScheduleMatchScreenState();
}

class _ScheduleMatchScreenState extends State<ScheduleMatchScreen> {
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();
  late Future<List<Team>> _teamsFuture;
  UuidValue? _homeTeamId;
  UuidValue? _awayTeamId;
  DateTime? _scheduledAt;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _teamsFuture = client.team.listByLeague(widget.leagueId);
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _scheduledAt ?? now,
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 730)),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_scheduledAt ?? now),
    );
    if (time == null) return;

    setState(() {
      _scheduledAt = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_scheduledAt == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Pick a date and time')));
      return;
    }

    setState(() => _submitting = true);
    try {
      await client.scheduledMatch.create(
        leagueId: widget.leagueId,
        homeTeamId: _homeTeamId!,
        awayTeamId: _awayTeamId!,
        scheduledAt: _scheduledAt!,
        location: _locationController.text.trim().isEmpty
            ? null
            : _locationController.text.trim(),
      );
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      final message = switch (e) {
        SameTeamMatchException() => 'Home and away teams must be different.',
        _ => 'Could not schedule the match: $e',
      };
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Schedule Match -- ${widget.leagueName}')),
      body: FutureBuilder<List<Team>>(
        future: _teamsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Could not load teams: ${snapshot.error}'));
          }

          final teams = snapshot.data!;
          if (teams.length < 2) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'This league needs at least two teams before a match can be scheduled.',
                textAlign: TextAlign.center,
              ),
            );
          }

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                DropdownButtonFormField<UuidValue>(
                  initialValue: _homeTeamId,
                  decoration: const InputDecoration(labelText: 'Home team'),
                  items: [
                    for (final team in teams)
                      DropdownMenuItem(value: team.id, child: Text(team.name)),
                  ],
                  onChanged: (v) => setState(() => _homeTeamId = v),
                  validator: (v) => v == null ? 'Pick a home team' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<UuidValue>(
                  initialValue: _awayTeamId,
                  decoration: const InputDecoration(labelText: 'Away team'),
                  items: [
                    for (final team in teams)
                      DropdownMenuItem(value: team.id, child: Text(team.name)),
                  ],
                  onChanged: (v) => setState(() => _awayTeamId = v),
                  validator: (v) {
                    if (v == null) return 'Pick an away team';
                    if (v == _homeTeamId) return 'Must differ from the home team';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    _scheduledAt == null ? 'Date & time' : formatDateTime(_scheduledAt!),
                  ),
                  trailing: const Icon(Icons.calendar_month),
                  onTap: _pickDateTime,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(labelText: 'Location (optional)'),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _submitting ? null : _submit,
                  child: _submitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Schedule Match'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
