import 'package:bgs_client/bgs_client.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../main.dart';
import '../../theme/app_theme.dart';

/// An organization's settings, reached from the owner/admin's Profile
/// screen. Payment setup is a clear placeholder here -- real Stripe
/// Connect onboarding is its own future phase (see BUILD_PLAN.md Phase E);
/// this just gives the feature a real home once it's built, rather than
/// guessing where it belongs later.
class OrgSettingsScreen extends StatelessWidget {
  final UuidValue organizationId;

  const OrgSettingsScreen({super.key, required this.organizationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Organization Settings')),
      body: FutureBuilder<Organization?>(
        future: client.organization.getById(organizationId),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final org = snapshot.data;
          if (org == null) {
            return const Center(child: Text('Organization not found.'));
          }

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              Text(org.name, style: Theme.of(context).textTheme.headlineSmall),
              if (org.description != null) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(org.description!),
              ],
              const SizedBox(height: AppSpacing.xl),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Symbols.payments),
                          const SizedBox(width: AppSpacing.sm),
                          Text('Payments', style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        "Accept payments for your org's leagues and events via Stripe. "
                        'Coming in a future update.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      OutlinedButton(
                        onPressed: null,
                        child: const Text('Set Up Payments'),
                      ),
                    ],
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
