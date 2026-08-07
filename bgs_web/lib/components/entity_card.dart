import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../constants/theme.dart';
import 'material_symbol.dart';

/// One icon+text row inside an [EntityCard], e.g. sport or location.
typedef CardMeta = (String icon, String text);

/// Card for an org/league/event "tile" -- a top row (title + type icon)
/// plus meta rows (icon+text pairs). Replaces the near-identical `.card`
/// CSS block that `org_home_page.dart`, `search_page.dart`, and
/// `event_page.dart` used to each declare independently. The Flutter-side
/// analog is `EntityCard` in `bgs_flutter/lib/widgets/entity_card.dart` --
/// same visual language, different toolkit.
class EntityCard extends StatelessComponent {
  /// Link destination. Null renders a plain (non-clickable) card -- e.g.
  /// league search results, which can't link to their org-scoped URL
  /// without the org slug (`performSearch` doesn't join it in; a known,
  /// previously-flagged gap, not new to this pass).
  final String? to;
  final String title;
  final String topIcon;
  final List<CardMeta> meta;

  const EntityCard({
    this.to,
    required this.title,
    required this.topIcon,
    this.meta = const [],
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final card = div(classes: 'entity-card', [
      div(classes: 'entity-card-top', [
        h3([.text(title)]),
        MaterialSymbol(topIcon),
      ]),
      for (final (icon, text) in meta)
        div(classes: 'entity-card-meta', [
          MaterialSymbol(icon),
          span([.text(text)]),
        ]),
    ]);

    return to == null ? card : Link(to: to!, child: card);
  }

  @css
  static List<StyleRule> get styles => [
    css('.entity-card', [
      css('&').styles(
        display: .flex,
        flexDirection: .column,
        gap: Gap.all(8.px),
        flex: const Flex(grow: 1, shrink: 1, basis: Unit.pixels(280)),
        backgroundColor: BgsColors.surfaceContainerLowest,
        padding: .all(BgsSpacing.cardPadding),
        radius: .all(.circular(BgsRadius.card)),
        border: .all(color: BgsColors.outlineVariant, width: 1.px),
        transition: Transition('border-color', duration: Duration(milliseconds: 150)),
      ),
      css('&:hover').styles(
        border: .all(color: BgsColors.primaryContainer, width: 1.px),
        shadow: BoxShadow(
          offsetX: 0.px,
          offsetY: 8.px,
          blur: 24.px,
          color: Color.rgba(20, 184, 166, 0.16),
        ),
      ),
      css('.entity-card-top', [
        css('&').styles(display: .flex, justifyContent: .spaceBetween, alignItems: .start),
        css('h3').styles(fontSize: 20.px, color: BgsColors.onSurface),
      ]),
      css('.entity-card-meta').styles(
        display: .flex,
        alignItems: .center,
        gap: Gap.all(6.px),
        color: BgsColors.onSurfaceVariant,
        fontSize: 14.px,
      ),
    ]),
  ];
}

/// Wraps a row of [EntityCard]s -- flex-wrap with a 280px min card width
/// naturally fits more cards per row as the viewport widens, giving desktop
/// more columns than mobile without a separate breakpoint/media query.
class CardGrid extends StatelessComponent {
  final List<Component> children;

  const CardGrid(this.children, {super.key});

  @override
  Component build(BuildContext context) => div(classes: 'card-grid', children);

  @css
  static List<StyleRule> get styles => [
    css('.card-grid').styles(display: .flex, flexWrap: .wrap, gap: Gap.all(BgsSpacing.gutter)),
  ];
}
