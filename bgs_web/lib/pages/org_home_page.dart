import 'package:bgs_client/bgs_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import 'package:jaspr_router/jaspr_router.dart';

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
      h1([.text(org.name)]),
      if (org.description != null) p([.text(org.description!)]),
      h2([.text('Leagues')]),
      leagues.isEmpty
          ? p([.text('No active leagues yet.')])
          : ul([
              for (final league in leagues)
                li([
                  Link(
                    to: '/org/$slug/league/${league.slug}',
                    child: .text(
                      '${league.name} -- ${formatEnumLabel(league.sport.name)}'
                      '${league.location == null ? '' : ' · ${league.location}'}',
                    ),
                  ),
                ]),
            ]),
      h2([.text('Events')]),
      events.isEmpty
          ? p([.text('No upcoming events yet.')])
          : ul([
              for (final event in events)
                li([
                  Link(
                    to: '/e/${event.slug}',
                    child: .text(
                      '${event.name} -- ${formatEnumLabel(event.sport.name)} · '
                      '${formatDateTime(event.startAt)}',
                    ),
                  ),
                ]),
            ]),
    ]);
  }
}
