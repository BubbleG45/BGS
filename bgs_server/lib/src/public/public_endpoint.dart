import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

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

  /// Returns an organization's *active* leagues, newest first. Draft
  /// leagues aren't announced yet, so they're excluded here even though an
  /// organizer sees them on their own dashboard.
  Future<List<League>> activeLeaguesByOrganization(
    Session session,
    UuidValue organizationId,
  ) async {
    return League.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.status.equals(LeagueStatus.active),
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
}
