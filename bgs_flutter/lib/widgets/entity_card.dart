import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Generic card for an org/league/event/team "tile" -- leading crest/icon,
/// title, one subtitle line, and a trailing row (status chip, menu button,
/// etc). Replaces the near-identical `Card`+`ListTile` markup that used to
/// be hand-rolled per screen (organizer dashboard's org/league/event tiles,
/// manager dashboard's team tiles, search results, league teams, roster,
/// org homepage). Business logic (what the trailing actions do, how the
/// subtitle is formatted) stays at the call site -- this only standardizes
/// the shell.
class EntityCard extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final List<Widget> trailing;
  final VoidCallback? onTap;

  const EntityCard({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing = const [],
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              if (leading != null) ...[leading!, const SizedBox(width: AppSpacing.md)],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing.isNotEmpty) ...[
                const SizedBox(width: AppSpacing.sm),
                Row(mainAxisSize: MainAxisSize.min, children: trailing),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
