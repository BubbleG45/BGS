import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'perform_search.dart';

/// Basic search across organizations, leagues, and events -- by name and/or
/// sport. No ranking or pagination yet, just a capped, name-ordered list per
/// category; a later enhancement once there's enough data for either to
/// matter.
///
/// Only *discoverable* rows are searchable: leagues must be `active` and
/// events must be `published` -- a draft an organizer hasn't published yet
/// shouldn't show up in search just because its name matches. Organizations
/// have no such status (an org homepage is public as soon as it exists).
///
/// The actual query logic lives in [performSearch], shared with
/// [PublicEndpoint.search] -- the rules for what's discoverable don't depend
/// on whether the caller is logged in.
class SearchEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<SearchResults> search(Session session, {String? query, Sport? sport}) {
    return performSearch(session, query: query, sport: sport);
  }
}
