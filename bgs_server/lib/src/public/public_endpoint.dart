import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../search/perform_search.dart';

/// Anonymous-access reads for the Jaspr public site (`bgs_web`) -- the one
/// endpoint class in the app with `requireLogin => false`. Every other
/// endpoint requires a logged-in session even for otherwise-public reads
/// (see BUILD_PLAN.md §7); this class exists specifically so a visitor with
/// no BGS account can render an org homepage.
///
/// Deliberately narrow and read-only: only what a public page actually
/// needs, filtered to what's meant to be discoverable (active leagues,
/// published events) the same way [SearchEndpoint] filters its results.
/// Doesn't reuse [OrganizationEndpoint]/[LeagueEndpoint]/[EventEndpoint]
/// directly so those classes' authenticated writes never have to reason
/// about being called anonymously.
class PublicEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  /// Returns an organization by its public URL slug.
  Future<Organization?> organizationBySlug(Session session, String slug) async {
    return Organization.db.findFirstRow(session, where: (t) => t.slug.equals(slug));
  }

  /// Returns an organization's `active` and `completed` leagues, newest
  /// first -- everything a visitor should be able to see, letting the
  /// caller bucket into Active/Upcoming (by `seasonStartAt`) and Past (by
  /// `status == completed`) client-side. Draft/cancelled leagues aren't
  /// announced yet, so they stay excluded even though an organizer sees
  /// them on their own dashboard.
  Future<List<League>> leaguesByOrganization(
    Session session,
    UuidValue organizationId,
  ) async {
    return League.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          (t.status.equals(LeagueStatus.active) | t.status.equals(LeagueStatus.completed)),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  /// Returns an organization's *published* events, newest first. Same
  /// rationale as [activeLeaguesByOrganization] -- drafts aren't public yet.
  Future<List<Event>> publishedEventsByOrganization(
    Session session,
    UuidValue organizationId,
  ) async {
    return Event.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.status.equals(EventStatus.published),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  /// Returns a single *active* league by its org slug + league slug (league
  /// slugs are only unique within an organization, not globally, so both
  /// are needed). Returns null if the org doesn't exist, the league doesn't
  /// exist, or the league isn't active yet -- a draft league has no public
  /// page.
  Future<League?> leagueBySlug(
    Session session, {
    required String organizationSlug,
    required String leagueSlug,
  }) async {
    final org = await Organization.db.findFirstRow(
      session,
      where: (t) => t.slug.equals(organizationSlug),
    );
    if (org == null) return null;

    return League.db.findFirstRow(
      session,
      where: (t) =>
          t.organizationId.equals(org.id!) &
          t.slug.equals(leagueSlug) &
          t.status.equals(LeagueStatus.active),
    );
  }

  /// Returns all teams for a league. Same read [TeamEndpoint.listByLeague]
  /// already exposes to logged-in callers -- team rosters are public by
  /// design, this just makes that reachable anonymously too.
  Future<List<Team>> teamsByLeague(Session session, UuidValue leagueId) async {
    return Team.db.find(session, where: (t) => t.leagueId.equals(leagueId), orderBy: (t) => t.createdAt);
  }

  /// Returns a league's standings, best record first.
  Future<List<Standing>> standingsByLeague(Session session, UuidValue leagueId) async {
    return Standing.db.find(
      session,
      where: (t) => t.leagueId.equals(leagueId),
      orderBy: (t) => t.wins,
      orderDescending: true,
    );
  }

  /// Returns all matches for a league, soonest first.
  Future<List<ScheduledMatch>> matchesByLeague(Session session, UuidValue leagueId) async {
    return ScheduledMatch.db.find(
      session,
      where: (t) => t.leagueId.equals(leagueId),
      orderBy: (t) => t.scheduledAt,
    );
  }

  /// Returns a single *published* event by its globally-unique slug -- what
  /// backs the shareable event link, e.g. `/e/<slug>`. Returns null if the
  /// event doesn't exist or isn't published yet.
  Future<Event?> eventBySlug(Session session, String slug) async {
    final event = await Event.db.findFirstRow(session, where: (t) => t.slug.equals(slug));
    if (event == null || event.status != EventStatus.published) return null;
    return event;
  }

  /// Returns a *published* event's active registrations, newest first --
  /// backs the public event page's "who's signed up" section. Only
  /// `registeredByAuthUserId` and `teamName` are meaningful to show
  /// publicly; the UI should prefer `teamName` and fall back to something
  /// generic rather than exposing raw user identity. Returns an empty list
  /// (not an error) if the event doesn't exist or isn't published.
  Future<List<EventRegistration>> registrationsByEvent(
    Session session,
    UuidValue eventId,
  ) async {
    final event = await Event.db.findById(session, eventId);
    if (event == null || event.status != EventStatus.published) {
      return [];
    }

    return EventRegistration.db.find(
      session,
      where: (t) =>
          t.eventId.equals(eventId) & t.status.equals(EventRegistrationStatus.registered),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  /// Same search as [SearchEndpoint.search], reachable anonymously. See
  /// [performSearch] for the shared query/discoverability logic.
  Future<SearchResults> search(
    Session session, {
    String? query,
    Sport? sport,
    String? location,
  }) {
    return performSearch(session, query: query, sport: sport, location: location);
  }
}
