import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central theme definition for the BGS Flutter app.
///
/// No screen should reach for a raw [Color] or hardcoded [TextStyle] --
/// everything should flow through `Theme.of(context)`.
///
/// Colors and typography come from the "Kinetic Stadium" design system
/// (see `stitch_better_group_sports_platform/.../kinetic_stadium/DESIGN.md`)
/// -- BGS's first real visual identity, replacing the neutral placeholder
/// seed color this file used to carry. DESIGN.md's front-matter color keys
/// (`surface`, `on-primary-container`, `surface-tint`, ...) are literally
/// Material 3 [ColorScheme] field names -- it's an exported M3 token set,
/// not a palette to reverse-engineer -- so the light scheme below maps
/// those hex values across 1:1 for pixel accuracy against the mockups
/// (which are all light-mode screenshots). DESIGN.md gives no dark-mode
/// token set, so dark mode stays algorithmic via [ColorScheme.fromSeed],
/// same approach this file always used, just seeded with the real brand
/// color instead of the placeholder.
abstract final class AppTheme {
  // Kinetic Stadium light-mode Material 3 token set, from DESIGN.md.
  static const _primary = Color(0xFF006B5F);
  static const _onPrimary = Color(0xFFFFFFFF);
  static const _primaryContainer = Color(0xFF14B8A6);
  static const _onPrimaryContainer = Color(0xFF00423B);
  static const _secondary = Color(0xFFB90538);
  static const _onSecondary = Color(0xFFFFFFFF);
  static const _secondaryContainer = Color(0xFFDC2C4F);
  static const _onSecondaryContainer = Color(0xFFFFFBFF);
  static const _tertiary = Color(0xFF565E74);
  static const _onTertiary = Color(0xFFFFFFFF);
  static const _tertiaryContainer = Color(0xFF9CA4BD);
  static const _onTertiaryContainer = Color(0xFF323A4F);
  static const _error = Color(0xFFBA1A1A);
  static const _onError = Color(0xFFFFFFFF);
  static const _errorContainer = Color(0xFFFFDAD6);
  static const _onErrorContainer = Color(0xFF93000A);
  static const _surface = Color(0xFFF7F9FB);
  static const _onSurface = Color(0xFF191C1E);
  static const _surfaceDim = Color(0xFFD8DADC);
  static const _surfaceBright = Color(0xFFF7F9FB);
  static const _surfaceContainerLowest = Color(0xFFFFFFFF);
  static const _surfaceContainerLow = Color(0xFFF2F4F6);
  static const _surfaceContainer = Color(0xFFECEEF0);
  static const _surfaceContainerHigh = Color(0xFFE6E8EA);
  static const _surfaceContainerHighest = Color(0xFFE0E3E5);
  static const _onSurfaceVariant = Color(0xFF3C4947);
  static const _outline = Color(0xFF6C7A77);
  static const _outlineVariant = Color(0xFFBBCAC6);
  static const _inverseSurface = Color(0xFF2D3133);
  static const _inverseOnSurface = Color(0xFFEFF1F3);
  static const _inversePrimary = Color(0xFF4FDBC8);
  static const _surfaceTint = Color(0xFF006B5F);
  static const _primaryFixed = Color(0xFF71F8E4);
  static const _onPrimaryFixed = Color(0xFF00201C);
  static const _primaryFixedDim = Color(0xFF4FDBC8);
  static const _onPrimaryFixedVariant = Color(0xFF005048);
  static const _secondaryFixed = Color(0xFFFFDADB);
  static const _onSecondaryFixed = Color(0xFF40000D);
  static const _secondaryFixedDim = Color(0xFFFFB2B7);
  static const _onSecondaryFixedVariant = Color(0xFF92002A);
  static const _tertiaryFixed = Color(0xFFDAE2FD);
  static const _onTertiaryFixed = Color(0xFF131B2E);
  static const _tertiaryFixedDim = Color(0xFFBEC6E0);
  static const _onTertiaryFixedVariant = Color(0xFF3F465C);

  static const _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: _primary,
    onPrimary: _onPrimary,
    primaryContainer: _primaryContainer,
    onPrimaryContainer: _onPrimaryContainer,
    secondary: _secondary,
    onSecondary: _onSecondary,
    secondaryContainer: _secondaryContainer,
    onSecondaryContainer: _onSecondaryContainer,
    tertiary: _tertiary,
    onTertiary: _onTertiary,
    tertiaryContainer: _tertiaryContainer,
    onTertiaryContainer: _onTertiaryContainer,
    error: _error,
    onError: _onError,
    errorContainer: _errorContainer,
    onErrorContainer: _onErrorContainer,
    surface: _surface,
    onSurface: _onSurface,
    surfaceDim: _surfaceDim,
    surfaceBright: _surfaceBright,
    surfaceContainerLowest: _surfaceContainerLowest,
    surfaceContainerLow: _surfaceContainerLow,
    surfaceContainer: _surfaceContainer,
    surfaceContainerHigh: _surfaceContainerHigh,
    surfaceContainerHighest: _surfaceContainerHighest,
    onSurfaceVariant: _onSurfaceVariant,
    outline: _outline,
    outlineVariant: _outlineVariant,
    inverseSurface: _inverseSurface,
    onInverseSurface: _inverseOnSurface,
    inversePrimary: _inversePrimary,
    surfaceTint: _surfaceTint,
    primaryFixed: _primaryFixed,
    onPrimaryFixed: _onPrimaryFixed,
    primaryFixedDim: _primaryFixedDim,
    onPrimaryFixedVariant: _onPrimaryFixedVariant,
    secondaryFixed: _secondaryFixed,
    onSecondaryFixed: _onSecondaryFixed,
    secondaryFixedDim: _secondaryFixedDim,
    onSecondaryFixedVariant: _onSecondaryFixedVariant,
    tertiaryFixed: _tertiaryFixed,
    onTertiaryFixed: _onTertiaryFixed,
    tertiaryFixedDim: _tertiaryFixedDim,
    onTertiaryFixedVariant: _onTertiaryFixedVariant,
  );

  static ThemeData get light => _themeFor(_lightColorScheme);
  static ThemeData get dark => _themeFor(
        ColorScheme.fromSeed(seedColor: _primary, brightness: Brightness.dark),
      );

  static ThemeData _themeFor(ColorScheme colorScheme) {
    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: _textTheme(colorScheme),
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
            // DESIGN.md Shapes: "Standard UI Elements (Buttons, Inputs)
            // use 8px (0.5rem) radius." Individual screens can override
            // this locally (e.g. a pill-shaped hero CTA) where a mockup
            // specifically calls for it.
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerLowest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
    );
  }

  // Anybody (headlines/scores), Be Vietnam Pro (body), Space Grotesk
  // (stats/labels) -- DESIGN.md's three-font system. Colors are set
  // explicitly on every override below rather than left to inherit, so
  // they track the real brand ColorScheme instead of GoogleFonts' plain
  // black/white defaults.
  static TextTheme _textTheme(ColorScheme colorScheme) {
    final brightnessBase = ThemeData(brightness: colorScheme.brightness).textTheme;
    final base = GoogleFonts.beVietnamProTextTheme(brightnessBase);

    return base.copyWith(
      displayLarge: GoogleFonts.anybody(
        fontSize: 72,
        fontWeight: FontWeight.w800,
        height: 1.0,
        letterSpacing: -2.88,
        color: colorScheme.onSurface,
      ),
      headlineLarge: GoogleFonts.anybody(
        fontSize: 40,
        fontWeight: FontWeight.w800,
        height: 1.1,
        letterSpacing: -0.8,
        color: colorScheme.onSurface,
      ),
      headlineMedium: GoogleFonts.anybody(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.17,
        color: colorScheme.onSurface,
      ),
      headlineSmall: GoogleFonts.anybody(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ),
      labelLarge: GoogleFonts.spaceGrotesk(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.4,
        color: colorScheme.onSurface,
      ),
      labelMedium: GoogleFonts.spaceGrotesk(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
        color: colorScheme.onSurfaceVariant,
      ),
      labelSmall: GoogleFonts.spaceGrotesk(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }
}
