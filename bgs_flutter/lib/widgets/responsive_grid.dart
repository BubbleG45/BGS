import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Lays out [children] (typically [EntityCard]s) as 1 column on mobile, 2 on
/// tablet, 3 on desktop -- the multi-column card grid pattern `bgs_web`
/// already had in CSS but Flutter never did (no [GridView]/[Wrap]-based
/// layout existed anywhere in the app before this).
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;

  const ResponsiveGrid({super.key, required this.children, this.spacing = AppSpacing.md});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = AppBreakpoints.isDesktop(constraints.maxWidth)
            ? 3
            : AppBreakpoints.isTablet(constraints.maxWidth)
                ? 2
                : 1;

        if (columns == 1) {
          return Column(
            children: [
              for (final child in children) ...[child, SizedBox(height: spacing)],
            ],
          );
        }

        final itemWidth = (constraints.maxWidth - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final child in children) SizedBox(width: itemWidth, child: child),
          ],
        );
      },
    );
  }
}
