import 'package:flutter/material.dart';

/// Central theme definition for the BGS Flutter app.
///
/// No screen should reach for a raw [Color] or hardcoded [TextStyle] --
/// everything should flow through `Theme.of(context)`. [_seedColor] is a
/// neutral placeholder (BGS has no visual design yet, per BUILD_PLAN.md
/// §1) and is meant to be swapped for a real brand color later without
/// touching any screen code.
///
/// This lives inside `bgs_flutter` for now. BUILD_PLAN.md's original
/// architecture calls for a shared design-token package consumed by both
/// Flutter and the Jaspr public site -- that extraction is future work,
/// once the Jaspr side actually has UI to share tokens with.
abstract final class AppTheme {
  static const _seedColor = Color(0xFF00695C);

  static ThemeData get light => _themeFor(Brightness.light);
  static ThemeData get dark => _themeFor(Brightness.dark);

  static ThemeData _themeFor(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: brightness,
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerHighest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
