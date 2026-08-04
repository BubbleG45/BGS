import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Basic search across organizations, leagues, and events -- by name and/or
/// sport. No ranking or pagination yet, just a capped, name-ordered list per
/// category; a later enhancement once there's enough data for either to
/// matter.
///
/// Only *discoverable* rows are searchable: leagues must be `active` and
/// events must be `published` -- a draft an organizer hasn't published yet
/// shouldn't show up in search just because its name matches. Organizations
/// have no such status (an org homepage is public as soon as it exists).
class SearchEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static const _resultLimit = 20;

  Future<SearchResults> search(
    Session session, {
    String? query,
    Sport? sport,
  }) async {
    final trimmed = query?.trim();
    final pattern = (trimmed == null || trimmed.isEmpty)
        ? null
        : '%${_escapeLikePattern(trimmed)}%';

    // A sport-only search isn't meaningful for organizations (they aren't
    // tied to a single sport), so skip them rather than returning every org
    // when the caller only asked to filter by sport.
    final includeOrganizations = pattern != null || sport == null;

    final organizations = includeOrganizations
        ? await Organization.db.find(
            session,
            where: pattern == null ? null : (t) => t.name.ilike(pattern),
            orderBy: (t) => t.name,
            limit: _resultLimit,
          )
        : <Organization>[];

    final leagues = await League.db.find(
      session,
      where: (t) {
        Expression expr = t.status.equals(LeagueStatus.active);
        if (pattern != null) expr = expr & t.name.ilike(pattern);
        if (sport != null) expr = expr & t.sport.equals(sport);
        return expr;
      },
      orderBy: (t) => t.name,
      limit: _resultLimit,
    );

    final events = await Event.db.find(
      session,
      where: (t) {
        Expression expr = t.status.equals(EventStatus.published);
        if (pattern != null) expr = expr & t.name.ilike(pattern);
        if (sport != null) expr = expr & t.sport.equals(sport);
        return expr;
      },
      orderBy: (t) => t.startAt,
      limit: _resultLimit,
    );

    return SearchResults(
      organizations: organizations,
      leagues: leagues,
      events: events,
    );
  }

  /// Escapes LIKE/ILIKE wildcard characters in user input so a search for
  /// e.g. `50%` doesn't get interpreted as a wildcard pattern.
  String _escapeLikePattern(String input) {
    return input
        .replaceAll('\\', '\\\\')
        .replaceAll('%', '\\%')
        .replaceAll('_', '\\_');
  }
}
