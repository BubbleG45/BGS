import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

/// Landing page. Static and server-rendered only -- no client interactivity
/// needed, so this isn't `@client`-annotated (see [OrgHomePage] for why that
/// matters).
class Home extends StatelessComponent {
  const Home({super.key});

  @override
  Component build(BuildContext context) {
    return section([
      img(src: 'images/logo.svg', width: 80),
      h1([.text('Better Group Sports')]),
      p([.text('Find your league, team, or event.')]),
      p([
        .text('Organization pages live at '),
        code([.text('/org/<slug>')]),
        .text('.'),
      ]),
    ]);
  }
}
