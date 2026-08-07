import 'package:flutter/material.dart';

/// A small "trading card" team badge: a colored squircle with the team's
/// 1-2 letter initials, matching DESIGN.md's "Team Crests" component (no
/// team logo upload exists yet, so this is the stand-in identity mark used
/// everywhere a team shows up -- dashboards, match tiles, team detail).
class TeamCrest extends StatelessWidget {
  final String name;
  final double size;

  const TeamCrest({super.key, required this.name, this.size = 56});

  String get _initials {
    final words = name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    if (words.isEmpty) return '?';
    if (words.length == 1) {
      return words.first.substring(0, words.first.length.clamp(0, 2)).toUpperCase();
    }
    return (words[0][0] + words[1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final palette = [
      (colorScheme.primaryContainer, colorScheme.onPrimaryContainer),
      (colorScheme.secondaryContainer, colorScheme.onSecondaryContainer),
      (colorScheme.tertiaryContainer, colorScheme.onTertiaryContainer),
    ];
    final seed = name.codeUnits.fold<int>(0, (sum, unit) => sum + unit);
    final (background, foreground) = palette[seed % palette.length];

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(size * 0.32),
      ),
      child: Text(
        _initials,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: foreground,
              fontSize: size * 0.36,
            ),
      ),
    );
  }
}
