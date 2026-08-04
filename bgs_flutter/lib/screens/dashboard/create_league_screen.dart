import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/format.dart';

/// Basic league creation form, scoped to a single organization. Pops with
/// `true` on success so the caller can refresh the Organizer dashboard.
class CreateLeagueScreen extends StatefulWidget {
  final UuidValue organizationId;
  final String organizationName;

  const CreateLeagueScreen({
    super.key,
    required this.organizationId,
    required this.organizationName,
  });

  @override
  State<CreateLeagueScreen> createState() => _CreateLeagueScreenState();
}

class _CreateLeagueScreenState extends State<CreateLeagueScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _slugController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _teamFeeController = TextEditingController();
  bool _slugEdited = false;
  bool _submitting = false;
  Sport _sport = Sport.values.first;
  SkillLevel? _skillLevel;

  @override
  void dispose() {
    _nameController.dispose();
    _slugController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _teamFeeController.dispose();
    super.dispose();
  }

  void _onNameChanged(String value) {
    if (_slugEdited) return;
    _slugController.text = slugify(value);
  }

  int? _parseTeamFeeCents() {
    final dollars = double.tryParse(_teamFeeController.text.trim());
    if (dollars == null || dollars < 0) return null;
    return (dollars * 100).round();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);
    try {
      await client.league.create(
        organizationId: widget.organizationId,
        name: _nameController.text.trim(),
        slug: _slugController.text.trim(),
        sport: _sport,
        skillLevel: _skillLevel,
        teamFeeCents: _parseTeamFeeCents()!,
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        location: _locationController.text.trim().isEmpty
            ? null
            : _locationController.text.trim(),
      );
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      final message = e is LeagueSlugTakenException
          ? 'That URL slug is already taken in this organization -- try a different one.'
          : 'Could not create the league: $e';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New League -- ${widget.organizationName}')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: _onNameChanged,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Name is required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _slugController,
              decoration: const InputDecoration(
                labelText: 'URL slug',
                helperText: 'Must be unique within this organization',
              ),
              onChanged: (_) => _slugEdited = true,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Slug is required' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Sport>(
              initialValue: _sport,
              decoration: const InputDecoration(labelText: 'Sport'),
              items: [
                for (final sport in Sport.values)
                  DropdownMenuItem(value: sport, child: Text(formatEnumLabel(sport.name))),
              ],
              onChanged: (v) => setState(() => _sport = v ?? _sport),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<SkillLevel?>(
              initialValue: _skillLevel,
              decoration: const InputDecoration(labelText: 'Skill level (optional)'),
              items: [
                const DropdownMenuItem(value: null, child: Text('Not specified')),
                for (final level in SkillLevel.values)
                  DropdownMenuItem(value: level, child: Text(formatEnumLabel(level.name))),
              ],
              onChanged: (v) => setState(() => _skillLevel = v),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _teamFeeController,
              decoration: const InputDecoration(
                labelText: 'Team fee (USD)',
                prefixText: r'$',
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (v) => _parseTeamFeeCents() == null ? 'Enter a valid amount' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location (optional)'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description (optional)'),
              maxLines: 3,
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
                  : const Text('Create League'),
            ),
          ],
        ),
      ),
    );
  }
}
