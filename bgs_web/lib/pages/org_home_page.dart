import 'package:bgs_client/bgs_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

import '../components/entity_card.dart';
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
/// Leagues and events are grouped into Active/Upcoming/Past sections
/// (mirroring the Flutter org home screen): leagues bucket by `status` +
/// `seasonStartAt`, events bucket by `startAt` vs. now. No hero photo (no
/// per-org image data) and no "Join a League"/"Learn More" CTA buttons --
/// there's nothing real for them to do yet (no self-serve join/register
/// flow), same omission logic as the Flutter sign-in screen's dropped
/// "Guest Access" button.
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
      bgsClient.public.leaguesByOrganization(org.id!),
      bgsClient.public.publishedEventsByOrganization(org.id!),
    ]);
    final leagues = results[0] as List<League>;
    final events = results[1] as List<Event>;
    final now = DateTime.now();

    final pastLeagues = leagues.where((l) => l.status == LeagueStatus.completed).toList();
    final upcomingLeagues = leagues.where(
      (l) => l.status == LeagueStatus.active && l.seasonStartAt != null && l.seasonStartAt!.isAfter(now),
    ).toList();
    final activeLeagues = leagues.where(
      (l) => l.status == LeagueStatus.active && !upcomingLeagues.contains(l),
    ).toList();

    final pastEvents = events.where((e) => e.startAt.isBefore(now)).toList();
    final upcomingEvents = events.where((e) => e.startAt.isAfter(now)).toList();

    Component leagueCard(League league) => EntityCard(
          to: '/org/$slug/league/${league.slug}',
          title: league.name,
          topIcon: 'emoji_events',
          meta: [
            ('sports', formatEnumLabel(league.sport.name)),
            if (league.location != null) ('location_on', league.location!),
          ],
        );

    Component eventCard(Event event) => EntityCard(
          to: '/e/${event.slug}',
          title: event.name,
          topIcon: 'event',
          meta: [
            ('sports', formatEnumLabel(event.sport.name)),
            ('calendar_today', formatDateTime(event.startAt)),
          ],
        );

    Component group(String title, List<Component> cards, String emptyMessage) => div(
          classes: 'group',
          [
            h2([.text(title)]),
            cards.isEmpty ? p(classes: 'empty', [.text(emptyMessage)]) : CardGrid(cards),
          ],
        );

    return section([
      div(classes: 'hero', [
        h1([.text(org.name)]),
        if (org.description != null) p(classes: 'tagline', [.text(org.description!)]),
      ]),
      group('Active Leagues', activeLeagues.map(leagueCard).toList(), 'No active leagues right now.'),
      group('Upcoming Leagues', upcomingLeagues.map(leagueCard).toList(), 'No upcoming leagues.'),
      group('Past Leagues', pastLeagues.map(leagueCard).toList(), 'No past leagues yet.'),
      group('Upcoming Events', upcomingEvents.map(eventCard).toList(), 'No upcoming events.'),
      group('Past Events', pastEvents.map(eventCard).toList(), 'No past events yet.'),
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
  ];
}
