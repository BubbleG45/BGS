import 'package:flutter/material.dart';

enum StatusTone { positive, neutral, negative }

/// A small colored label for a status/role value (e.g. "Active", "Invited",
/// "Manager"). Colors come from the theme's [ColorScheme] containers rather
/// than hardcoded values, per the app's no-hardcoded-colors rule.
class StatusChip extends StatelessWidget {
  final String label;
  final StatusTone tone;

  const StatusChip(this.label, {super.key, this.tone = StatusTone.neutral});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final (background, foreground) = switch (tone) {
      StatusTone.positive => (colorScheme.primaryContainer, colorScheme.onPrimaryContainer),
      StatusTone.neutral => (colorScheme.surfaceContainerHighest, colorScheme.onSurfaceVariant),
      StatusTone.negative => (colorScheme.errorContainer, colorScheme.onErrorContainer),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: foreground),
      ),
    );
  }
}
