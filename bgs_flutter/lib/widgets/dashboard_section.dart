import 'package:flutter/material.dart';

/// A titled group of dashboard rows, with a consistent empty-state message
/// when [children] is empty. Used identically across the Player, Organizer,
/// and Manager dashboard tabs.
class DashboardSection extends StatelessWidget {
  final String title;
  final String emptyMessage;
  final List<Widget> children;

  const DashboardSection({
    super.key,
    required this.title,
    required this.emptyMessage,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          if (children.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                emptyMessage,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            )
          else
            ...children,
        ],
      ),
    );
  }
}
