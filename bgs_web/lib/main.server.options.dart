// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:bgs_web/components/header.dart' as _header;
import 'package:bgs_web/pages/about.dart' as _about;
import 'package:bgs_web/pages/event_page.dart' as _event_page;
import 'package:bgs_web/pages/home.dart' as _home;
import 'package:bgs_web/pages/league_page.dart' as _league_page;
import 'package:bgs_web/pages/org_home_page.dart' as _org_home_page;
import 'package:bgs_web/pages/search_page.dart' as _search_page;
import 'package:bgs_web/app.dart' as _app;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  clients: {_about.About: ClientTarget<_about.About>('about')},
  styles: () => [
    ..._app.App.styles,
    ..._header.Header.styles,
    ..._about.About.styles,
    ..._event_page.EventPage.styles,
    ..._home.Home.styles,
    ..._league_page.LeaguePage.styles,
    ..._org_home_page.OrgHomePage.styles,
    ..._search_page.SearchPage.styles,
  ],
);
