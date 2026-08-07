import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../theme/app_theme.dart';
import '../../utils/format.dart';
import '../../widgets/registration_info_card.dart';
import '../../widgets/status_chip.dart';

StatusTone _eventTone(EventStatus status) => switch (status) {
      EventStatus.published => StatusTone.positive,
      EventStatus.draft => StatusTone.neutral,
      EventStatus.cancelled => StatusTone.negative,
    };

class _EventDetailData {
  final Event event;
  final EventRegistration? myRegistration;
  final List<EventRegistration> registrations;

  _EventDetailData({
    required this.event,
    required this.myRegistration,
    required this.registrations,
  });
}

/// Read-only public event page, plus register/cancel-registration for the
/// signed-in user. Reached from an org homepage, search results, or the
/// Organizer/Player dashboards.
class EventDetailScreen extends StatefulWidget {
  final UuidValue eventId;

  const EventDetailScreen({super.key, required this.eventId});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  final _teamNameController = TextEditingController();
  late Future<_EventDetailData> _future;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    super.dispose();
  }

  Future<_EventDetailData> _load() async {
    final results = await Future.wait([
      client.event.getById(widget.eventId),
      client.event.listMyRegistrations(),
      client.public.registrationsByEvent(widget.eventId),
    ]);

    final event = results[0] as Event?;
    if (event == null) {
      throw StateError('Event not found');
    }
    final myRegistrations = results[1] as List<EventRegistration>;
    EventRegistration? myRegistration;
    for (final registration in myRegistrations) {
      if (registration.eventId == widget.eventId &&
          registration.status == EventRegistrationStatus.registered) {
        myRegistration = registration;
        break;
      }
    }

    return _EventDetailData(
      event: event,
      myRegistration: myRegistration,
      registrations: results[2] as List<EventRegistration>,
    );
  }

  Future<void> _refresh() async {
    final data = await _load();
    if (!mounted) return;
    setState(() {
      _future = Future.value(data);
    });
  }

  Future<void> _register() async {
    setState(() => _submitting = true);
    try {
      await client.event.register(
        eventId: widget.eventId,
        teamName: _teamNameController.text.trim().isEmpty
            ? null
            : _teamNameController.text.trim(),
      );
      await _refresh();
    } catch (e) {
      if (!mounted) return;
      final message = e is EventRegistrationAlreadyExistsException
          ? 'You are already registered for this event.'
          : 'Could not register: $e';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _cancelRegistration(UuidValue registrationId) async {
    setState(() => _submitting = true);
    try {
      await client.event.cancelRegistration(registrationId);
      await _refresh();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not cancel: $e')));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event')),
      body: FutureBuilder<_EventDetailData>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Could not load this event: ${snapshot.error}'));
          }

          final data = snapshot.data!;
          final event = data.event;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(event.name, style: Theme.of(context).textTheme.headlineSmall),
                  ),
                  StatusChip(
                    formatEnumLabel(event.status.name),
                    tone: _eventTone(event.status),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                [
                  formatEnumLabel(event.sport.name),
                  if (event.skillLevel != null) formatEnumLabel(event.skillLevel!.name),
                ].join(' · '),
              ),
              const SizedBox(height: 4),
              Text(formatDateTime(event.startAt)),
              if (event.location != null) ...[
                const SizedBox(height: 4),
                Text(event.location!),
              ],
              if (event.isTournament) ...[
                const SizedBox(height: 4),
                const Text('Tournament (bracket-based)'),
              ],
              if (event.description != null) ...[
                const SizedBox(height: 12),
                Text(event.description!),
              ],
              const SizedBox(height: AppSpacing.lg),
              RegistrationInfoCard(
                teamFeeCents: event.teamFeeCents,
                registrationOpensAt: event.registrationOpensAt,
                registrationClosesAt: event.registrationClosesAt,
                rulesUrl: event.rulesUrl,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                "Who's signed up (${data.registrations.length})",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              data.registrations.isEmpty
                  ? Text(
                      'No one has registered yet.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    )
                  : Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: [
                        for (final registration in data.registrations)
                          Chip(label: Text(registration.teamName ?? 'A player')),
                      ],
                    ),
              const SizedBox(height: AppSpacing.xl),
              if (event.status != EventStatus.published)
                const Text('Registration is not open for this event.')
              else if (data.myRegistration != null) ...[
                Text(
                  data.myRegistration!.teamName == null
                      ? "You're registered for this event."
                      : "You're registered as \"${data.myRegistration!.teamName}\".",
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: _submitting
                      ? null
                      : () => _cancelRegistration(data.myRegistration!.id!),
                  child: _submitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Cancel Registration'),
                ),
              ] else ...[
                TextFormField(
                  controller: _teamNameController,
                  decoration: const InputDecoration(labelText: 'Team/group name (optional)'),
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: _submitting ? null : _register,
                  child: _submitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Register'),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
