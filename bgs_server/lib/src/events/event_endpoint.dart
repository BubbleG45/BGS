import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

import '../generated/protocol.dart';
import '../organizations/organization_access.dart';

/// One-off events -- may belong to an [Organization], or be "orgless"
/// (`organizationId == null`). See BUILD_PLAN.md for the domain model.
///
/// Org-scoped events use [requireOrgRole] like every other org-owned write
/// in the app. Orgless events have no organization to check a role
/// against, so management permission instead falls to whoever created the
/// event -- see [_requireManagePermission].
class EventEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Creates a new event, either within an organization or "orgless".
  /// Starts in `draft` status -- see [publish].
  Future<Event> create(
    Session session, {
    UuidValue? organizationId,
    required String name,
    required String slug,
    required Sport sport,
    required DateTime startAt,
    required int teamFeeCents,
    SkillLevel? skillLevel,
    String? description,
    String? location,
    bool? isTournament,
  }) async {
    final authUserId = session.authenticated!.authUserId;

    if (organizationId != null) {
      await requireOrgRole(
        session,
        organizationId,
        minRole: OrgMemberRole.admin,
      );
    }

    return session.db.transaction((transaction) async {
      // Pre-check for a friendlier error than a raw DB constraint violation.
      // The unique index on Event.slug remains the real backstop against a
      // race between two concurrent creates of the same slug.
      final existing = await Event.db.findFirstRow(
        session,
        where: (t) => t.slug.equals(slug),
        transaction: transaction,
      );
      if (existing != null) {
        throw EventSlugTakenException(slug: slug);
      }

      return Event.db.insertRow(
        session,
        Event(
          organizationId: organizationId,
          createdByAuthUserId: authUserId,
          name: name,
          slug: slug,
          sport: sport,
          skillLevel: skillLevel,
          description: description,
          location: location,
          startAt: startAt,
          isTournament: isTournament,
          teamFeeCents: teamFeeCents,
        ),
        transaction: transaction,
      );
    });
  }

  /// Returns a single event by id. Public -- event pages are public.
  Future<Event?> getById(Session session, UuidValue eventId) async {
    return Event.db.findById(session, eventId);
  }

  /// Returns a single event by its globally-unique slug. Public -- this is
  /// what backs the shareable event link, e.g. `/e/<slug>`.
  Future<Event?> getBySlug(Session session, String slug) async {
    return Event.db.findFirstRow(session, where: (t) => t.slug.equals(slug));
  }

  /// Returns all events for an organization, newest first. Public -- backs
  /// the org homepage's "show events" list. Orgless events aren't returned
  /// here since they have no organization to list them under.
  Future<List<Event>> listByOrganization(
    Session session,
    UuidValue organizationId,
  ) async {
    return Event.db.find(
      session,
      where: (t) => t.organizationId.equals(organizationId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  /// Updates an event's basic details. Requires manage permission -- see
  /// [_requireManagePermission].
  Future<Event> update(
    Session session,
    UuidValue eventId, {
    String? name,
    String? description,
    String? location,
    SkillLevel? skillLevel,
    DateTime? startAt,
    int? teamFeeCents,
  }) async {
    final event = await _findEventOrThrow(session, eventId);
    await _requireManagePermission(session, event);

    return Event.db.updateRow(
      session,
      event.copyWith(
        name: name ?? event.name,
        description: description ?? event.description,
        location: location ?? event.location,
        skillLevel: skillLevel ?? event.skillLevel,
        startAt: startAt ?? event.startAt,
        teamFeeCents: teamFeeCents ?? event.teamFeeCents,
      ),
    );
  }

  /// Publishes a draft event, making it publicly visible for registration.
  /// Requires manage permission -- see [_requireManagePermission].
  Future<Event> publish(Session session, UuidValue eventId) async {
    final event = await _findEventOrThrow(session, eventId);
    await _requireManagePermission(session, event);

    if (event.status != EventStatus.draft) {
      throw EventPublishNotAllowedException(
        eventId: eventId,
        currentStatus: event.status,
      );
    }

    return Event.db.updateRow(
      session,
      event.copyWith(status: EventStatus.published),
    );
  }

  /// Registers the calling user for a published event.
  Future<EventRegistration> register(
    Session session, {
    required UuidValue eventId,
    String? teamName,
  }) async {
    final event = await _findEventOrThrow(session, eventId);
    if (event.status != EventStatus.published) {
      throw EventNotOpenForRegistrationException(
        eventId: eventId,
        currentStatus: event.status,
      );
    }

    final authUserId = session.authenticated!.authUserId;

    return session.db.transaction((transaction) async {
      final existing = await EventRegistration.db.findFirstRow(
        session,
        where: (t) =>
            t.eventId.equals(eventId) &
            t.registeredByAuthUserId.equals(authUserId),
        transaction: transaction,
      );
      if (existing != null) {
        throw EventRegistrationAlreadyExistsException(eventId: eventId);
      }

      return EventRegistration.db.insertRow(
        session,
        EventRegistration(
          eventId: eventId,
          registeredByAuthUserId: authUserId,
          teamName: teamName,
        ),
        transaction: transaction,
      );
    });
  }

  /// Cancels a registration. Callable only by the registrant themselves.
  Future<EventRegistration> cancelRegistration(
    Session session,
    UuidValue registrationId,
  ) async {
    final registration = await EventRegistration.db.findById(
      session,
      registrationId,
    );
    if (registration == null) {
      throw EventRegistrationNotFoundException(registrationId: registrationId);
    }

    final authUserId = session.authenticated!.authUserId;
    if (registration.registeredByAuthUserId != authUserId) {
      throw EventRegistrationAccessDeniedException(
        registrationId: registrationId,
      );
    }

    if (registration.status != EventRegistrationStatus.registered) {
      throw EventRegistrationActionNotAllowedException(
        registrationId: registrationId,
        currentStatus: registration.status,
      );
    }

    return EventRegistration.db.updateRow(
      session,
      registration.copyWith(status: EventRegistrationStatus.cancelled),
    );
  }

  /// Returns the calling user's own event registrations. Backs the Player
  /// Dashboard ("my events").
  Future<List<EventRegistration>> listMyRegistrations(Session session) async {
    final authUserId = session.authenticated!.authUserId;

    return EventRegistration.db.find(
      session,
      where: (t) => t.registeredByAuthUserId.equals(authUserId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  /// Checks that the calling user can manage [event]: `admin`+ on the
  /// organization for org-scoped events, or the event's creator for
  /// orgless events (which have no organization to check a role against).
  Future<void> _requireManagePermission(Session session, Event event) async {
    final organizationId = event.organizationId;
    if (organizationId != null) {
      await requireOrgRole(
        session,
        organizationId,
        minRole: OrgMemberRole.admin,
      );
      return;
    }

    final authUserId = session.authenticated!.authUserId;
    if (event.createdByAuthUserId != authUserId) {
      throw EventAccessDeniedException(eventId: event.id!);
    }
  }

  Future<Event> _findEventOrThrow(Session session, UuidValue eventId) async {
    final event = await Event.db.findById(session, eventId);
    if (event == null) {
      throw EventNotFoundException(eventId: eventId);
    }
    return event;
  }
}
