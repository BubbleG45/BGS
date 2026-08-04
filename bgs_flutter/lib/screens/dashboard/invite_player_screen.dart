import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/format.dart';

/// Invites an existing BGS user (by email) to a team. Pops with `true` on
/// success so the caller can refresh the team roster.
class InvitePlayerScreen extends StatefulWidget {
  final UuidValue teamId;
  final String teamName;

  const InvitePlayerScreen({super.key, required this.teamId, required this.teamName});

  @override
  State<InvitePlayerScreen> createState() => _InvitePlayerScreenState();
}

class _InvitePlayerScreenState extends State<InvitePlayerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  TeamMemberRole _role = TeamMemberRole.player;
  bool _submitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);
    try {
      await client.team.invitePlayer(
        teamId: widget.teamId,
        email: _emailController.text.trim(),
        role: _role,
      );
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      final message = switch (e) {
        PlayerNotFoundException() => "No BGS account found for that email.",
        TeamMembershipAlreadyExistsException() =>
          'That player has already been invited to this team.',
        _ => 'Could not send the invite: $e',
      };
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Invite Player -- ${widget.teamName}')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                helperText: 'Must belong to an existing BGS account',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Email is required' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<TeamMemberRole>(
              initialValue: _role,
              decoration: const InputDecoration(labelText: 'Role'),
              items: [
                for (final role in TeamMemberRole.values)
                  DropdownMenuItem(value: role, child: Text(formatEnumLabel(role.name))),
              ],
              onChanged: (v) => setState(() => _role = v ?? _role),
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
                  : const Text('Send Invite'),
            ),
          ],
        ),
      ),
    );
  }
}
