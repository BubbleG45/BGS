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
import 'package:bgs_client/src/protocol/events/models/event.dart' as _i5;
import 'package:bgs_client/src/protocol/sports/models/sport.dart' as _i6;
import 'package:bgs_client/src/protocol/sports/models/skill_level.dart' as _i7;
import 'package:bgs_client/src/protocol/events/models/event_registration.dart'
    as _i8;
import 'package:bgs_client/src/protocol/greetings/greeting.dart' as _i9;
import 'package:bgs_client/src/protocol/leagues/models/league.dart' as _i10;
import 'package:bgs_client/src/protocol/organizations/models/organization.dart'
    as _i11;
import 'package:bgs_client/src/protocol/organizations/models/organization_membership.dart'
    as _i12;
import 'package:bgs_client/src/protocol/teams/models/team.dart' as _i13;
import 'package:bgs_client/src/protocol/teams/models/team_membership.dart'
    as _i14;
import 'protocol.dart' as _i15;

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
  _i3.Future<_i5.Event> create({
    _i2.UuidValue? organizationId,
    required String name,
    required String slug,
    required _i6.Sport sport,
    required DateTime startAt,
    required int teamFeeCents,
    _i7.SkillLevel? skillLevel,
    String? description,
    String? location,
    bool? isTournament,
  }) => caller.callServerEndpoint<_i5.Event>(
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
    },
  );

  /// Returns a single event by id. Public -- event pages are public.
  _i3.Future<_i5.Event?> getById(_i2.UuidValue eventId) =>
      caller.callServerEndpoint<_i5.Event?>(
        'event',
        'getById',
        {'eventId': eventId},
      );

  /// Returns a single event by its globally-unique slug. Public -- this is
  /// what backs the shareable event link, e.g. `/e/<slug>`.
  _i3.Future<_i5.Event?> getBySlug(String slug) =>
      caller.callServerEndpoint<_i5.Event?>(
        'event',
        'getBySlug',
        {'slug': slug},
      );

  /// Returns all events for an organization, newest first. Public -- backs
  /// the org homepage's "show events" list. Orgless events aren't returned
  /// here since they have no organization to list them under.
  _i3.Future<List<_i5.Event>> listByOrganization(
    _i2.UuidValue organizationId,
  ) => caller.callServerEndpoint<List<_i5.Event>>(
    'event',
    'listByOrganization',
    {'organizationId': organizationId},
  );

  /// Updates an event's basic details. Requires manage permission -- see
  /// [_requireManagePermission].
  _i3.Future<_i5.Event> update(
    _i2.UuidValue eventId, {
    String? name,
    String? description,
    String? location,
    _i7.SkillLevel? skillLevel,
    DateTime? startAt,
    int? teamFeeCents,
  }) => caller.callServerEndpoint<_i5.Event>(
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
    },
  );

  /// Publishes a draft event, making it publicly visible for registration.
  /// Requires manage permission -- see [_requireManagePermission].
  _i3.Future<_i5.Event> publish(_i2.UuidValue eventId) =>
      caller.callServerEndpoint<_i5.Event>(
        'event',
        'publish',
        {'eventId': eventId},
      );

  /// Registers the calling user for a published event.
  _i3.Future<_i8.EventRegistration> register({
    required _i2.UuidValue eventId,
    String? teamName,
  }) => caller.callServerEndpoint<_i8.EventRegistration>(
    'event',
    'register',
    {
      'eventId': eventId,
      'teamName': teamName,
    },
  );

  /// Cancels a registration. Callable only by the registrant themselves.
  _i3.Future<_i8.EventRegistration> cancelRegistration(
    _i2.UuidValue registrationId,
  ) => caller.callServerEndpoint<_i8.EventRegistration>(
    'event',
    'cancelRegistration',
    {'registrationId': registrationId},
  );

  /// Returns the calling user's own event registrations. Backs the Player
  /// Dashboard ("my events").
  _i3.Future<List<_i8.EventRegistration>> listMyRegistrations() =>
      caller.callServerEndpoint<List<_i8.EventRegistration>>(
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
  _i3.Future<_i9.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i9.Greeting>(
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
  _i3.Future<_i10.League> create({
    required _i2.UuidValue organizationId,
    required String name,
    required String slug,
    required _i6.Sport sport,
    required int teamFeeCents,
    _i7.SkillLevel? skillLevel,
    String? description,
    String? location,
  }) => caller.callServerEndpoint<_i10.League>(
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
    },
  );

  /// Returns a single league by id. Public -- league pages are public.
  _i3.Future<_i10.League?> getById(_i2.UuidValue leagueId) =>
      caller.callServerEndpoint<_i10.League?>(
        'league',
        'getById',
        {'leagueId': leagueId},
      );

  /// Returns a single league by its org-scoped slug. Public.
  _i3.Future<_i10.League?> getByOrgAndSlug({
    required _i2.UuidValue organizationId,
    required String slug,
  }) => caller.callServerEndpoint<_i10.League?>(
    'league',
    'getByOrgAndSlug',
    {
      'organizationId': organizationId,
      'slug': slug,
    },
  );

  /// Returns all leagues for an organization, newest first. Public -- backs
  /// the org homepage's "show leagues" list.
  _i3.Future<List<_i10.League>> listByOrganization(
    _i2.UuidValue organizationId,
  ) => caller.callServerEndpoint<List<_i10.League>>(
    'league',
    'listByOrganization',
    {'organizationId': organizationId},
  );

  /// Updates a league's basic details. Requires at least `admin` on the
  /// league's organization.
  _i3.Future<_i10.League> update(
    _i2.UuidValue leagueId, {
    String? name,
    String? description,
    String? location,
    _i7.SkillLevel? skillLevel,
    int? teamFeeCents,
  }) => caller.callServerEndpoint<_i10.League>(
    'league',
    'update',
    {
      'leagueId': leagueId,
      'name': name,
      'description': description,
      'location': location,
      'skillLevel': skillLevel,
      'teamFeeCents': teamFeeCents,
    },
  );

  /// Activates a draft league, making it publicly visible for registration.
  /// Requires at least `admin` on the league's organization.
  _i3.Future<_i10.League> activate(_i2.UuidValue leagueId) =>
      caller.callServerEndpoint<_i10.League>(
        'league',
        'activate',
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
  _i3.Future<_i11.Organization> create({
    required String name,
    required String slug,
    String? description,
  }) => caller.callServerEndpoint<_i11.Organization>(
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
  _i3.Future<_i11.Organization?> getById(_i2.UuidValue organizationId) =>
      caller.callServerEndpoint<_i11.Organization?>(
        'organization',
        'getById',
        {'organizationId': organizationId},
      );

  /// Returns a single organization by its public URL slug.
  _i3.Future<_i11.Organization?> getBySlug(String slug) =>
      caller.callServerEndpoint<_i11.Organization?>(
        'organization',
        'getBySlug',
        {'slug': slug},
      );

  /// Returns the organizations the calling user is a member of, paired with
  /// their role in each. Backs the Organizer Dashboard.
  _i3.Future<List<_i12.OrganizationMembership>> listMine() =>
      caller.callServerEndpoint<List<_i12.OrganizationMembership>>(
        'organization',
        'listMine',
        {},
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
  _i3.Future<_i13.Team> create({
    required _i2.UuidValue leagueId,
    required String name,
  }) => caller.callServerEndpoint<_i13.Team>(
    'team',
    'create',
    {
      'leagueId': leagueId,
      'name': name,
    },
  );

  /// Returns a single team by id. Public -- team pages are public.
  _i3.Future<_i13.Team?> getById(_i2.UuidValue teamId) =>
      caller.callServerEndpoint<_i13.Team?>(
        'team',
        'getById',
        {'teamId': teamId},
      );

  /// Returns all teams for a league. Public.
  _i3.Future<List<_i13.Team>> listByLeague(_i2.UuidValue leagueId) =>
      caller.callServerEndpoint<List<_i13.Team>>(
        'team',
        'listByLeague',
        {'leagueId': leagueId},
      );

  /// Invites an existing BGS user (by their verified email) to join a team.
  /// Requires at least `admin` on the team's league's organization.
  ///
  /// The invited player must already have a BGS account -- inviting someone
  /// who hasn't signed up yet is a later enhancement.
  _i3.Future<_i14.TeamMembership> invitePlayer({
    required _i2.UuidValue teamId,
    required String email,
  }) => caller.callServerEndpoint<_i14.TeamMembership>(
    'team',
    'invitePlayer',
    {
      'teamId': teamId,
      'email': email,
    },
  );

  /// Accepts a pending invite. Callable only by the invited player
  /// themselves -- see the class doc for why this isn't an org-role check.
  _i3.Future<_i14.TeamMembership> acceptInvite(_i2.UuidValue membershipId) =>
      caller.callServerEndpoint<_i14.TeamMembership>(
        'team',
        'acceptInvite',
        {'membershipId': membershipId},
      );

  /// Declines a pending invite. Callable only by the invited player
  /// themselves.
  _i3.Future<_i14.TeamMembership> declineInvite(_i2.UuidValue membershipId) =>
      caller.callServerEndpoint<_i14.TeamMembership>(
        'team',
        'declineInvite',
        {'membershipId': membershipId},
      );

  /// Returns the calling user's own team memberships, across all teams.
  /// Backs the Player Dashboard ("my teams").
  _i3.Future<List<_i14.TeamMembership>> listMine() =>
      caller.callServerEndpoint<List<_i14.TeamMembership>>(
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
         _i15.Protocol(),
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
    event = EndpointEvent(this);
    greeting = EndpointGreeting(this);
    league = EndpointLeague(this);
    organization = EndpointOrganization(this);
    team = EndpointTeam(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointEvent event;

  late final EndpointGreeting greeting;

  late final EndpointLeague league;

  late final EndpointOrganization organization;

  late final EndpointTeam team;

  late final Modules modules;

  @override
  Map<String, _i2.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'event': event,
    'greeting': greeting,
    'league': league,
    'organization': organization,
    'team': team,
  };

  @override
  Map<String, _i2.ModuleEndpointCaller> get moduleLookup => {
    'auth': modules.auth,
    'serverpod_auth_idp': modules.serverpod_auth_idp,
  };
}
