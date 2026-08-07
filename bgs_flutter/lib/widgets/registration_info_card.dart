import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/app_theme.dart';
import '../utils/format.dart';

/// Registration-transparency card shared by [LeagueDetailScreen] and
/// [EventDetailScreen]: fee, season window (leagues only), registration
/// window, and a rules link if the organizer set one. Display-only -- no
/// enforcement against the registration window yet (see BUILD_PLAN.md
/// Phase B).
class RegistrationInfoCard extends StatelessWidget {
  final int teamFeeCents;
  final DateTime? seasonStartAt;
  final DateTime? seasonEndAt;
  final DateTime? registrationOpensAt;
  final DateTime? registrationClosesAt;
  final String? rulesUrl;

  const RegistrationInfoCard({
    super.key,
    required this.teamFeeCents,
    this.seasonStartAt,
    this.seasonEndAt,
    this.registrationOpensAt,
    this.registrationClosesAt,
    this.rulesUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget row(IconData icon, String text) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: Text(text, style: theme.textTheme.bodyMedium)),
            ],
          ),
        );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            row(Symbols.payments, 'Team fee: \$${(teamFeeCents / 100).toStringAsFixed(2)}'),
            if (seasonStartAt != null)
              row(
                Symbols.calendar_today,
                'Season: ${formatDateTime(seasonStartAt!)}'
                '${seasonEndAt != null ? ' -- ${formatDateTime(seasonEndAt!)}' : ''}',
              ),
            if (registrationOpensAt != null)
              row(
                Symbols.how_to_reg,
                'Registration opens ${formatDateTime(registrationOpensAt!)}'
                '${registrationClosesAt != null ? ', closes ${formatDateTime(registrationClosesAt!)}' : ''}',
              ),
            if (rulesUrl != null) row(Symbols.gavel, rulesUrl!),
          ],
        ),
      ),
    );
  }
}
