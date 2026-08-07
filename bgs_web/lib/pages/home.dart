import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../constants/theme.dart';

/// Landing page. Static and server-rendered only -- no client interactivity
/// needed, so this isn't `@client`-annotated (see [OrgHomePage] for why that
/// matters). No mockup targets this exact page (the Stitch `public_homepage`
/// mockup is a specific org's homepage, not the site root), so this stays a
/// small, simple hero rather than inventing new content.
class Home extends StatelessComponent {
  const Home({super.key});

  @override
  Component build(BuildContext context) {
    return section(classes: 'hero', [
      img(src: 'images/logo.svg', width: 80),
      h1([.text('Better Group Sports')]),
      p(classes: 'tagline', [.text('Find your league, team, or event.')]),
      p(classes: 'hint', [
        .text('Organization pages live at '),
        code([.text('/org/<slug>')]),
        .text('.'),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.hero', [
      css('&').styles(
        display: .flex,
        flexDirection: .column,
        alignItems: .center,
        textAlign: .center,
        gap: Gap.row(BgsSpacing.base),
        padding: .symmetric(vertical: BgsSpacing.sectionGap),
      ),
      css('h1').styles(fontSize: 40.px, color: BgsColors.onSurface),
      css('.tagline').styles(fontSize: 18.px, color: BgsColors.onSurfaceVariant),
      css('.hint').styles(color: BgsColors.onSurfaceVariant),
      css('code').styles(
        backgroundColor: BgsColors.surfaceContainerHigh,
        padding: .symmetric(horizontal: 6.px),
        radius: .all(.circular(4.px)),
      ),
    ]),
  ];
}
