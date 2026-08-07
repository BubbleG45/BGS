import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

import '../components/material_symbol.dart';
import '../constants/theme.dart';
import '../services/bgs_client.dart';
import '../utils/format.dart';

/// Public event page at `/e/:slug` -- the shareable event link (see
/// BUILD_PLAN.md's domain model). Anonymous and server-rendered, reading
/// through [PublicEndpoint]. Read-only: registering for an event requires
/// signing in, which is the Flutter app's job, not this site's -- see
/// [OrgHomePage] for why this isn't `@client`-annotated.
class EventPage extends AsyncStatelessComponent {
  final String slug;

  const EventPage({required this.slug, super.key});

  @override
  Future<Component> build(BuildContext context) async {
    final event = await bgsClient.public.eventBySlug(slug);
    if (event == null) {
      return section([
        h1([.text('Event not found')]),
        p([.text('No published event exists at "/e/$slug".')]),
      ]);
    }

    final registrations = await bgsClient.public.registrationsByEvent(event.id!);

    return section([
      div(classes: 'card', [
        div(classes: 'card-top', [
          h1([.text(event.name)]),
          span(classes: 'badge', [
            .text(
              [
                formatEnumLabel(event.sport.name),
                if (event.skillLevel != null) formatEnumLabel(event.skillLevel!.name),
              ].join(' · '),
            ),
          ]),
        ]),
        div(classes: 'detail-row', [
          const MaterialSymbol('calendar_today'),
          span([.text(formatDateTime(event.startAt))]),
        ]),
        if (event.location != null)
          div(classes: 'detail-row', [
            const MaterialSymbol('location_on'),
            span([.text(event.location!)]),
          ]),
        div(classes: 'detail-row', [
          const MaterialSymbol('payments'),
          span([.text('Team fee: \$${(event.teamFeeCents / 100).toStringAsFixed(2)}')]),
        ]),
        if (event.registrationOpensAt != null)
          div(classes: 'detail-row', [
            const MaterialSymbol('how_to_reg'),
            span([
              .text(
                'Registration opens ${formatDateTime(event.registrationOpensAt!)}'
                '${event.registrationClosesAt != null ? ', closes ${formatDateTime(event.registrationClosesAt!)}' : ''}',
              ),
            ]),
          ]),
        if (event.rulesUrl != null)
          div(classes: 'detail-row', [
            const MaterialSymbol('gavel'),
            a(href: event.rulesUrl!, [.text('Event rules')]),
          ]),
        if (event.isTournament)
          div(classes: 'detail-row', [
            const MaterialSymbol('emoji_events'),
            span([.text('Tournament (bracket-based)')]),
          ]),
        if (event.description != null) p(classes: 'description', [.text(event.description!)]),
        div(classes: 'registrants', [
          h2([.text('Who\'s signed up (${registrations.length})')]),
          registrations.isEmpty
              ? p(classes: 'empty', [.text('No one has registered yet.')])
              : div(classes: 'chip-row', [
                  for (final registration in registrations)
                    span(classes: 'chip', [.text(registration.teamName ?? 'A player')]),
                ]),
        ]),
        p(classes: 'cta', [.text('Register for this event in the Better Group Sports app.')]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.card', [
      css('&').styles(
        display: .flex,
        flexDirection: .column,
        gap: Gap.row(12.px),
        maxWidth: 640.px,
        backgroundColor: BgsColors.surfaceContainerLowest,
        padding: .all(BgsSpacing.cardPadding),
        radius: .all(.circular(BgsRadius.card)),
        border: .all(color: BgsColors.outlineVariant, width: 1.px),
      ),
      css('.card-top', [
        css('&').styles(display: .flex, flexDirection: .column, gap: Gap.row(8.px)),
        css('h1').styles(fontSize: 32.px, color: BgsColors.onSurface),
      ]),
      css('.badge').styles(
        alignSelf: .start,
        backgroundColor: BgsColors.secondaryContainer,
        color: BgsColors.onSecondary,
        padding: .symmetric(vertical: 4.px, horizontal: 12.px),
        radius: .all(.circular(999.px)),
        fontSize: 12.px,
        fontWeight: .w700,
        textTransform: .upperCase,
      ),
      css('.detail-row', [
        css('&').styles(
          display: .flex,
          alignItems: .center,
          gap: Gap.all(8.px),
          color: BgsColors.onSurfaceVariant,
        ),
        css('a').styles(color: BgsColors.primary, fontWeight: .w600),
      ]),
      css('.description').styles(color: BgsColors.onSurface),
      css('.registrants', [
        css('&').styles(
          display: .flex,
          flexDirection: .column,
          gap: Gap.row(8.px),
          border: .only(top: BorderSide(width: 1.px, color: BgsColors.outlineVariant)),
          padding: .only(top: 12.px),
        ),
        css('h2').styles(fontSize: 16.px, color: BgsColors.onSurface),
        css('.empty').styles(color: BgsColors.onSurfaceVariant, fontSize: 14.px),
      ]),
      css('.chip-row').styles(display: .flex, flexWrap: .wrap, gap: Gap.all(8.px)),
      css('.chip').styles(
        backgroundColor: BgsColors.surfaceContainerHigh,
        color: BgsColors.onSurfaceVariant,
        padding: .symmetric(vertical: 6.px, horizontal: 12.px),
        radius: .all(.circular(999.px)),
        fontSize: 13.px,
      ),
      css('.cta').styles(
        color: BgsColors.primary,
        fontWeight: .w600,
        border: .only(top: BorderSide(width: 1.px, color: BgsColors.outlineVariant)),
        padding: .only(top: 12.px),
      ),
    ]),
  ];
}
