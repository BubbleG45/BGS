import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../constants/theme.dart';
import 'material_symbol.dart';

/// Site-wide top nav, styled per the Kinetic Stadium mockups' desktop
/// `TopAppBar` (`public_homepage`/`search_results`): wordmark left, nav
/// links center, search icon right. Same three routes as before
/// (Home/Search/About) -- visuals only, no navigation changes.
class Header extends StatelessComponent {
  const Header({super.key});

  @override
  Component build(BuildContext context) {
    var activePath = context.url;

    return header([
      div(classes: 'bar', [
        Link(to: '/', child: div(classes: 'brand', [.text('BGS')])),
        nav([
          for (var route in [
            (label: 'Home', path: '/'),
            (label: 'Search', path: '/search'),
            (label: 'About', path: '/about'),
          ])
            Link(
              to: route.path,
              child: span(
                [.text(route.label)],
                classes: activePath == route.path ? 'nav-link active' : 'nav-link',
              ),
            ),
        ]),
        Link(to: '/search', child: const MaterialSymbol('search')),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('header', [
      css('&').styles(
        display: .flex,
        justifyContent: .center,
        backgroundColor: BgsColors.surface,
        border: .only(bottom: BorderSide(width: 1.px, color: BgsColors.outlineVariant)),
      ),
      css('.bar', [
        css('&').styles(
          display: .flex,
          width: 100.percent,
          maxWidth: 1200.px,
          height: 64.px,
          alignItems: .center,
          justifyContent: .spaceBetween,
          padding: .symmetric(horizontal: BgsSpacing.containerMargin),
          gap: Gap.all(24.px),
        ),
      ]),
      css('.brand', [
        css('&').styles(
          fontFamily: const .list([FontFamily('Anybody')]),
          fontSize: 20.px,
          fontWeight: .w800,
          color: BgsColors.primary,
          textTransform: .upperCase,
          letterSpacing: (-0.5).px,
        ),
      ]),
      css('nav', [
        css('&').styles(display: .flex, gap: Gap.all(8.px), alignItems: .center),
        css('.nav-link', [
          css('&').styles(
            display: .inlineBlock,
            padding: .symmetric(vertical: 8.px, horizontal: 12.px),
            radius: .all(.circular(BgsRadius.button)),
            color: BgsColors.onSurfaceVariant,
            fontWeight: .w600,
            transition: Transition('background-color', duration: Duration(milliseconds: 150)),
          ),
          css('&:hover').styles(backgroundColor: BgsColors.surfaceContainerHigh, color: BgsColors.onSurface),
          css('&.active').styles(color: BgsColors.primary, fontWeight: .w700),
        ]),
      ]),
    ]),
  ];
}
