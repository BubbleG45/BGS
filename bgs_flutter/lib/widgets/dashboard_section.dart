import 'package:flutter/material.dart';

import 'responsive_grid.dart';

/// A titled group of dashboard rows, with a consistent empty-state message
/// when [children] is empty. Used identically across the Player, Organizer,
/// and Manager dashboard tabs. Non-empty [children] are laid out via
/// [ResponsiveGrid] -- 1 column on mobile, more on wider screens.
class DashboardSection extends StatelessWidget {
  final String title;
  final String emptyMessage;
  final List<Widget> children;
  final Widget? trailing;

  const DashboardSection({
    super.key,
    required this.title,
    required this.emptyMessage,
    required this.children,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (trailing != null) trailing!,
            ],
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
            ResponsiveGrid(children: children),
        ],
      ),
    );
  }
}
