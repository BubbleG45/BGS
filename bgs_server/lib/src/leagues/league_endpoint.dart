import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../organizations/organization_access.dart';

/// Leagues are full seasons run by an [Organization] for a single sport.
/// See BUILD_PLAN.md for the domain model.
class LeagueEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Creates a new league within an organization. Requires at least `admin`
  /// on the organization. Starts in `draft` status -- see [activate].
  Future<League> create(
    Session session, {
    required UuidValue organizationId,
    required String name,
    required String slug,
    required Sport sport,
    required int teamFeeCents,
    SkillLevel? skillLevel,
    String? description,
    String? location,
    DateTime? seasonStartAt,
    DateTime? seasonEndAt,
    DateTime? registrationOpensAt,
    DateTime? registrationClosesAt,
    String? rulesUrl,
  }) async {
    await requireOrgRole(
      session,
      organizationId,
      minRole: OrgMemberRole.admin,
    );

    return session.db.transaction((transaction) async {
      // Pre-check for a friendlier error than a raw DB constraint violation.
      // The unique index on (organizationId, slug) remains the real
      // backstop against a race between two concurrent creates.
      final existing = await League.db.findFirstRow(
        session,
        where: (t) =>
            t.organizationId.equals(organizationId) & t.slug.equals(slug),
        transaction: transaction,
      );
      if (existing != null) {
        throw LeagueSlugTakenException(
          organizationId: organizationId,
          slug: slug,
        );
      }

      return League.db.insertRow(
        session,
        League(
          organizationId: organizationId,
          name: name,
          slug: slug,
          sport: sport,
          skillLevel: skillLevel,
          description: description,
          location: location,
          teamFeeCents: teamFeeCents,
          seasonStartAt: seasonStartAt,
          seasonEndAt: seasonEndAt,
          registrationOpensAt: registrationOpensAt,
          registrationClosesAt: registrationClosesAt,
          rulesUrl: rulesUrl,
        ),
        transaction: transaction,
      );
    });
  }

  /// Returns a single league by id. Public -- league pages are public.
  Future<League?> getById(Session session, UuidValue leagueId) async {
    return League.db.findById(session, leagueId);
  }

  /// Returns a single league by its org-scoped slug. Public.
  Future<League?> getByOrgAndSlug(
    Session session, {
    required UuidValue organizationId,
    required String slug,
  }) async {
    return League.db.findFirstRow(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.slug.equals(slug),
    );
  }

  /// Returns all leagues for an organization, newest first. Public -- backs
  /// the org homepage's "show leagues" list.
  Future<List<League>> listByOrganization(
    Session session,
    UuidValue organizationId,
  ) async {
    return League.db.find(
      session,
      where: (t) => t.organizationId.equals(organizationId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  /// Updates a league's basic details. Requires at least `admin` on the
  /// league's organization.
  Future<League> update(
    Session session,
    UuidValue leagueId, {
    String? name,
    String? description,
    String? location,
    SkillLevel? skillLevel,
    int? teamFeeCents,
    DateTime? seasonStartAt,
    DateTime? seasonEndAt,
    DateTime? registrationOpensAt,
    DateTime? registrationClosesAt,
    String? rulesUrl,
  }) async {
    final league = await _findLeagueOrThrow(session, leagueId);

    await requireOrgRole(
      session,
      league.organizationId,
      minRole: OrgMemberRole.admin,
    );

    return League.db.updateRow(
      session,
      league.copyWith(
        name: name ?? league.name,
        description: description ?? league.description,
        location: location ?? league.location,
        skillLevel: skillLevel ?? league.skillLevel,
        teamFeeCents: teamFeeCents ?? league.teamFeeCents,
        seasonStartAt: seasonStartAt ?? league.seasonStartAt,
        seasonEndAt: seasonEndAt ?? league.seasonEndAt,
        registrationOpensAt: registrationOpensAt ?? league.registrationOpensAt,
        registrationClosesAt: registrationClosesAt ?? league.registrationClosesAt,
        rulesUrl: rulesUrl ?? league.rulesUrl,
      ),
    );
  }

  /// Activates a draft league, making it publicly visible for registration.
  /// Requires at least `admin` on the league's organization.
  Future<League> activate(Session session, UuidValue leagueId) async {
    final league = await _findLeagueOrThrow(session, leagueId);

    await requireOrgRole(
      session,
      league.organizationId,
      minRole: OrgMemberRole.admin,
    );

    if (league.status != LeagueStatus.draft) {
      throw LeagueActivationNotAllowedException(
        leagueId: leagueId,
        currentStatus: league.status,
      );
    }

    return League.db.updateRow(
      session,
      league.copyWith(status: LeagueStatus.active),
    );
  }

  /// Marks an active league's season as finished. Requires at least `admin`
  /// on the league's organization. This is the only way a league ever
  /// reaches `completed` -- without it, the org page's "Past" bucket and
  /// Phase B's non-bracket winner determination would have nothing to work
  /// with.
  Future<League> complete(Session session, UuidValue leagueId) async {
    final league = await _findLeagueOrThrow(session, leagueId);

    await requireOrgRole(
      session,
      league.organizationId,
      minRole: OrgMemberRole.admin,
    );

    if (league.status != LeagueStatus.active) {
      throw LeagueCompletionNotAllowedException(
        leagueId: leagueId,
        currentStatus: league.status,
      );
    }

    return League.db.updateRow(
      session,
      league.copyWith(status: LeagueStatus.completed),
    );
  }

  Future<League> _findLeagueOrThrow(
    Session session,
    UuidValue leagueId,
  ) async {
    final league = await League.db.findById(session, leagueId);
    if (league == null) {
      throw LeagueNotFoundException(leagueId: leagueId);
    }
    return league;
  }
}
