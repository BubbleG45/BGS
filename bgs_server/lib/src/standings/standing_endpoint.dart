import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Read-only: [Standing] rows are a recomputed aggregate maintained by
/// [ScheduledMatchEndpoint.recordResult], not a separate source of truth,
/// so there's no create/update surface here.
class StandingEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Returns a league's standings, best record first. Public -- backs the
  /// league standings page.
  ///
  /// Sorted by wins only for Phase 1; a smarter sort (win percentage,
  /// point differential as a tiebreaker) is a later enhancement once
  /// leagues have played enough games for it to matter.
  Future<List<Standing>> listByLeague(
    Session session,
    UuidValue leagueId,
  ) async {
    return Standing.db.find(
      session,
      where: (t) => t.leagueId.equals(leagueId),
      orderBy: (t) => t.wins,
      orderDescending: true,
    );
  }
}
