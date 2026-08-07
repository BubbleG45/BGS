import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

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

    return section([
      h1([.text(event.name)]),
      p([
        .text(
          [
            formatEnumLabel(event.sport.name),
            if (event.skillLevel != null) formatEnumLabel(event.skillLevel!.name),
          ].join(' · '),
        ),
      ]),
      p([.text(formatDateTime(event.startAt))]),
      if (event.location != null) p([.text(event.location!)]),
      p([.text('Team fee: \$${(event.teamFeeCents / 100).toStringAsFixed(2)}')]),
      if (event.isTournament) p([.text('Tournament (bracket-based)')]),
      if (event.description != null) p([.text(event.description!)]),
      p([.text('Register for this event in the Better Group Sports app.')]),
    ]);
  }
}
