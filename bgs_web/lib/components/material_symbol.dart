import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// A single Material Symbols Outlined glyph, e.g. `MaterialSymbol('search')`.
///
/// Jaspr has no Flutter-style icon package -- the font itself (imported in
/// `constants/theme.dart`'s `documentStyles`) renders whatever text content
/// sits inside a `.material-symbols-outlined`-classed element as a glyph, so
/// this just wraps that convention (the same one the Stitch mockups use
/// directly as `<span class="material-symbols-outlined">search</span>`).
class MaterialSymbol extends StatelessComponent {
  final String name;
  final bool filled;
  final Unit? size;
  final Color? color;

  const MaterialSymbol(this.name, {this.filled = false, this.size, this.color, super.key});

  @override
  Component build(BuildContext context) {
    return span(
      [.text(name)],
      classes: 'material-symbols-outlined',
      styles: Styles(
        fontSize: size,
        color: color,
        raw: {'font-variation-settings': "'FILL' ${filled ? 1 : 0}"},
      ),
    );
  }
}
