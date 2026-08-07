import 'package:bgs_client/bgs_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components/material_symbol.dart';
import '../constants/theme.dart';
import '../services/bgs_client.dart';
import '../utils/format.dart';

/// Public org homepage at `/org/:slug` -- anonymous and server-rendered,
/// reading through [PublicEndpoint] (the backend's one `requireLogin =>
/// false` endpoint). This is the Jaspr toolchain spike: real seeded data,
/// no login wall, no client-side JS needed since the page is static once
/// rendered -- so this is deliberately *not* `@client`-annotated. Doing the
/// data fetch here relies on [AsyncStatelessComponent], which -- unlike
/// [FutureBuilder] -- is explicitly allowed to await work during server
/// pre-rendering.
///
/// Styled per the Stitch `public_homepage` mockup's hero + card-grid layout.
/// No hero photo (no per-org image data) and no "Join a League"/"Learn
/// More" CTA buttons -- there's nothing real for them to do yet (no
/// self-serve join/register flow), same omission logic as the Flutter
/// sign-in screen's dropped "Guest Access" button.
class OrgHomePage extends AsyncStatelessComponent {
  final String slug;

  const OrgHomePage({required this.slug, super.key});

  @override
  Future<Component> build(BuildContext context) async {
    final org = await bgsClient.public.organizationBySlug(slug);
    if (org == null) {
      return section([
        h1([.text('Organization not found')]),
        p([.text('No organization exists at "/org/$slug".')]),
      ]);
    }

    final results = await Future.wait([
      bgsClient.public.activeLeaguesByOrganization(org.id!),
      bgsClient.public.publishedEventsByOrganization(org.id!),
    ]);
    final leagues = results[0] as List<League>;
    final events = results[1] as List<Event>;

    return section([
      div(classes: 'hero', [
        h1([.text(org.name)]),
        if (org.description != null) p(classes: 'tagline', [.text(org.description!)]),
      ]),
      div(classes: 'group', [
        h2([.text('Active Leagues')]),
        leagues.isEmpty
            ? p(classes: 'empty', [.text('No active leagues yet.')])
            : div(classes: 'grid', [
                for (final league in leagues)
                  Link(
                    to: '/org/$slug/league/${league.slug}',
                    child: div(classes: 'card', [
                      div(classes: 'card-top', [
                        h3([.text(league.name)]),
                        const MaterialSymbol('emoji_events'),
                      ]),
                      div(classes: 'card-meta', [
                        const MaterialSymbol('sports'),
                        span([.text(formatEnumLabel(league.sport.name))]),
                      ]),
                      if (league.location != null)
                        div(classes: 'card-meta', [
                          const MaterialSymbol('location_on'),
                          span([.text(league.location!)]),
                        ]),
                    ]),
                  ),
              ]),
      ]),
      div(classes: 'group', [
        h2([.text('Events')]),
        events.isEmpty
            ? p(classes: 'empty', [.text('No upcoming events yet.')])
            : div(classes: 'grid', [
                for (final event in events)
                  Link(
                    to: '/e/${event.slug}',
                    child: div(classes: 'card', [
                      div(classes: 'card-top', [
                        h3([.text(event.name)]),
                        const MaterialSymbol('event'),
                      ]),
                      div(classes: 'card-meta', [
                        const MaterialSymbol('sports'),
                        span([.text(formatEnumLabel(event.sport.name))]),
                      ]),
                      div(classes: 'card-meta', [
                        const MaterialSymbol('calendar_today'),
                        span([.text(formatDateTime(event.startAt))]),
                      ]),
                    ]),
                  ),
              ]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.hero', [
      css('&').styles(padding: .symmetric(vertical: BgsSpacing.base)),
      css('h1').styles(fontSize: 40.px, color: BgsColors.onSurface),
      css('.tagline').styles(
        fontSize: 18.px,
        color: BgsColors.onSurfaceVariant,
        maxWidth: 640.px,
      ),
    ]),
    css('.group', [
      css('&').styles(display: .flex, flexDirection: .column, gap: Gap.row(BgsSpacing.base)),
      css('h2').styles(fontSize: 24.px, color: BgsColors.onSurface),
      css('.empty').styles(color: BgsColors.onSurfaceVariant),
    ]),
    css('.grid').styles(
      display: .flex,
      flexWrap: .wrap,
      gap: Gap.all(BgsSpacing.gutter),
    ),
    css('.card', [
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
      css('.card-top', [
        css('&').styles(
          display: .flex,
          justifyContent: .spaceBetween,
          alignItems: .start,
        ),
        css('h3').styles(fontSize: 20.px, color: BgsColors.onSurface),
      ]),
      css('.card-meta', [
        css('&').styles(
          display: .flex,
          alignItems: .center,
          gap: Gap.all(6.px),
          color: BgsColors.onSurfaceVariant,
          fontSize: 14.px,
        ),
      ]),
    ]),
  ];
}
