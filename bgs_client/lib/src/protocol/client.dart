/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i1;
import 'package:serverpod_client/serverpod_client.dart' as _i2;
import 'dart:async' as _i3;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i4;
import 'package:bgs_client/src/protocol/dashboards/models/player_dashboard.dart'
    as _i5;
import 'package:bgs_client/src/protocol/dashboards/models/organizer_dashboard.dart'
    as _i6;
import 'package:bgs_client/src/protocol/dashboards/models/manager_dashboard.dart'
    as _i7;
import 'package:bgs_client/src/protocol/events/models/event.dart' as _i8;
import 'package:bgs_client/src/protocol/sports/models/sport.dart' as _i9;
import 'package:bgs_client/src/protocol/sports/models/skill_level.dart' as _i10;
import 'package:bgs_client/src/protocol/events/models/event_registration.dart'
    as _i11;
import 'package:bgs_client/src/protocol/greetings/greeting.dart' as _i12;
import 'package:bgs_client/src/protocol/leagues/models/league.dart' as _i13;
import 'package:bgs_client/src/protocol/organizations/models/organization.dart'
    as _i14;
import 'package:bgs_client/src/protocol/organizations/models/organization_membership.dart'
    as _i15;
import 'package:bgs_client/src/protocol/profiles/models/player_profile.dart'
    as _i16;
import 'package:bgs_client/src/protocol/profiles/models/player_stats.dart'
    as _i17;
import 'dart:typed_data' as _i18;
import 'package:bgs_client/src/protocol/teams/models/team.dart' as _i19;
import 'package:bgs_client/src/protocol/standings/models/standing.dart' as _i20;
import 'package:bgs_client/src/protocol/scheduling/models/scheduled_match.dart'
    as _i21;
import 'package:bgs_client/src/protocol/search/models/search_results.dart'
    as _i22;
import 'package:bgs_client/src/protocol/scheduling/models/match_attendance.dart'
    as _i23;
import 'package:bgs_client/src/protocol/scheduling/models/attendance_status.dart'
    as _i24;
import 'package:bgs_client/src/protocol/teams/models/team_membership.dart'
    as _i25;
import 'package:bgs_client/src/protocol/teams/models/team_member_role.dart'
    as _i26;
import 'protocol.dart' as _i27;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i1.EndpointEmailIdpBase {
  EndpointEmailIdp(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<_i4.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i3.Future<_i2.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i3.Future<String> verifyRegistrationCode({
    required _i2.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i3.Future<_i4.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i3.Future<_i2.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i3.Future<String> verifyPasswordResetCode({
    required _i2.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _i3.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i4.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i3.Future<_i4.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// Composed, self-scoped reads backing the three dashboards from
/// BUILD_PLAN.md §6. Deliberately server-side rather than assembled
/// client-side, to keep the Flutter app thin and avoid N+1-style chains of
/// calls from the client for what's fundamentally one screen's worth of
/// data.
///
/// No writes and no new typed exceptions here -- everything is a read
/// scoped to the calling user via `session.authenticated`, composed from
/// tables that already exist.
/// {@category Endpoint}
class EndpointDashboard extends _i2.EndpointRef {
  EndpointDashboard(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dashboard';

  /// "My teams/events" -- team memberships (any status, so pending invites
  /// show up too), event registrations, and upcoming matches for teams the
  /// player is actively on.
  _i3.Future<_i5.PlayerDashboard> player() =>
      caller.callServerEndpoint<_i5.PlayerDashboard>(
        'dashboard',
        'player',
        {},
      );

  /// "My orgs/leagues/events" -- organizations the caller is a member of
  /// (with their role), leagues across those orgs, and events (org-scoped
  /// across those orgs, plus any orgless events the caller created).
  _i3.Future<_i6.OrganizerDashboard> organizer() =>
      caller.callServerEndpoint<_i6.OrganizerDashboard>(
        'dashboard',
        'organizer',
        {},
      );

  /// "My team(s)" -- the teams the caller actively manages.
  _i3.Future<_i7.ManagerDashboard> manager() =>
      caller.callServerEndpoint<_i7.ManagerDashboard>(
        'dashboard',
        'manager',
        {},
      );
}

/// One-off events -- may belong to an [Organization], or be "orgless"
/// (`organizationId == null`). See BUILD_PLAN.md for the domain model.
///
/// Org-scoped events use [requireOrgRole] like every other org-owned write
/// in the app. Orgless events have no organization to check a role
/// against, so management permission instead falls to whoever created the
/// event -- see [_requireManagePermission].
/// {@category Endpoint}
class EndpointEvent extends _i2.EndpointRef {
  EndpointEvent(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'event';

  /// Creates a new event, either within an organization or "orgless".
  /// Starts in `draft` status -- see [publish].
  _i3.Future<_i8.Event> create({
    _i2.UuidValue? organizationId,
    required String name,
    required String slug,
    required _i9.Sport sport,
    required DateTime startAt,
    required int teamFeeCents,
    _i10.SkillLevel? skillLevel,
    String? description,
    String? location,
    bool? isTournament,
    DateTime? registrationOpensAt,
    DateTime? registrationClosesAt,
    String? rulesUrl,
  }) => caller.callServerEndpoint<_i8.Event>(
    'event',
    'create',
    {
      'organizationId': organizationId,
      'name': name,
      'slug': slug,
      'sport': sport,
      'startAt': startAt,
      'teamFeeCents': teamFeeCents,
      'skillLevel': skillLevel,
      'description': description,
      'location': location,
      'isTournament': isTournament,
      'registrationOpensAt': registrationOpensAt,
      'registrationClosesAt': registrationClosesAt,
      'rulesUrl': rulesUrl,
    },
  );

  /// Returns a single event by id. Public -- event pages are public.
  _i3.Future<_i8.Event?> getById(_i2.UuidValue eventId) =>
      caller.callServerEndpoint<_i8.Event?>(
        'event',
        'getById',
        {'eventId': eventId},
      );

  /// Returns a single event by its globally-unique slug. Public -- this is
  /// what backs the shareable event link, e.g. `/e/<slug>`.
  _i3.Future<_i8.Event?> getBySlug(String slug) =>
      caller.callServerEndpoint<_i8.Event?>(
        'event',
        'getBySlug',
        {'slug': slug},
      );

  /// Returns all events for an organization, newest first. Public -- backs
  /// the org homepage's "show events" list. Orgless events aren't returned
  /// here since they have no organization to list them under.
  _i3.Future<List<_i8.Event>> listByOrganization(
    _i2.UuidValue organizationId,
  ) => caller.callServerEndpoint<List<_i8.Event>>(
    'event',
    'listByOrganization',
    {'organizationId': organizationId},
  );

  /// Updates an event's basic details. Requires manage permission -- see
  /// [_requireManagePermission].
  _i3.Future<_i8.Event> update(
    _i2.UuidValue eventId, {
    String? name,
    String? description,
    String? location,
    _i10.SkillLevel? skillLevel,
    DateTime? startAt,
    int? teamFeeCents,
    DateTime? registrationOpensAt,
    DateTime? registrationClosesAt,
    String? rulesUrl,
  }) => caller.callServerEndpoint<_i8.Event>(
    'event',
    'update',
    {
      'eventId': eventId,
      'name': name,
      'description': description,
      'location': location,
      'skillLevel': skillLevel,
      'startAt': startAt,
      'teamFeeCents': teamFeeCents,
      'registrationOpensAt': registrationOpensAt,
      'registrationClosesAt': registrationClosesAt,
      'rulesUrl': rulesUrl,
    },
  );

  /// Publishes a draft event, making it publicly visible for registration.
  /// Requires manage permission -- see [_requireManagePermission].
  _i3.Future<_i8.Event> publish(_i2.UuidValue eventId) =>
      caller.callServerEndpoint<_i8.Event>(
        'event',
        'publish',
        {'eventId': eventId},
      );

  /// Registers the calling user for a published event.
  _i3.Future<_i11.EventRegistration> register({
    required _i2.UuidValue eventId,
    String? teamName,
  }) => caller.callServerEndpoint<_i11.EventRegistration>(
    'event',
    'register',
    {
      'eventId': eventId,
      'teamName': teamName,
    },
  );

  /// Cancels a registration. Callable only by the registrant themselves.
  _i3.Future<_i11.EventRegistration> cancelRegistration(
    _i2.UuidValue registrationId,
  ) => caller.callServerEndpoint<_i11.EventRegistration>(
    'event',
    'cancelRegistration',
    {'registrationId': registrationId},
  );

  /// Returns the calling user's own event registrations. Backs the Player
  /// Dashboard ("my events").
  _i3.Future<List<_i11.EventRegistration>> listMyRegistrations() =>
      caller.callServerEndpoint<List<_i11.EventRegistration>>(
        'event',
        'listMyRegistrations',
        {},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i2.EndpointRef {
  EndpointGreeting(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i3.Future<_i12.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i12.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

/// Leagues are full seasons run by an [Organization] for a single sport.
/// See BUILD_PLAN.md for the domain model.
/// {@category Endpoint}
class EndpointLeague extends _i2.EndpointRef {
  EndpointLeague(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'league';

  /// Creates a new league within an organization. Requires at least `admin`
  /// on the organization. Starts in `draft` status -- see [activate].
  _i3.Future<_i13.League> create({
    required _i2.UuidValue organizationId,
    required String name,
    required String slug,
    required _i9.Sport sport,
    required int teamFeeCents,
    _i10.SkillLevel? skillLevel,
    String? description,
    String? location,
    DateTime? seasonStartAt,
    DateTime? seasonEndAt,
    DateTime? registrationOpensAt,
    DateTime? registrationClosesAt,
    String? rulesUrl,
  }) => caller.callServerEndpoint<_i13.League>(
    'league',
    'create',
    {
      'organizationId': organizationId,
      'name': name,
      'slug': slug,
      'sport': sport,
      'teamFeeCents': teamFeeCents,
      'skillLevel': skillLevel,
      'description': description,
      'location': location,
      'seasonStartAt': seasonStartAt,
      'seasonEndAt': seasonEndAt,
      'registrationOpensAt': registrationOpensAt,
      'registrationClosesAt': registrationClosesAt,
      'rulesUrl': rulesUrl,
    },
  );

  /// Returns a single league by id. Public -- league pages are public.
  _i3.Future<_i13.League?> getById(_i2.UuidValue leagueId) =>
      caller.callServerEndpoint<_i13.League?>(
        'league',
        'getById',
        {'leagueId': leagueId},
      );

  /// Returns a single league by its org-scoped slug. Public.
  _i3.Future<_i13.League?> getByOrgAndSlug({
    required _i2.UuidValue organizationId,
    required String slug,
  }) => caller.callServerEndpoint<_i13.League?>(
    'league',
    'getByOrgAndSlug',
    {
      'organizationId': organizationId,
      'slug': slug,
    },
  );

  /// Returns all leagues for an organization, newest first. Public -- backs
  /// the org homepage's "show leagues" list.
  _i3.Future<List<_i13.League>> listByOrganization(
    _i2.UuidValue organizationId,
  ) => caller.callServerEndpoint<List<_i13.League>>(
    'league',
    'listByOrganization',
    {'organizationId': organizationId},
  );

  /// Updates a league's basic details. Requires at least `admin` on the
  /// league's organization.
  _i3.Future<_i13.League> update(
    _i2.UuidValue leagueId, {
    String? name,
    String? description,
    String? location,
    _i10.SkillLevel? skillLevel,
    int? teamFeeCents,
    DateTime? seasonStartAt,
    DateTime? seasonEndAt,
    DateTime? registrationOpensAt,
    DateTime? registrationClosesAt,
    String? rulesUrl,
  }) => caller.callServerEndpoint<_i13.League>(
    'league',
    'update',
    {
      'leagueId': leagueId,
      'name': name,
      'description': description,
      'location': location,
      'skillLevel': skillLevel,
      'teamFeeCents': teamFeeCents,
      'seasonStartAt': seasonStartAt,
      'seasonEndAt': seasonEndAt,
      'registrationOpensAt': registrationOpensAt,
      'registrationClosesAt': registrationClosesAt,
      'rulesUrl': rulesUrl,
    },
  );

  /// Activates a draft league, making it publicly visible for registration.
  /// Requires at least `admin` on the league's organization.
  _i3.Future<_i13.League> activate(_i2.UuidValue leagueId) =>
      caller.callServerEndpoint<_i13.League>(
        'league',
        'activate',
        {'leagueId': leagueId},
      );

  /// Marks an active league's season as finished. Requires at least `admin`
  /// on the league's organization. This is the only way a league ever
  /// reaches `completed` -- without it, the org page's "Past" bucket and
  /// Phase B's non-bracket winner determination would have nothing to work
  /// with.
  _i3.Future<_i13.League> complete(_i2.UuidValue leagueId) =>
      caller.callServerEndpoint<_i13.League>(
        'league',
        'complete',
        {'leagueId': leagueId},
      );
}

/// Organizations are the top-level entity organizers create leagues and
/// events under. See BUILD_PLAN.md for the domain model.
/// {@category Endpoint}
class EndpointOrganization extends _i2.EndpointRef {
  EndpointOrganization(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'organization';

  /// Creates a new organization and makes the calling user its owner.
  _i3.Future<_i14.Organization> create({
    required String name,
    required String slug,
    String? description,
  }) => caller.callServerEndpoint<_i14.Organization>(
    'organization',
    'create',
    {
      'name': name,
      'slug': slug,
      'description': description,
    },
  );

  /// Returns a single organization by id.
  ///
  /// Organizations are public (an org homepage is a public page), so no
  /// membership check is required to read one.
  _i3.Future<_i14.Organization?> getById(_i2.UuidValue organizationId) =>
      caller.callServerEndpoint<_i14.Organization?>(
        'organization',
        'getById',
        {'organizationId': organizationId},
      );

  /// Returns a single organization by its public URL slug.
  _i3.Future<_i14.Organization?> getBySlug(String slug) =>
      caller.callServerEndpoint<_i14.Organization?>(
        'organization',
        'getBySlug',
        {'slug': slug},
      );

  /// Returns the organizations the calling user is a member of, paired with
  /// their role in each. Backs the Organizer Dashboard.
  _i3.Future<List<_i15.OrganizationMembership>> listMine() =>
      caller.callServerEndpoint<List<_i15.OrganizationMembership>>(
        'organization',
        'listMine',
        {},
      );
}

/// The BGS-owned half of profile data that doesn't live on the auth
/// module's `UserProfile` (see [PlayerProfile]'s doc comment). Always
/// self-scoped to the calling user, same as [ProfileEndpoint].
/// {@category Endpoint}
class EndpointPlayerProfile extends _i2.EndpointRef {
  EndpointPlayerProfile(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'playerProfile';

  /// Returns the caller's own [PlayerProfile], or `null` if they haven't
  /// set a bio yet -- the row is created lazily on first [updateBio].
  _i3.Future<_i16.PlayerProfile?> getMine() =>
      caller.callServerEndpoint<_i16.PlayerProfile?>(
        'playerProfile',
        'getMine',
        {},
      );

  /// Creates or updates the caller's own bio.
  _i3.Future<_i16.PlayerProfile> updateBio(String bio) =>
      caller.callServerEndpoint<_i16.PlayerProfile>(
        'playerProfile',
        'updateBio',
        {'bio': bio},
      );

  /// Wins/losses/ties summed across every [Standing] row for a team the
  /// caller has actively been a member of -- one row per team, since a
  /// team belongs to exactly one league. No player-level stats exist
  /// (goals/assists/etc, see BUILD_PLAN.md Phase C); this is purely a
  /// roll-up of team-level results the caller was part of.
  _i3.Future<_i17.PlayerStats> stats() =>
      caller.callServerEndpoint<_i17.PlayerStats>(
        'playerProfile',
        'stats',
        {},
      );
}

/// By extending [UserProfileEditBaseEndpoint], the profile read/edit
/// endpoints (`get`, `changeUserName`, `changeFullName`, `setUserImage`,
/// `removeUserImage`) are made available on the server -- same pattern as
/// `EmailIdpEndpoint` extending `EmailIdpBaseEndpoint`. Always self-scoped
/// to the calling user; there's no "view another user's profile" surface
/// yet (later enhancement, once e.g. team rosters need to show names).
///
/// `setUserImage`/`removeUserImage` work but aren't exercised by BGS's own
/// tests yet -- no file storage backend is configured for local dev, so
/// they'd fail at runtime here until that's set up.
/// {@category Endpoint}
class EndpointProfile extends _i4.EndpointUserProfileEditBase {
  EndpointProfile(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'profile';

  /// Removes the user's uploaded image, setting it to null.
  ///
  /// The client should handle displaying a placeholder for users without images.
  @override
  _i3.Future<_i4.UserProfileModel> removeUserImage() =>
      caller.callServerEndpoint<_i4.UserProfileModel>(
        'profile',
        'removeUserImage',
        {},
      );

  /// Sets a new user image for the signed in user.
  @override
  _i3.Future<_i4.UserProfileModel> setUserImage(_i18.ByteData image) =>
      caller.callServerEndpoint<_i4.UserProfileModel>(
        'profile',
        'setUserImage',
        {'image': image},
      );

  /// Changes the name of a user.
  @override
  _i3.Future<_i4.UserProfileModel> changeUserName(String? userName) =>
      caller.callServerEndpoint<_i4.UserProfileModel>(
        'profile',
        'changeUserName',
        {'userName': userName},
      );

  /// Changes the full name of a user.
  @override
  _i3.Future<_i4.UserProfileModel> changeFullName(String? fullName) =>
      caller.callServerEndpoint<_i4.UserProfileModel>(
        'profile',
        'changeFullName',
        {'fullName': fullName},
      );

  /// Returns the user profile of the current user.
  @override
  _i3.Future<_i4.UserProfileModel> get() =>
      caller.callServerEndpoint<_i4.UserProfileModel>(
        'profile',
        'get',
        {},
      );
}

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
/// {@category Endpoint}
class EndpointPublic extends _i2.EndpointRef {
  EndpointPublic(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'public';

  /// Returns an organization by its public URL slug.
  _i3.Future<_i14.Organization?> organizationBySlug(String slug) =>
      caller.callServerEndpoint<_i14.Organization?>(
        'public',
        'organizationBySlug',
        {'slug': slug},
      );

  /// Returns an organization's `active` and `completed` leagues, newest
  /// first -- everything a visitor should be able to see, letting the
  /// caller bucket into Active/Upcoming (by `seasonStartAt`) and Past (by
  /// `status == completed`) client-side. Draft/cancelled leagues aren't
  /// announced yet, so they stay excluded even though an organizer sees
  /// them on their own dashboard.
  _i3.Future<List<_i13.League>> leaguesByOrganization(
    _i2.UuidValue organizationId,
  ) => caller.callServerEndpoint<List<_i13.League>>(
    'public',
    'leaguesByOrganization',
    {'organizationId': organizationId},
  );

  /// Returns an organization's *published* events, newest first. Same
  /// rationale as [activeLeaguesByOrganization] -- drafts aren't public yet.
  _i3.Future<List<_i8.Event>> publishedEventsByOrganization(
    _i2.UuidValue organizationId,
  ) => caller.callServerEndpoint<List<_i8.Event>>(
    'public',
    'publishedEventsByOrganization',
    {'organizationId': organizationId},
  );

  /// Returns a single *active* league by its org slug + league slug (league
  /// slugs are only unique within an organization, not globally, so both
  /// are needed). Returns null if the org doesn't exist, the league doesn't
  /// exist, or the league isn't active yet -- a draft league has no public
  /// page.
  _i3.Future<_i13.League?> leagueBySlug({
    required String organizationSlug,
    required String leagueSlug,
  }) => caller.callServerEndpoint<_i13.League?>(
    'public',
    'leagueBySlug',
    {
      'organizationSlug': organizationSlug,
      'leagueSlug': leagueSlug,
    },
  );

  /// Returns all teams for a league. Same read [TeamEndpoint.listByLeague]
  /// already exposes to logged-in callers -- team rosters are public by
  /// design, this just makes that reachable anonymously too.
  _i3.Future<List<_i19.Team>> teamsByLeague(_i2.UuidValue leagueId) =>
      caller.callServerEndpoint<List<_i19.Team>>(
        'public',
        'teamsByLeague',
        {'leagueId': leagueId},
      );

  /// Returns a league's standings, best record first.
  _i3.Future<List<_i20.Standing>> standingsByLeague(_i2.UuidValue leagueId) =>
      caller.callServerEndpoint<List<_i20.Standing>>(
        'public',
        'standingsByLeague',
        {'leagueId': leagueId},
      );

  /// Returns all matches for a league, soonest first.
  _i3.Future<List<_i21.ScheduledMatch>> matchesByLeague(
    _i2.UuidValue leagueId,
  ) => caller.callServerEndpoint<List<_i21.ScheduledMatch>>(
    'public',
    'matchesByLeague',
    {'leagueId': leagueId},
  );

  /// Returns a single *published* event by its globally-unique slug -- what
  /// backs the shareable event link, e.g. `/e/<slug>`. Returns null if the
  /// event doesn't exist or isn't published yet.
  _i3.Future<_i8.Event?> eventBySlug(String slug) =>
      caller.callServerEndpoint<_i8.Event?>(
        'public',
        'eventBySlug',
        {'slug': slug},
      );

  /// Returns a *published* event's active registrations, newest first --
  /// backs the public event page's "who's signed up" section. Only
  /// `registeredByAuthUserId` and `teamName` are meaningful to show
  /// publicly; the UI should prefer `teamName` and fall back to something
  /// generic rather than exposing raw user identity. Returns an empty list
  /// (not an error) if the event doesn't exist or isn't published.
  _i3.Future<List<_i11.EventRegistration>> registrationsByEvent(
    _i2.UuidValue eventId,
  ) => caller.callServerEndpoint<List<_i11.EventRegistration>>(
    'public',
    'registrationsByEvent',
    {'eventId': eventId},
  );

  /// Same search as [SearchEndpoint.search], reachable anonymously. See
  /// [performSearch] for the shared query/discoverability logic.
  _i3.Future<_i22.SearchResults> search({
    String? query,
    _i9.Sport? sport,
    String? location,
  }) => caller.callServerEndpoint<_i22.SearchResults>(
    'public',
    'search',
    {
      'query': query,
      'sport': sport,
      'location': location,
    },
  );
}

/// Lightweight v1 attendance tracking -- a manager (org admin or the
/// team's active `manager`) marks each roster member present/absent for a
/// match after the fact. Not a player-facing RSVP; see BUILD_PLAN.md for
/// that deferred feature. Attendance is team-internal, not public data --
/// every method here requires manage access on the specific team.
/// {@category Endpoint}
class EndpointAttendance extends _i2.EndpointRef {
  EndpointAttendance(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'attendance';

  /// Records (or updates) one roster member's attendance for a match.
  /// [teamMembershipId] must belong to a team that's actually playing in
  /// [matchId] (home or away); the caller must have manage access on that
  /// team.
  _i3.Future<_i23.MatchAttendance> record({
    required _i2.UuidValue matchId,
    required _i2.UuidValue teamMembershipId,
    required _i24.AttendanceStatus status,
  }) => caller.callServerEndpoint<_i23.MatchAttendance>(
    'attendance',
    'record',
    {
      'matchId': matchId,
      'teamMembershipId': teamMembershipId,
      'status': status,
    },
  );

  /// Returns every attendance record for [teamId]'s roster at [matchId].
  /// Requires manage access on [teamId] -- attendance is team-internal.
  _i3.Future<List<_i23.MatchAttendance>> listForMatch({
    required _i2.UuidValue matchId,
    required _i2.UuidValue teamId,
  }) => caller.callServerEndpoint<List<_i23.MatchAttendance>>(
    'attendance',
    'listForMatch',
    {
      'matchId': matchId,
      'teamId': teamId,
    },
  );
}

/// A single scheduled game between two teams within a [League]. Manual
/// scheduling only for Phase 1 -- no auto-scheduling algorithm yet. See
/// BUILD_PLAN.md for the domain model.
///
/// [recordResult] is the only place [Standing] rows get written -- they're
/// a recomputed aggregate, not a separate source of truth. See
/// StandingEndpoint for the (read-only) public surface.
/// {@category Endpoint}
class EndpointScheduledMatch extends _i2.EndpointRef {
  EndpointScheduledMatch(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'scheduledMatch';

  /// Schedules a match between two teams within a league. Requires at
  /// least `admin` on the league's organization. Both teams must already
  /// belong to the league.
  _i3.Future<_i21.ScheduledMatch> create({
    required _i2.UuidValue leagueId,
    required _i2.UuidValue homeTeamId,
    required _i2.UuidValue awayTeamId,
    required DateTime scheduledAt,
    String? location,
  }) => caller.callServerEndpoint<_i21.ScheduledMatch>(
    'scheduledMatch',
    'create',
    {
      'leagueId': leagueId,
      'homeTeamId': homeTeamId,
      'awayTeamId': awayTeamId,
      'scheduledAt': scheduledAt,
      'location': location,
    },
  );

  /// Returns a single match by id. Public -- schedules are public.
  _i3.Future<_i21.ScheduledMatch?> getById(_i2.UuidValue matchId) =>
      caller.callServerEndpoint<_i21.ScheduledMatch?>(
        'scheduledMatch',
        'getById',
        {'matchId': matchId},
      );

  /// Returns all matches for a league, soonest first. Public -- backs the
  /// league schedule page.
  _i3.Future<List<_i21.ScheduledMatch>> listByLeague(_i2.UuidValue leagueId) =>
      caller.callServerEndpoint<List<_i21.ScheduledMatch>>(
        'scheduledMatch',
        'listByLeague',
        {'leagueId': leagueId},
      );

  /// Reschedules a match (time and/or location). Requires at least `admin`
  /// on the league's organization.
  _i3.Future<_i21.ScheduledMatch> update(
    _i2.UuidValue matchId, {
    DateTime? scheduledAt,
    String? location,
  }) => caller.callServerEndpoint<_i21.ScheduledMatch>(
    'scheduledMatch',
    'update',
    {
      'matchId': matchId,
      'scheduledAt': scheduledAt,
      'location': location,
    },
  );

  /// Cancels a scheduled match. Requires at least `admin` on the league's
  /// organization. Only allowed while the match is still `scheduled`.
  _i3.Future<_i21.ScheduledMatch> cancel(_i2.UuidValue matchId) =>
      caller.callServerEndpoint<_i21.ScheduledMatch>(
        'scheduledMatch',
        'cancel',
        {'matchId': matchId},
      );

  /// Records a final score, marking the match `completed` and updating
  /// both teams' [Standing] rows for the league. Requires at least `admin`
  /// on the league's organization, OR an active `manager` membership on
  /// either the home or away team -- this is what makes the Manager
  /// Dashboard's "Record score" action usable by an actual team manager,
  /// not just an org admin. Only allowed while the match is still
  /// `scheduled` -- results aren't editable in Phase 1.
  _i3.Future<_i21.ScheduledMatch> recordResult({
    required _i2.UuidValue matchId,
    required int homeScore,
    required int awayScore,
  }) => caller.callServerEndpoint<_i21.ScheduledMatch>(
    'scheduledMatch',
    'recordResult',
    {
      'matchId': matchId,
      'homeScore': homeScore,
      'awayScore': awayScore,
    },
  );
}

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
/// {@category Endpoint}
class EndpointSearch extends _i2.EndpointRef {
  EndpointSearch(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'search';

  _i3.Future<_i22.SearchResults> search({
    String? query,
    _i9.Sport? sport,
    String? location,
  }) => caller.callServerEndpoint<_i22.SearchResults>(
    'search',
    'search',
    {
      'query': query,
      'sport': sport,
      'location': location,
    },
  );
}

/// Read-only: [Standing] rows are a recomputed aggregate maintained by
/// [ScheduledMatchEndpoint.recordResult], not a separate source of truth,
/// so there's no create/update surface here.
/// {@category Endpoint}
class EndpointStanding extends _i2.EndpointRef {
  EndpointStanding(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'standing';

  /// Returns a league's standings, best record first. Public -- backs the
  /// league standings page.
  ///
  /// Sorted by wins only for Phase 1; a smarter sort (win percentage,
  /// point differential as a tiebreaker) is a later enhancement once
  /// leagues have played enough games for it to matter.
  _i3.Future<List<_i20.Standing>> listByLeague(_i2.UuidValue leagueId) =>
      caller.callServerEndpoint<List<_i20.Standing>>(
        'standing',
        'listByLeague',
        {'leagueId': leagueId},
      );
}

/// Teams compete within a single [League]. See BUILD_PLAN.md for the domain
/// model.
///
/// Two authorization patterns live side by side here: [create] and
/// [invitePlayer] use [requireOrgRole] (same pattern as League), while
/// [acceptInvite]/[declineInvite] use a simpler check -- is the calling user
/// the [AuthUser] on the membership row being acted on. That second pattern
/// is new to the app: it's the first player-side write, and there's no org
/// role to check because the player usually isn't an org member at all.
/// {@category Endpoint}
class EndpointTeam extends _i2.EndpointRef {
  EndpointTeam(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'team';

  /// Creates a new team within a league. Requires at least `admin` on the
  /// league's organization.
  _i3.Future<_i19.Team> create({
    required _i2.UuidValue leagueId,
    required String name,
  }) => caller.callServerEndpoint<_i19.Team>(
    'team',
    'create',
    {
      'leagueId': leagueId,
      'name': name,
    },
  );

  /// Returns a single team by id. Public -- team pages are public.
  _i3.Future<_i19.Team?> getById(_i2.UuidValue teamId) =>
      caller.callServerEndpoint<_i19.Team?>(
        'team',
        'getById',
        {'teamId': teamId},
      );

  /// Returns all teams for a league. Public.
  _i3.Future<List<_i19.Team>> listByLeague(_i2.UuidValue leagueId) =>
      caller.callServerEndpoint<List<_i19.Team>>(
        'team',
        'listByLeague',
        {'leagueId': leagueId},
      );

  /// Returns a team's roster (all memberships, any status). Public -- team
  /// rosters are public, same as team/league pages.
  _i3.Future<List<_i25.TeamMembership>> listMembers(_i2.UuidValue teamId) =>
      caller.callServerEndpoint<List<_i25.TeamMembership>>(
        'team',
        'listMembers',
        {'teamId': teamId},
      );

  /// Invites an existing BGS user (by their verified email) to join a team,
  /// as a `player` by default or as a `manager` if [role] is given. Requires
  /// at least `admin` on the team's league's organization.
  ///
  /// The invited player must already have a BGS account -- inviting someone
  /// who hasn't signed up yet is a later enhancement.
  _i3.Future<_i25.TeamMembership> invitePlayer({
    required _i2.UuidValue teamId,
    required String email,
    _i26.TeamMemberRole? role,
  }) => caller.callServerEndpoint<_i25.TeamMembership>(
    'team',
    'invitePlayer',
    {
      'teamId': teamId,
      'email': email,
      'role': role,
    },
  );

  /// Accepts a pending invite. Callable only by the invited player
  /// themselves -- see the class doc for why this isn't an org-role check.
  _i3.Future<_i25.TeamMembership> acceptInvite(_i2.UuidValue membershipId) =>
      caller.callServerEndpoint<_i25.TeamMembership>(
        'team',
        'acceptInvite',
        {'membershipId': membershipId},
      );

  /// Declines a pending invite. Callable only by the invited player
  /// themselves.
  _i3.Future<_i25.TeamMembership> declineInvite(_i2.UuidValue membershipId) =>
      caller.callServerEndpoint<_i25.TeamMembership>(
        'team',
        'declineInvite',
        {'membershipId': membershipId},
      );

  /// Returns the calling user's own team memberships, across all teams.
  /// Backs the Player Dashboard ("my teams").
  _i3.Future<List<_i25.TeamMembership>> listMine() =>
      caller.callServerEndpoint<List<_i25.TeamMembership>>(
        'team',
        'listMine',
        {},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i4.Caller(client);
    serverpod_auth_idp = _i1.Caller(client);
  }

  late final _i4.Caller auth;

  late final _i1.Caller serverpod_auth_idp;
}

class Client extends _i2.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i2.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i2.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i27.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    dashboard = EndpointDashboard(this);
    event = EndpointEvent(this);
    greeting = EndpointGreeting(this);
    league = EndpointLeague(this);
    organization = EndpointOrganization(this);
    playerProfile = EndpointPlayerProfile(this);
    profile = EndpointProfile(this);
    public = EndpointPublic(this);
    attendance = EndpointAttendance(this);
    scheduledMatch = EndpointScheduledMatch(this);
    search = EndpointSearch(this);
    standing = EndpointStanding(this);
    team = EndpointTeam(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointDashboard dashboard;

  late final EndpointEvent event;

  late final EndpointGreeting greeting;

  late final EndpointLeague league;

  late final EndpointOrganization organization;

  late final EndpointPlayerProfile playerProfile;

  late final EndpointProfile profile;

  late final EndpointPublic public;

  late final EndpointAttendance attendance;

  late final EndpointScheduledMatch scheduledMatch;

  late final EndpointSearch search;

  late final EndpointStanding standing;

  late final EndpointTeam team;

  late final Modules modules;

  @override
  Map<String, _i2.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'dashboard': dashboard,
    'event': event,
    'greeting': greeting,
    'league': league,
    'organization': organization,
    'playerProfile': playerProfile,
    'profile': profile,
    'public': public,
    'attendance': attendance,
    'scheduledMatch': scheduledMatch,
    'search': search,
    'standing': standing,
    'team': team,
  };

  @override
  Map<String, _i2.ModuleEndpointCaller> get moduleLookup => {
    'auth': modules.auth,
    'serverpod_auth_idp': modules.serverpod_auth_idp,
  };
}
