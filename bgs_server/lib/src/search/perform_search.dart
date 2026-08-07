import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

const _searchResultLimit = 20;

/// Basic search across organizations, active leagues, and published events
/// -- by name and/or sport. Shared by [SearchEndpoint] (authenticated) and
/// [PublicEndpoint] (anonymous); the query logic itself doesn't depend on
/// who's asking, only on what's discoverable. See [SearchEndpoint] for the
/// discoverability rules (why leagues/events are status-filtered and orgs
/// aren't).
Future<SearchResults> performSearch(
  Session session, {
  String? query,
  Sport? sport,
  String? location,
}) async {
  final trimmed = query?.trim();
  final pattern = (trimmed == null || trimmed.isEmpty)
      ? null
      : '%${_escapeLikePattern(trimmed)}%';

  final trimmedLocation = location?.trim();
  final locationPattern = (trimmedLocation == null || trimmedLocation.isEmpty)
      ? null
      : '%${_escapeLikePattern(trimmedLocation)}%';

  // Organizations have no location field, so a location-only filter (like
  // a sport-only filter) narrows results away from organizations entirely.
  final includeOrganizations = pattern != null || (sport == null && locationPattern == null);

  final organizations = includeOrganizations
      ? await Organization.db.find(
          session,
          where: pattern == null ? null : (t) => t.name.ilike(pattern),
          orderBy: (t) => t.name,
          limit: _searchResultLimit,
        )
      : <Organization>[];

  final leagues = await League.db.find(
    session,
    where: (t) {
      Expression expr = t.status.equals(LeagueStatus.active);
      if (pattern != null) expr = expr & t.name.ilike(pattern);
      if (sport != null) expr = expr & t.sport.equals(sport);
      if (locationPattern != null) expr = expr & t.location.ilike(locationPattern);
      return expr;
    },
    orderBy: (t) => t.name,
    limit: _searchResultLimit,
  );

  final events = await Event.db.find(
    session,
    where: (t) {
      Expression expr = t.status.equals(EventStatus.published);
      if (pattern != null) expr = expr & t.name.ilike(pattern);
      if (sport != null) expr = expr & t.sport.equals(sport);
      if (locationPattern != null) expr = expr & t.location.ilike(locationPattern);
      return expr;
    },
    orderBy: (t) => t.startAt,
    limit: _searchResultLimit,
  );

  return SearchResults(organizations: organizations, leagues: leagues, events: events);
}

/// Escapes LIKE/ILIKE wildcard characters in user input so a search for
/// e.g. `50%` doesn't get interpreted as a wildcard pattern.
String _escapeLikePattern(String input) {
  return input.replaceAll('\\', '\\\\').replaceAll('%', '\\%').replaceAll('_', '\\_');
}
