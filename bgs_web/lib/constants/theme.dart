import 'package:jaspr/dom.dart';

/// "Kinetic Stadium" design tokens for `bgs_web`.
///
/// Values are transcribed 1:1 from `bgs_flutter/lib/theme/app_theme.dart`,
/// which already ported the same Material 3 token set from
/// `stitch_better_group_sports_platform/.../kinetic_stadium/DESIGN.md`.
/// Light mode only -- DESIGN.md gives no dark palette, and this site has no
/// dark-mode handling today.
abstract final class BgsColors {
  static const primary = Color('#006B5F');
  static const onPrimary = Color('#FFFFFF');
  static const primaryContainer = Color('#14B8A6');
  static const onPrimaryContainer = Color('#00423B');
  static const secondary = Color('#B90538');
  static const onSecondary = Color('#FFFFFF');
  static const secondaryContainer = Color('#DC2C4F');
  static const tertiary = Color('#565E74');
  static const surface = Color('#F7F9FB');
  static const onSurface = Color('#191C1E');
  static const surfaceContainerLowest = Color('#FFFFFF');
  static const surfaceContainerLow = Color('#F2F4F6');
  static const surfaceContainer = Color('#ECEEF0');
  static const surfaceContainerHigh = Color('#E6E8EA');
  static const surfaceContainerHighest = Color('#E0E3E5');
  static const onSurfaceVariant = Color('#3C4947');
  static const outline = Color('#6C7A77');
  static const outlineVariant = Color('#BBCAC6');
  static const error = Color('#BA1A1A');
}

/// Spacing scale matching the mockups' Tailwind config (`kinetic_stadium`).
abstract final class BgsSpacing {
  static const base = Unit.pixels(8);
  static const cardPadding = Unit.pixels(20);
  static const sectionGap = Unit.pixels(48);
  static const gutter = Unit.pixels(16);
  static const containerMargin = Unit.pixels(24);
}

/// Corner radii. `card` matches Flutter's `cardTheme` radius.
abstract final class BgsRadius {
  static const button = Unit.pixels(8);
  static const card = Unit.pixels(20);
  static const hero = Unit.pixels(24);
}

/// Global document-level styles -- font imports, base element defaults.
/// The single source of truth passed into `Document(styles: ...)` in
/// `main.server.dart`; nothing else should duplicate this list. Not
/// `@css`-annotated -- that annotation is for a [Component]'s own scoped
/// `styles` getter (picked up by `jaspr_builder`'s codegen), whereas this is
/// a plain value passed directly into `Document`'s constructor at render time.
List<StyleRule> get documentStyles => [
  css.import(
    'https://fonts.googleapis.com/css2?family=Anybody:wght@700;800'
    '&family=Be+Vietnam+Pro:wght@400;600;700'
    '&family=Space+Grotesk:wght@600;700&display=swap',
  ),
  css.import(
    'https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined'
    ':wght,FILL@100..700,0..1&display=swap',
  ),
  css('html, body').styles(
    width: 100.percent,
    minHeight: 100.vh,
    padding: .zero,
    margin: .zero,
    backgroundColor: BgsColors.surface,
    color: BgsColors.onSurface,
    fontFamily: const .list([FontFamily('Be Vietnam Pro'), FontFamilies.sansSerif]),
  ),
  css('h1, h2, h3, h4, h5, h6').styles(
    margin: .zero,
    fontFamily: const .list([FontFamily('Anybody'), FontFamilies.sansSerif]),
    fontWeight: .w800,
  ),
  css('a').styles(textDecoration: TextDecoration(line: .none), color: Color.inherit),
  css('.material-symbols-outlined').styles(
    fontFamily: const .list([FontFamily('Material Symbols Outlined')]),
    fontWeight: .w400,
  ),
];
