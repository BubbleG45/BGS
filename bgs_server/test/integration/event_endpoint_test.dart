import 'package:bgs_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Event endpoint', (sessionBuilder, endpoints) {
    Future<TestSessionBuilder> authedSessionFor(
      TestSessionBuilder builder,
    ) async {
      final authUser = await const AuthUsers().create(builder.build());
      return builder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          authUser.id.toString(),
          {},
        ),
      );
    }

    Future<Organization> createOrg(TestSessionBuilder ownerSession) {
      return endpoints.organization.create(
        ownerSession,
        name: 'Riverside Rec League',
        slug: 'riverside-rec-${DateTime.now().microsecondsSinceEpoch}',
      );
    }

    String uniqueSlug(String prefix) =>
        '$prefix-${DateTime.now().microsecondsSinceEpoch}';

    Future<Event> createOrgEvent(
      TestSessionBuilder session, {
      required UuidValue organizationId,
      String? slug,
    }) {
      return endpoints.event.create(
        session,
        organizationId: organizationId,
        name: 'Summer Kickball Tournament',
        slug: slug ?? uniqueSlug('summer-kickball'),
        sport: Sport.kickball,
        startAt: DateTime.now().add(const Duration(days: 14)),
        teamFeeCents: 6000,
      );
    }

    Future<Event> createOrglessEvent(
      TestSessionBuilder session, {
      String? slug,
    }) {
      return endpoints.event.create(
        session,
        name: 'Pickup Pickleball',
        slug: slug ?? uniqueSlug('pickup-pickleball'),
        sport: Sport.pickleball,
        startAt: DateTime.now().add(const Duration(days: 7)),
        teamFeeCents: 0,
      );
    }

    test(
      'when an org admin creates an org-scoped event then it starts in '
      'draft status',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);

        final event = await createOrgEvent(
          ownerSession,
          organizationId: org.id!,
        );

        expect(event.status, EventStatus.draft);
        expect(event.organizationId, org.id);
      },
    );

    test(
      'when a non-member tries to create an org-scoped event then it is '
      'denied',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final outsiderSession = await authedSessionFor(sessionBuilder);

        expect(
          () => createOrgEvent(outsiderSession, organizationId: org.id!),
          throwsA(isA<OrganizationAccessDeniedException>()),
        );
      },
    );

    test(
      'when any logged-in user creates an orgless event then it has no '
      'organization',
      () async {
        final creatorSession = await authedSessionFor(sessionBuilder);

        final event = await createOrglessEvent(creatorSession);

        expect(event.organizationId, isNull);
        expect(event.status, EventStatus.draft);
      },
    );

    test(
      'when creating an event with an already-used slug then it throws',
      () async {
        final creatorSession = await authedSessionFor(sessionBuilder);
        final slug = uniqueSlug('taken-slug');
        await createOrglessEvent(creatorSession, slug: slug);

        expect(
          () => createOrglessEvent(creatorSession, slug: slug),
          throwsA(isA<EventSlugTakenException>()),
        );
      },
    );

    test(
      'when an org admin publishes a draft org-scoped event then it '
      'becomes published',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final event = await createOrgEvent(
          ownerSession,
          organizationId: org.id!,
        );

        final published = await endpoints.event.publish(
          ownerSession,
          event.id!,
        );

        expect(published.status, EventStatus.published);
      },
    );

    test(
      'when the creator of an orgless event publishes it then it succeeds',
      () async {
        final creatorSession = await authedSessionFor(sessionBuilder);
        final event = await createOrglessEvent(creatorSession);

        final published = await endpoints.event.publish(
          creatorSession,
          event.id!,
        );

        expect(published.status, EventStatus.published);
      },
    );

    test(
      'when someone other than the creator tries to publish an orgless '
      'event then it is denied',
      () async {
        final creatorSession = await authedSessionFor(sessionBuilder);
        final event = await createOrglessEvent(creatorSession);
        final outsiderSession = await authedSessionFor(sessionBuilder);

        expect(
          () => endpoints.event.publish(outsiderSession, event.id!),
          throwsA(isA<EventAccessDeniedException>()),
        );
      },
    );

    test(
      'when publishing an already-published event then it throws',
      () async {
        final creatorSession = await authedSessionFor(sessionBuilder);
        final event = await createOrglessEvent(creatorSession);
        await endpoints.event.publish(creatorSession, event.id!);

        expect(
          () => endpoints.event.publish(creatorSession, event.id!),
          throwsA(isA<EventPublishNotAllowedException>()),
        );
      },
    );

    test(
      'when updating an event then its fields change',
      () async {
        final creatorSession = await authedSessionFor(sessionBuilder);
        final event = await createOrglessEvent(creatorSession);

        final updated = await endpoints.event.update(
          creatorSession,
          event.id!,
          name: 'Updated Name',
          teamFeeCents: 1500,
        );

        expect(updated.name, 'Updated Name');
        expect(updated.teamFeeCents, 1500);
        // Untouched fields survive the partial update.
        expect(updated.sport, Sport.pickleball);
      },
    );

    test(
      'when creating an event with registration dates and a rules link '
      'then they are stored',
      () async {
        final creatorSession = await authedSessionFor(sessionBuilder);
        final regOpens = DateTime.now().toUtc().add(const Duration(days: 1));
        final regCloses = DateTime.now().toUtc().add(const Duration(days: 5));

        final event = await endpoints.event.create(
          creatorSession,
          name: 'Dated Event',
          slug: uniqueSlug('dated-event'),
          sport: Sport.pickleball,
          startAt: DateTime.now().add(const Duration(days: 10)),
          teamFeeCents: 0,
          registrationOpensAt: regOpens,
          registrationClosesAt: regCloses,
          rulesUrl: 'https://example.com/event-rules',
        );

        expect(event.registrationOpensAt, regOpens);
        expect(event.registrationClosesAt, regCloses);
        expect(event.rulesUrl, 'https://example.com/event-rules');
      },
    );

    test(
      'when a user registers for a published event then their registration '
      'starts as registered',
      () async {
        final creatorSession = await authedSessionFor(sessionBuilder);
        final event = await createOrglessEvent(creatorSession);
        await endpoints.event.publish(creatorSession, event.id!);
        final playerSession = await authedSessionFor(sessionBuilder);

        final registration = await endpoints.event.register(
          playerSession,
          eventId: event.id!,
        );

        expect(registration.status, EventRegistrationStatus.registered);
        expect(registration.eventId, event.id);
      },
    );

    test(
      'when registering for a draft (unpublished) event then it throws',
      () async {
        final creatorSession = await authedSessionFor(sessionBuilder);
        final event = await createOrglessEvent(creatorSession);
        final playerSession = await authedSessionFor(sessionBuilder);

        expect(
          () => endpoints.event.register(playerSession, eventId: event.id!),
          throwsA(isA<EventNotOpenForRegistrationException>()),
        );
      },
    );

    test(
      'when a user registers for the same event twice then it throws',
      () async {
        final creatorSession = await authedSessionFor(sessionBuilder);
        final event = await createOrglessEvent(creatorSession);
        await endpoints.event.publish(creatorSession, event.id!);
        final playerSession = await authedSessionFor(sessionBuilder);
        await endpoints.event.register(playerSession, eventId: event.id!);

        expect(
          () => endpoints.event.register(playerSession, eventId: event.id!),
          throwsA(isA<EventRegistrationAlreadyExistsException>()),
        );
      },
    );

    test(
      'when a registrant cancels their own registration then it becomes '
      'cancelled',
      () async {
        final creatorSession = await authedSessionFor(sessionBuilder);
        final event = await createOrglessEvent(creatorSession);
        await endpoints.event.publish(creatorSession, event.id!);
        final playerSession = await authedSessionFor(sessionBuilder);
        final registration = await endpoints.event.register(
          playerSession,
          eventId: event.id!,
        );

        final cancelled = await endpoints.event.cancelRegistration(
          playerSession,
          registration.id!,
        );

        expect(cancelled.status, EventRegistrationStatus.cancelled);
      },
    );

    test(
      'when someone other than the registrant tries to cancel then it is '
      'denied',
      () async {
        final creatorSession = await authedSessionFor(sessionBuilder);
        final event = await createOrglessEvent(creatorSession);
        await endpoints.event.publish(creatorSession, event.id!);
        final playerSession = await authedSessionFor(sessionBuilder);
        final registration = await endpoints.event.register(
          playerSession,
          eventId: event.id!,
        );
        final outsiderSession = await authedSessionFor(sessionBuilder);

        expect(
          () => endpoints.event.cancelRegistration(
            outsiderSession,
            registration.id!,
          ),
          throwsA(isA<EventRegistrationAccessDeniedException>()),
        );
      },
    );

    test(
      'when cancelling an already-cancelled registration then it throws',
      () async {
        final creatorSession = await authedSessionFor(sessionBuilder);
        final event = await createOrglessEvent(creatorSession);
        await endpoints.event.publish(creatorSession, event.id!);
        final playerSession = await authedSessionFor(sessionBuilder);
        final registration = await endpoints.event.register(
          playerSession,
          eventId: event.id!,
        );
        await endpoints.event.cancelRegistration(
          playerSession,
          registration.id!,
        );

        expect(
          () => endpoints.event.cancelRegistration(
            playerSession,
            registration.id!,
          ),
          throwsA(isA<EventRegistrationActionNotAllowedException>()),
        );
      },
    );

    test(
      'when a player checks listMyRegistrations then it includes their '
      'registration',
      () async {
        final creatorSession = await authedSessionFor(sessionBuilder);
        final event = await createOrglessEvent(creatorSession);
        await endpoints.event.publish(creatorSession, event.id!);
        final playerSession = await authedSessionFor(sessionBuilder);
        final registration = await endpoints.event.register(
          playerSession,
          eventId: event.id!,
        );

        final mine = await endpoints.event.listMyRegistrations(
          playerSession,
        );

        expect(mine.map((r) => r.id), contains(registration.id));
      },
    );

    test(
      'when anyone (even non-members) reads events then it succeeds',
      () async {
        final ownerSession = await authedSessionFor(sessionBuilder);
        final org = await createOrg(ownerSession);
        final event = await createOrgEvent(
          ownerSession,
          organizationId: org.id!,
        );
        final outsiderSession = await authedSessionFor(sessionBuilder);

        final byId = await endpoints.event.getById(
          outsiderSession,
          event.id!,
        );
        expect(byId?.id, event.id);

        final bySlug = await endpoints.event.getBySlug(
          outsiderSession,
          event.slug,
        );
        expect(bySlug?.id, event.id);

        final listed = await endpoints.event.listByOrganization(
          outsiderSession,
          org.id!,
        );
        expect(listed.map((e) => e.id), contains(event.id));
      },
    );
  });
}
