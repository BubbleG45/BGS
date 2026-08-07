import 'package:bgs_client/bgs_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../services/bgs_client.dart';
import '../utils/format.dart';

/// Public search page at `/search?q=...&sport=...` -- anonymous and
/// server-rendered. Deliberately a plain GET `<form>` rather than a
/// client-side search box: no JS needed, so this isn't `@client`-annotated
/// (see [OrgHomePage]) -- the browser's normal form submission does all the
/// "interactivity" via a full page navigation.
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
      form(method: FormMethod.get, action: '/search', [
        input<String>(
          type: InputType.search,
          name: 'q',
          value: query ?? '',
          attributes: const {'placeholder': 'Search organizations, leagues, events'},
        ),
        select(
          [
            option([.text('Any sport')], value: ''),
            for (final sport in Sport.values)
              option([.text(formatEnumLabel(sport.name))], value: sport.name, selected: sport == _sport),
          ],
          name: 'sport',
        ),
        button([.text('Search')], type: ButtonType.submit),
      ]),
      if (results == null)
        p([.text('Search for an organization, league, or event.')])
      else ...[
        h2([.text('Organizations')]),
        results.organizations.isEmpty
            ? p([.text('No matching organizations.')])
            : ul([
                for (final org in results.organizations)
                  li([Link(to: '/org/${org.slug}', child: .text(org.name))]),
              ]),
        h2([.text('Leagues')]),
        results.leagues.isEmpty
            ? p([.text('No matching leagues.')])
            : ul([
                for (final league in results.leagues)
                  li([.text('${league.name} -- ${formatEnumLabel(league.sport.name)}')]),
              ]),
        h2([.text('Events')]),
        results.events.isEmpty
            ? p([.text('No matching events.')])
            : ul([
                for (final event in results.events)
                  li([Link(to: '/e/${event.slug}', child: .text(event.name))]),
              ]),
      ],
    ]);
  }
}
