import 'package:bgs_client/bgs_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';

import '../constants/theme.dart';
import '../services/bgs_client.dart';
import '../utils/format.dart';

/// Public league page at `/org/:orgSlug/league/:leagueSlug` -- anonymous
/// and server-rendered, reading through [PublicEndpoint]. League slugs are
/// only unique within an organization (not globally), so both slugs are
/// needed to identify one. See [OrgHomePage] for why this isn't
/// `@client`-annotated.
///
/// Styled per the Stitch `league_standings` mockup: a real table for
/// standings, match cards for the schedule. No team crests (Jaspr has no
/// asset pipeline for that, unlike the Flutter `TeamCrest` widget) -- team
/// names are plain text here.
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
      div(classes: 'hero', [
        h1([.text(league.name)]),
        div(classes: 'meta-row', [
          span([
            .text(
              [
                formatEnumLabel(league.sport.name),
                if (league.location != null) league.location!,
              ].join(' · '),
            ),
          ]),
        ]),
        if (league.description != null) p(classes: 'tagline', [.text(league.description!)]),
      ]),
      div(classes: 'group', [
        h2([.text('Standings')]),
        standings.isEmpty
            ? p(classes: 'empty', [.text('No results recorded yet.')])
            : table([
                thead([
                  tr([
                    th([.text('Team')]),
                    th([.text('W')]),
                    th([.text('L')]),
                    th([.text('T')]),
                  ]),
                ]),
                tbody([
                  for (final standing in standings)
                    tr([
                      td([.text(teamNames[standing.teamId] ?? 'Unknown team')]),
                      td([.text('${standing.wins}')]),
                      td([.text('${standing.losses}')]),
                      td([.text('${standing.ties}')]),
                    ]),
                ]),
              ]),
      ]),
      div(classes: 'group', [
        h2([.text('Schedule')]),
        matches.isEmpty
            ? p(classes: 'empty', [.text('No matches scheduled yet.')])
            : div(classes: 'match-list', [
                for (final match in matches)
                  div(classes: 'match-card', [
                    div(classes: 'match-teams', [
                      .text(
                        '${teamNames[match.homeTeamId] ?? 'TBD'} vs '
                        '${teamNames[match.awayTeamId] ?? 'TBD'}',
                      ),
                    ]),
                    div(classes: 'match-meta', [
                      span([
                        .text(
                          formatDateTime(match.scheduledAt) +
                              (match.status == MatchStatus.completed
                                  ? ' -- ${match.homeScore}-${match.awayScore}'
                                  : ''),
                        ),
                      ]),
                    ]),
                  ]),
              ]),
      ]),
      div(classes: 'group', [
        h2([.text('Teams')]),
        teams.isEmpty
            ? p(classes: 'empty', [.text('No teams yet.')])
            : div(classes: 'chip-row', [for (final team in teams) span(classes: 'chip', [.text(team.name)])]),
      ]),
    ]);
  }

  @css
  static List<StyleRule> get styles => [
    css('.hero', [
      css('&').styles(padding: .symmetric(vertical: BgsSpacing.base)),
      css('h1').styles(fontSize: 40.px, color: BgsColors.onSurface),
      css('.meta-row').styles(color: BgsColors.onSurfaceVariant, fontSize: 14.px),
      css('.tagline').styles(color: BgsColors.onSurfaceVariant, maxWidth: 640.px),
    ]),
    css('.group', [
      css('&').styles(display: .flex, flexDirection: .column, gap: Gap.row(BgsSpacing.base)),
      css('h2').styles(fontSize: 24.px, color: BgsColors.onSurface),
      css('.empty').styles(color: BgsColors.onSurfaceVariant),
    ]),
    css('table').styles(
      width: 100.percent,
      backgroundColor: BgsColors.surfaceContainerLowest,
      radius: .all(.circular(BgsRadius.card)),
      overflow: .hidden,
      border: .all(color: BgsColors.outlineVariant, width: 1.px),
    ),
    css('th').styles(
      textAlign: .left,
      padding: .symmetric(vertical: 12.px, horizontal: BgsSpacing.base),
      backgroundColor: BgsColors.surfaceContainer,
      color: BgsColors.onSurfaceVariant,
      fontSize: 12.px,
      textTransform: .upperCase,
      letterSpacing: 1.px,
    ),
    css('td').styles(
      padding: .symmetric(vertical: 12.px, horizontal: BgsSpacing.base),
      border: .only(top: BorderSide(width: 1.px, color: BgsColors.outlineVariant)),
      color: BgsColors.onSurface,
    ),
    css('.match-list').styles(display: .flex, flexDirection: .column, gap: Gap.row(8.px)),
    css('.match-card', [
      css('&').styles(
        display: .flex,
        justifyContent: .spaceBetween,
        alignItems: .center,
        flexWrap: .wrap,
        gap: Gap.all(8.px),
        backgroundColor: BgsColors.surfaceContainerLowest,
        padding: .all(BgsSpacing.base),
        radius: .all(.circular(12.px)),
        border: .all(color: BgsColors.outlineVariant, width: 1.px),
      ),
      css('.match-teams').styles(fontWeight: .w700, color: BgsColors.onSurface),
      css('.match-meta').styles(color: BgsColors.onSurfaceVariant, fontSize: 14.px),
    ]),
    css('.chip-row').styles(display: .flex, flexWrap: .wrap, gap: Gap.all(8.px)),
    css('.chip').styles(
      backgroundColor: BgsColors.surfaceContainerHigh,
      color: BgsColors.onSurfaceVariant,
      padding: .symmetric(vertical: 6.px, horizontal: 12.px),
      radius: .all(.circular(999.px)),
      fontSize: 13.px,
    ),
  ];
}
