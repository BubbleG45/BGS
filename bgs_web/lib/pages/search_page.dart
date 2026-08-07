import 'package:bgs_client/bgs_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

import '../components/entity_card.dart';
import '../constants/theme.dart';
import '../services/bgs_client.dart';
import '../utils/format.dart';

/// Public search page at `/search?q=...&sport=...&location=...` --
/// anonymous and server-rendered. Deliberately a plain GET `<form>` rather
/// than a client-side search box: no JS needed, so this isn't
/// `@client`-annotated (see [OrgHomePage]) -- the browser's normal form
/// submission does all the "interactivity" via a full page navigation.
///
/// Styled per the Stitch `search_results` mockup's card grid, restricted to
/// organizations/leagues/events -- the mockup also shows team/player result
/// cards with star ratings and a day-of-week/skill-level filter sidebar,
/// neither of which `SearchEndpoint` supports today (same audit as the
/// Flutter search screen: no ratings, no team/player search -- day-of-week/
/// skill filters are Phase B; see BUILD_PLAN.md).
class SearchPage extends AsyncStatelessComponent {
  final String? query;
  final String? sportName;
  final String? location;

  const SearchPage({this.query, this.sportName, this.location, super.key});

  Sport? get _sport {
    for (final sport in Sport.values) {
      if (sport.name == sportName) return sport;
    }
    return null;
  }

  @override
  Future<Component> build(BuildContext context) async {
    final hasSearched =
        (query != null && query!.isNotEmpty) || sportName != null || (location != null && location!.isNotEmpty);
    final results = hasSearched
        ? await bgsClient.public.search(query: query, sport: _sport, location: location)
        : null;

    return section([
      h1([.text('Search')]),
      form(classes: 'search-form', method: FormMethod.get, action: '/search', [
        input<String>(
          type: InputType.search,
          name: 'q',
          value: query ?? '',
          classes: 'search-input',
          attributes: const {'placeholder': 'Search organizations, leagues, events'},
        ),
        input<String>(
          type: InputType.search,
          name: 'location',
          value: location ?? '',
          classes: 'search-input',
          attributes: const {'placeholder': 'Location'},
        ),
        select(
          [
            option([.text('Any sport')], value: ''),
            for (final sport in Sport.values)
              option([.text(formatEnumLabel(sport.name))], value: sport.name, selected: sport == _sport),
          ],
          name: 'sport',
          classes: 'search-select',
        ),
        button([.text('Search')], type: ButtonType.submit, classes: 'search-submit'),
      ]),
      if (results == null)
        p(classes: 'empty', [.text('Search for an organization, league, or event.')])
      else
        CardGrid([
          for (final org in results.organizations)
            EntityCard(to: '/org/${org.slug}', title: org.name, topIcon: 'corporate_fare'),
          for (final league in results.leagues)
            EntityCard(
              // Not linked -- performSearch doesn't join in the
              // organization slug a league URL needs. Known gap, not new
              // to this pass.
              title: league.name,
              topIcon: 'emoji_events',
              meta: [('sports', formatEnumLabel(league.sport.name))],
            ),
          for (final event in results.events)
            EntityCard(
              to: '/e/${event.slug}',
              title: event.name,
              topIcon: 'event',
              meta: [('sports', formatEnumLabel(event.sport.name))],
            ),
          if (results.organizations.isEmpty && results.leagues.isEmpty && results.events.isEmpty)
            p(classes: 'empty', [.text('No matching results.')]),
        ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.search-form', [
      css('&').styles(
        display: .flex,
        flexWrap: .wrap,
        gap: Gap.all(BgsSpacing.base),
        margin: .only(top: BgsSpacing.base, bottom: BgsSpacing.sectionGap),
      ),
      css('.search-input').styles(
        flex: const Flex(grow: 1, shrink: 1, basis: Unit.pixels(200)),
        padding: .symmetric(vertical: 10.px, horizontal: 14.px),
        radius: .all(.circular(BgsRadius.button)),
        border: .all(color: BgsColors.outlineVariant, width: 1.px),
        fontSize: 16.px,
      ),
      css('.search-select').styles(
        padding: .symmetric(vertical: 10.px, horizontal: 14.px),
        radius: .all(.circular(BgsRadius.button)),
        border: .all(color: BgsColors.outlineVariant, width: 1.px),
        fontSize: 16.px,
        backgroundColor: BgsColors.surfaceContainerLowest,
      ),
      css('.search-submit').styles(
        backgroundColor: BgsColors.primary,
        color: BgsColors.onPrimary,
        fontWeight: .w700,
        textTransform: .upperCase,
        letterSpacing: 1.px,
        padding: .symmetric(vertical: 10.px, horizontal: 24.px),
        radius: .all(.circular(BgsRadius.button)),
        border: Border.none,
        cursor: .pointer,
      ),
    ]),
    css('.empty').styles(color: BgsColors.onSurfaceVariant),
  ];
}
