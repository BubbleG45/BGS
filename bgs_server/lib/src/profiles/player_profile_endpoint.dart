import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

import '../generated/protocol.dart';

/// The BGS-owned half of profile data that doesn't live on the auth
/// module's `UserProfile` (see [PlayerProfile]'s doc comment). Always
/// self-scoped to the calling user, same as [ProfileEndpoint].
class PlayerProfileEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Returns the caller's own [PlayerProfile], or `null` if they haven't
  /// set a bio yet -- the row is created lazily on first [updateBio].
  Future<PlayerProfile?> getMine(Session session) async {
    final authUserId = session.authenticated!.authUserId;
    return PlayerProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
  }

  /// Creates or updates the caller's own bio.
  Future<PlayerProfile> updateBio(Session session, String bio) async {
    final authUserId = session.authenticated!.authUserId;

    final existing = await PlayerProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );

    if (existing == null) {
      return PlayerProfile.db.insertRow(
        session,
        PlayerProfile(authUserId: authUserId, bio: bio),
      );
    }

    return PlayerProfile.db.updateRow(
      session,
      existing.copyWith(bio: bio, updatedAt: DateTime.now().toUtc()),
    );
  }

  /// Wins/losses/ties summed across every [Standing] row for a team the
  /// caller has actively been a member of -- one row per team, since a
  /// team belongs to exactly one league. No player-level stats exist
  /// (goals/assists/etc, see BUILD_PLAN.md Phase C); this is purely a
  /// roll-up of team-level results the caller was part of.
  Future<PlayerStats> stats(Session session) async {
    final authUserId = session.authenticated!.authUserId;

    final activeMemberships = await TeamMembership.db.find(
      session,
      where: (t) =>
          t.authUserId.equals(authUserId) &
          t.status.equals(MembershipStatus.active),
    );
    final teamIds = activeMemberships.map((m) => m.teamId).toSet();

    if (teamIds.isEmpty) {
      return PlayerStats(wins: 0, losses: 0, ties: 0, teamCount: 0);
    }

    final standings = await Standing.db.find(
      session,
      where: (t) => t.teamId.inSet(teamIds),
    );

    var wins = 0, losses = 0, ties = 0;
    for (final standing in standings) {
      wins += standing.wins;
      losses += standing.losses;
      ties += standing.ties;
    }

    return PlayerStats(
      wins: wins,
      losses: losses,
      ties: ties,
      teamCount: teamIds.length,
    );
  }
}
