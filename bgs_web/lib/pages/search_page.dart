import 'package:bgs_client/bgs_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../components/material_symbol.dart';
import '../constants/theme.dart';
import '../services/bgs_client.dart';
import '../utils/format.dart';

/// Public search page at `/search?q=...&sport=...` -- anonymous and
/// server-rendered. Deliberately a plain GET `<form>` rather than a
/// client-side search box: no JS needed, so this isn't `@client`-annotated
/// (see [OrgHomePage]) -- the browser's normal form submission does all the
/// "interactivity" via a full page navigation.
///
/// Styled per the Stitch `search_results` mockup's card grid, restricted to
/// organizations/leagues/events -- the mockup also shows team/player result
/// cards with star ratings and a day-of-week/skill-level filter sidebar,
/// neither of which `SearchEndpoint` supports today (same audit as the
/// Flutter search screen: no ratings, no team/player search, no extra
/// filters -- see BUILD_PLAN.md Phase 4).
class SearchPage extends AsyncStatelessComponent {
  final String? query;
  final String? sportName;

  const SearchPage({this.query, this.sportName, super.key});

  Sport? get _sport {
    for (final sport in Sport.values) {
      if (sport.name == sportName) return sport;
    }
    return null;
  }

  @override
  Future<Component> build(BuildContext context) async {
    final hasSearched = (query != null && query!.isNotEmpty) || sportName != null;
    final results = hasSearched
        ? await bgsClient.public.search(query: query, sport: _sport)
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
        div(classes: 'grid', [
          for (final org in results.organizations)
            Link(
              to: '/org/${org.slug}',
              child: div(classes: 'card', [
                span(classes: 'badge', [.text('Organization')]),
                h3([.text(org.name)]),
              ]),
            ),
          for (final league in results.leagues)
            div(classes: 'card', [
              span(classes: 'badge', [.text('League')]),
              h3([.text(league.name)]),
              div(classes: 'card-meta', [
                const MaterialSymbol('sports'),
                span([.text(formatEnumLabel(league.sport.name))]),
              ]),
            ]),
          for (final event in results.events)
            Link(
              to: '/e/${event.slug}',
              child: div(classes: 'card', [
                span(classes: 'badge', [.text('Event')]),
                h3([.text(event.name)]),
              ]),
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
        flex: const Flex(grow: 1, shrink: 1, basis: Unit.pixels(240)),
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
    css('.grid').styles(display: .flex, flexWrap: .wrap, gap: Gap.all(BgsSpacing.gutter)),
    css('.card', [
      css('&').styles(
        display: .flex,
        flexDirection: .column,
        gap: Gap.row(8.px),
        flex: const Flex(grow: 1, shrink: 1, basis: Unit.pixels(260)),
        backgroundColor: BgsColors.surfaceContainerLowest,
        padding: .all(BgsSpacing.cardPadding),
        radius: .all(.circular(BgsRadius.card)),
        border: .all(color: BgsColors.outlineVariant, width: 1.px),
        transition: Transition('border-color', duration: Duration(milliseconds: 150)),
      ),
      css('&:hover').styles(border: .all(color: BgsColors.primaryContainer, width: 1.px)),
      css('h3').styles(fontSize: 20.px, color: BgsColors.onSurface),
      css('.card-meta').styles(
        display: .flex,
        alignItems: .center,
        gap: Gap.all(6.px),
        color: BgsColors.onSurfaceVariant,
        fontSize: 14.px,
      ),
    ]),
    css('.badge').styles(
      alignSelf: .start,
      backgroundColor: BgsColors.surfaceContainerHigh,
      color: BgsColors.onSurfaceVariant,
      padding: .symmetric(vertical: 4.px, horizontal: 10.px),
      radius: .all(.circular(999.px)),
      fontSize: 11.px,
      fontWeight: .w700,
      textTransform: .upperCase,
    ),
  ];
}
