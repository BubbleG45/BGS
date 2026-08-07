import 'package:bgs_client/bgs_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

import '../services/bgs_client.dart';
import '../utils/format.dart';

/// Public league page at `/org/:orgSlug/league/:leagueSlug` -- anonymous
/// and server-rendered, reading through [PublicEndpoint]. League slugs are
/// only unique within an organization (not globally), so both slugs are
/// needed to identify one. See [OrgHomePage] for why this isn't
/// `@client`-annotated.
class LeaguePage extends AsyncStatelessComponent {
  final String organizationSlug;
  final String leagueSlug;

  const LeaguePage({required this.organizationSlug, required this.leagueSlug, super.key});

  @override
  Future<Component> build(BuildContext context) async {
    final league = await bgsClient.public.leagueBySlug(
      organizationSlug: organizationSlug,
      leagueSlug: leagueSlug,
    );
    if (league == null) {
      return section([
        h1([.text('League not found')]),
        p([.text('No active league exists at "/org/$organizationSlug/league/$leagueSlug".')]),
      ]);
    }

    final results = await Future.wait([
      bgsClient.public.teamsByLeague(league.id!),
      bgsClient.public.standingsByLeague(league.id!),
      bgsClient.public.matchesByLeague(league.id!),
    ]);
    final teams = results[0] as List<Team>;
    final standings = results[1] as List<Standing>;
    final matches = results[2] as List<ScheduledMatch>;
    final teamNames = {for (final team in teams) team.id: team.name};

    return section([
      h1([.text(league.name)]),
      p([
        .text(
          [
            formatEnumLabel(league.sport.name),
            if (league.location != null) league.location!,
          ].join(' · '),
        ),
      ]),
      if (league.description != null) p([.text(league.description!)]),
      h2([.text('Standings')]),
      standings.isEmpty
          ? p([.text('No results recorded yet.')])
          : ul([
              for (final standing in standings)
                li([
                  .text(
                    '${teamNames[standing.teamId] ?? 'Unknown team'} -- '
                    '${standing.wins}-${standing.losses}-${standing.ties}',
                  ),
                ]),
            ]),
      h2([.text('Schedule')]),
      matches.isEmpty
          ? p([.text('No matches scheduled yet.')])
          : ul([
              for (final match in matches)
                li([
                  .text(
                    '${teamNames[match.homeTeamId] ?? 'TBD'} vs '
                    '${teamNames[match.awayTeamId] ?? 'TBD'} -- '
                    '${formatDateTime(match.scheduledAt)}'
                    '${match.status == MatchStatus.completed ? ' (${match.homeScore}-${match.awayScore})' : ''}',
                  ),
                ]),
            ]),
      h2([.text('Teams')]),
      teams.isEmpty
          ? p([.text('No teams yet.')])
          : ul([for (final team in teams) li([.text(team.name)])]),
    ]);
  }
}
