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
import 'package:serverpod/serverpod.dart' as _i1;
import '../auth/email_idp_endpoint.dart' as _i2;
import '../auth/jwt_refresh_endpoint.dart' as _i3;
import '../dashboards/dashboard_endpoint.dart' as _i4;
import '../events/event_endpoint.dart' as _i5;
import '../greetings/greeting_endpoint.dart' as _i6;
import '../leagues/league_endpoint.dart' as _i7;
import '../organizations/organization_endpoint.dart' as _i8;
import '../profiles/player_profile_endpoint.dart' as _i9;
import '../profiles/profile_endpoint.dart' as _i10;
import '../public/public_endpoint.dart' as _i11;
import '../scheduling/attendance_endpoint.dart' as _i12;
import '../scheduling/scheduled_match_endpoint.dart' as _i13;
import '../search/search_endpoint.dart' as _i14;
import '../standings/standing_endpoint.dart' as _i15;
import '../teams/team_endpoint.dart' as _i16;
import 'package:bgs_server/src/generated/sports/models/sport.dart' as _i17;
import 'package:bgs_server/src/generated/sports/models/skill_level.dart'
    as _i18;
import 'dart:typed_data' as _i19;
import 'package:bgs_server/src/generated/scheduling/models/attendance_status.dart'
    as _i20;
import 'package:bgs_server/src/generated/teams/models/team_member_role.dart'
    as _i21;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i22;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i23;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'emailIdp': _i2.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i3.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'dashboard': _i4.DashboardEndpoint()
        ..initialize(
          server,
          'dashboard',
          null,
        ),
      'event': _i5.EventEndpoint()
        ..initialize(
          server,
          'event',
          null,
        ),
      'greeting': _i6.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'league': _i7.LeagueEndpoint()
        ..initialize(
          server,
          'league',
          null,
        ),
      'organization': _i8.OrganizationEndpoint()
        ..initialize(
          server,
          'organization',
          null,
        ),
      'playerProfile': _i9.PlayerProfileEndpoint()
        ..initialize(
          server,
          'playerProfile',
          null,
        ),
      'profile': _i10.ProfileEndpoint()
        ..initialize(
          server,
          'profile',
          null,
        ),
      'public': _i11.PublicEndpoint()
        ..initialize(
          server,
          'public',
          null,
        ),
      'attendance': _i12.AttendanceEndpoint()
        ..initialize(
          server,
          'attendance',
          null,
        ),
      'scheduledMatch': _i13.ScheduledMatchEndpoint()
        ..initialize(
          server,
          'scheduledMatch',
          null,
        ),
      'search': _i14.SearchEndpoint()
        ..initialize(
          server,
          'search',
          null,
        ),
      'standing': _i15.StandingEndpoint()
        ..initialize(
          server,
          'standing',
          null,
        ),
      'team': _i16.TeamEndpoint()
        ..initialize(
          server,
          'team',
          null,
        ),
    };
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _i1.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i3.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['dashboard'] = _i1.EndpointConnector(
      name: 'dashboard',
      endpoint: endpoints['dashboard']!,
      methodConnectors: {
        'player': _i1.MethodConnector(
          name: 'player',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i4.DashboardEndpoint)
                  .player(session),
        ),
        'organizer': _i1.MethodConnector(
          name: 'organizer',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i4.DashboardEndpoint)
                  .organizer(session),
        ),
        'manager': _i1.MethodConnector(
          name: 'manager',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _i4.DashboardEndpoint)
                  .manager(session),
        ),
      },
    );
    connectors['event'] = _i1.EndpointConnector(
      name: 'event',
      endpoint: endpoints['event']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<_i1.UuidValue?>(),
              nullable: true,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'slug': _i1.ParameterDescription(
              name: 'slug',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'sport': _i1.ParameterDescription(
              name: 'sport',
              type: _i1.getType<_i17.Sport>(),
              nullable: false,
            ),
            'startAt': _i1.ParameterDescription(
              name: 'startAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'teamFeeCents': _i1.ParameterDescription(
              name: 'teamFeeCents',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'skillLevel': _i1.ParameterDescription(
              name: 'skillLevel',
              type: _i1.getType<_i18.SkillLevel?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'isTournament': _i1.ParameterDescription(
              name: 'isTournament',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'registrationOpensAt': _i1.ParameterDescription(
              name: 'registrationOpensAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'registrationClosesAt': _i1.ParameterDescription(
              name: 'registrationClosesAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'rulesUrl': _i1.ParameterDescription(
              name: 'rulesUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _i5.EventEndpoint).create(
                session,
                organizationId: params['organizationId'],
                name: params['name'],
                slug: params['slug'],
                sport: params['sport'],
                startAt: params['startAt'],
                teamFeeCents: params['teamFeeCents'],
                skillLevel: params['skillLevel'],
                description: params['description'],
                location: params['location'],
                isTournament: params['isTournament'],
                registrationOpensAt: params['registrationOpensAt'],
                registrationClosesAt: params['registrationClosesAt'],
                rulesUrl: params['rulesUrl'],
              ),
        ),
        'getById': _i1.MethodConnector(
          name: 'getById',
          params: {
            'eventId': _i1.ParameterDescription(
              name: 'eventId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _i5.EventEndpoint).getById(
                session,
                params['eventId'],
              ),
        ),
        'getBySlug': _i1.MethodConnector(
          name: 'getBySlug',
          params: {
            'slug': _i1.ParameterDescription(
              name: 'slug',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _i5.EventEndpoint).getBySlug(
                session,
                params['slug'],
              ),
        ),
        'listByOrganization': _i1.MethodConnector(
          name: 'listByOrganization',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['event'] as _i5.EventEndpoint).listByOrganization(
                    session,
                    params['organizationId'],
                  ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'eventId': _i1.ParameterDescription(
              name: 'eventId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'skillLevel': _i1.ParameterDescription(
              name: 'skillLevel',
              type: _i1.getType<_i18.SkillLevel?>(),
              nullable: true,
            ),
            'startAt': _i1.ParameterDescription(
              name: 'startAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'teamFeeCents': _i1.ParameterDescription(
              name: 'teamFeeCents',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'registrationOpensAt': _i1.ParameterDescription(
              name: 'registrationOpensAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'registrationClosesAt': _i1.ParameterDescription(
              name: 'registrationClosesAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'rulesUrl': _i1.ParameterDescription(
              name: 'rulesUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _i5.EventEndpoint).update(
                session,
                params['eventId'],
                name: params['name'],
                description: params['description'],
                location: params['location'],
                skillLevel: params['skillLevel'],
                startAt: params['startAt'],
                teamFeeCents: params['teamFeeCents'],
                registrationOpensAt: params['registrationOpensAt'],
                registrationClosesAt: params['registrationClosesAt'],
                rulesUrl: params['rulesUrl'],
              ),
        ),
        'publish': _i1.MethodConnector(
          name: 'publish',
          params: {
            'eventId': _i1.ParameterDescription(
              name: 'eventId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _i5.EventEndpoint).publish(
                session,
                params['eventId'],
              ),
        ),
        'register': _i1.MethodConnector(
          name: 'register',
          params: {
            'eventId': _i1.ParameterDescription(
              name: 'eventId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'teamName': _i1.ParameterDescription(
              name: 'teamName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _i5.EventEndpoint).register(
                session,
                eventId: params['eventId'],
                teamName: params['teamName'],
              ),
        ),
        'cancelRegistration': _i1.MethodConnector(
          name: 'cancelRegistration',
          params: {
            'registrationId': _i1.ParameterDescription(
              name: 'registrationId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['event'] as _i5.EventEndpoint).cancelRegistration(
                    session,
                    params['registrationId'],
                  ),
        ),
        'listMyRegistrations': _i1.MethodConnector(
          name: 'listMyRegistrations',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _i5.EventEndpoint)
                  .listMyRegistrations(session),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['greeting'] as _i6.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    connectors['league'] = _i1.EndpointConnector(
      name: 'league',
      endpoint: endpoints['league']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'slug': _i1.ParameterDescription(
              name: 'slug',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'sport': _i1.ParameterDescription(
              name: 'sport',
              type: _i1.getType<_i17.Sport>(),
              nullable: false,
            ),
            'teamFeeCents': _i1.ParameterDescription(
              name: 'teamFeeCents',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'skillLevel': _i1.ParameterDescription(
              name: 'skillLevel',
              type: _i1.getType<_i18.SkillLevel?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'seasonStartAt': _i1.ParameterDescription(
              name: 'seasonStartAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'seasonEndAt': _i1.ParameterDescription(
              name: 'seasonEndAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'registrationOpensAt': _i1.ParameterDescription(
              name: 'registrationOpensAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'registrationClosesAt': _i1.ParameterDescription(
              name: 'registrationClosesAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'rulesUrl': _i1.ParameterDescription(
              name: 'rulesUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['league'] as _i7.LeagueEndpoint).create(
                session,
                organizationId: params['organizationId'],
                name: params['name'],
                slug: params['slug'],
                sport: params['sport'],
                teamFeeCents: params['teamFeeCents'],
                skillLevel: params['skillLevel'],
                description: params['description'],
                location: params['location'],
                seasonStartAt: params['seasonStartAt'],
                seasonEndAt: params['seasonEndAt'],
                registrationOpensAt: params['registrationOpensAt'],
                registrationClosesAt: params['registrationClosesAt'],
                rulesUrl: params['rulesUrl'],
              ),
        ),
        'getById': _i1.MethodConnector(
          name: 'getById',
          params: {
            'leagueId': _i1.ParameterDescription(
              name: 'leagueId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['league'] as _i7.LeagueEndpoint).getById(
                session,
                params['leagueId'],
              ),
        ),
        'getByOrgAndSlug': _i1.MethodConnector(
          name: 'getByOrgAndSlug',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'slug': _i1.ParameterDescription(
              name: 'slug',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['league'] as _i7.LeagueEndpoint).getByOrgAndSlug(
                    session,
                    organizationId: params['organizationId'],
                    slug: params['slug'],
                  ),
        ),
        'listByOrganization': _i1.MethodConnector(
          name: 'listByOrganization',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['league'] as _i7.LeagueEndpoint)
                  .listByOrganization(
                    session,
                    params['organizationId'],
                  ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'leagueId': _i1.ParameterDescription(
              name: 'leagueId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'skillLevel': _i1.ParameterDescription(
              name: 'skillLevel',
              type: _i1.getType<_i18.SkillLevel?>(),
              nullable: true,
            ),
            'teamFeeCents': _i1.ParameterDescription(
              name: 'teamFeeCents',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'seasonStartAt': _i1.ParameterDescription(
              name: 'seasonStartAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'seasonEndAt': _i1.ParameterDescription(
              name: 'seasonEndAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'registrationOpensAt': _i1.ParameterDescription(
              name: 'registrationOpensAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'registrationClosesAt': _i1.ParameterDescription(
              name: 'registrationClosesAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'rulesUrl': _i1.ParameterDescription(
              name: 'rulesUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['league'] as _i7.LeagueEndpoint).update(
                session,
                params['leagueId'],
                name: params['name'],
                description: params['description'],
                location: params['location'],
                skillLevel: params['skillLevel'],
                teamFeeCents: params['teamFeeCents'],
                seasonStartAt: params['seasonStartAt'],
                seasonEndAt: params['seasonEndAt'],
                registrationOpensAt: params['registrationOpensAt'],
                registrationClosesAt: params['registrationClosesAt'],
                rulesUrl: params['rulesUrl'],
              ),
        ),
        'activate': _i1.MethodConnector(
          name: 'activate',
          params: {
            'leagueId': _i1.ParameterDescription(
              name: 'leagueId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['league'] as _i7.LeagueEndpoint).activate(
                session,
                params['leagueId'],
              ),
        ),
        'complete': _i1.MethodConnector(
          name: 'complete',
          params: {
            'leagueId': _i1.ParameterDescription(
              name: 'leagueId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['league'] as _i7.LeagueEndpoint).complete(
                session,
                params['leagueId'],
              ),
        ),
      },
    );
    connectors['organization'] = _i1.EndpointConnector(
      name: 'organization',
      endpoint: endpoints['organization']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'slug': _i1.ParameterDescription(
              name: 'slug',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organization'] as _i8.OrganizationEndpoint)
                  .create(
                    session,
                    name: params['name'],
                    slug: params['slug'],
                    description: params['description'],
                  ),
        ),
        'getById': _i1.MethodConnector(
          name: 'getById',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organization'] as _i8.OrganizationEndpoint)
                  .getById(
                    session,
                    params['organizationId'],
                  ),
        ),
        'getBySlug': _i1.MethodConnector(
          name: 'getBySlug',
          params: {
            'slug': _i1.ParameterDescription(
              name: 'slug',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organization'] as _i8.OrganizationEndpoint)
                  .getBySlug(
                    session,
                    params['slug'],
                  ),
        ),
        'listMine': _i1.MethodConnector(
          name: 'listMine',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['organization'] as _i8.OrganizationEndpoint)
                  .listMine(session),
        ),
      },
    );
    connectors['playerProfile'] = _i1.EndpointConnector(
      name: 'playerProfile',
      endpoint: endpoints['playerProfile']!,
      methodConnectors: {
        'getMine': _i1.MethodConnector(
          name: 'getMine',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['playerProfile'] as _i9.PlayerProfileEndpoint)
                      .getMine(session),
        ),
        'updateBio': _i1.MethodConnector(
          name: 'updateBio',
          params: {
            'bio': _i1.ParameterDescription(
              name: 'bio',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['playerProfile'] as _i9.PlayerProfileEndpoint)
                      .updateBio(
                        session,
                        params['bio'],
                      ),
        ),
        'stats': _i1.MethodConnector(
          name: 'stats',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['playerProfile'] as _i9.PlayerProfileEndpoint)
                      .stats(session),
        ),
      },
    );
    connectors['profile'] = _i1.EndpointConnector(
      name: 'profile',
      endpoint: endpoints['profile']!,
      methodConnectors: {
        'removeUserImage': _i1.MethodConnector(
          name: 'removeUserImage',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i10.ProfileEndpoint)
                  .removeUserImage(session),
        ),
        'setUserImage': _i1.MethodConnector(
          name: 'setUserImage',
          params: {
            'image': _i1.ParameterDescription(
              name: 'image',
              type: _i1.getType<_i19.ByteData>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['profile'] as _i10.ProfileEndpoint).setUserImage(
                    session,
                    params['image'],
                  ),
        ),
        'changeUserName': _i1.MethodConnector(
          name: 'changeUserName',
          params: {
            'userName': _i1.ParameterDescription(
              name: 'userName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['profile'] as _i10.ProfileEndpoint).changeUserName(
                    session,
                    params['userName'],
                  ),
        ),
        'changeFullName': _i1.MethodConnector(
          name: 'changeFullName',
          params: {
            'fullName': _i1.ParameterDescription(
              name: 'fullName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['profile'] as _i10.ProfileEndpoint).changeFullName(
                    session,
                    params['fullName'],
                  ),
        ),
        'get': _i1.MethodConnector(
          name: 'get',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['profile'] as _i10.ProfileEndpoint).get(session),
        ),
      },
    );
    connectors['public'] = _i1.EndpointConnector(
      name: 'public',
      endpoint: endpoints['public']!,
      methodConnectors: {
        'organizationBySlug': _i1.MethodConnector(
          name: 'organizationBySlug',
          params: {
            'slug': _i1.ParameterDescription(
              name: 'slug',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['public'] as _i11.PublicEndpoint)
                  .organizationBySlug(
                    session,
                    params['slug'],
                  ),
        ),
        'leaguesByOrganization': _i1.MethodConnector(
          name: 'leaguesByOrganization',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['public'] as _i11.PublicEndpoint)
                  .leaguesByOrganization(
                    session,
                    params['organizationId'],
                  ),
        ),
        'publishedEventsByOrganization': _i1.MethodConnector(
          name: 'publishedEventsByOrganization',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['public'] as _i11.PublicEndpoint)
                  .publishedEventsByOrganization(
                    session,
                    params['organizationId'],
                  ),
        ),
        'leagueBySlug': _i1.MethodConnector(
          name: 'leagueBySlug',
          params: {
            'organizationSlug': _i1.ParameterDescription(
              name: 'organizationSlug',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'leagueSlug': _i1.ParameterDescription(
              name: 'leagueSlug',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['public'] as _i11.PublicEndpoint).leagueBySlug(
                    session,
                    organizationSlug: params['organizationSlug'],
                    leagueSlug: params['leagueSlug'],
                  ),
        ),
        'teamsByLeague': _i1.MethodConnector(
          name: 'teamsByLeague',
          params: {
            'leagueId': _i1.ParameterDescription(
              name: 'leagueId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['public'] as _i11.PublicEndpoint).teamsByLeague(
                    session,
                    params['leagueId'],
                  ),
        ),
        'standingsByLeague': _i1.MethodConnector(
          name: 'standingsByLeague',
          params: {
            'leagueId': _i1.ParameterDescription(
              name: 'leagueId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['public'] as _i11.PublicEndpoint)
                  .standingsByLeague(
                    session,
                    params['leagueId'],
                  ),
        ),
        'matchesByLeague': _i1.MethodConnector(
          name: 'matchesByLeague',
          params: {
            'leagueId': _i1.ParameterDescription(
              name: 'leagueId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['public'] as _i11.PublicEndpoint).matchesByLeague(
                    session,
                    params['leagueId'],
                  ),
        ),
        'eventBySlug': _i1.MethodConnector(
          name: 'eventBySlug',
          params: {
            'slug': _i1.ParameterDescription(
              name: 'slug',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['public'] as _i11.PublicEndpoint).eventBySlug(
                    session,
                    params['slug'],
                  ),
        ),
        'registrationsByEvent': _i1.MethodConnector(
          name: 'registrationsByEvent',
          params: {
            'eventId': _i1.ParameterDescription(
              name: 'eventId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['public'] as _i11.PublicEndpoint)
                  .registrationsByEvent(
                    session,
                    params['eventId'],
                  ),
        ),
        'search': _i1.MethodConnector(
          name: 'search',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'sport': _i1.ParameterDescription(
              name: 'sport',
              type: _i1.getType<_i17.Sport?>(),
              nullable: true,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['public'] as _i11.PublicEndpoint).search(
                session,
                query: params['query'],
                sport: params['sport'],
                location: params['location'],
              ),
        ),
      },
    );
    connectors['attendance'] = _i1.EndpointConnector(
      name: 'attendance',
      endpoint: endpoints['attendance']!,
      methodConnectors: {
        'record': _i1.MethodConnector(
          name: 'record',
          params: {
            'matchId': _i1.ParameterDescription(
              name: 'matchId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'teamMembershipId': _i1.ParameterDescription(
              name: 'teamMembershipId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<_i20.AttendanceStatus>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['attendance'] as _i12.AttendanceEndpoint).record(
                    session,
                    matchId: params['matchId'],
                    teamMembershipId: params['teamMembershipId'],
                    status: params['status'],
                  ),
        ),
        'listForMatch': _i1.MethodConnector(
          name: 'listForMatch',
          params: {
            'matchId': _i1.ParameterDescription(
              name: 'matchId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['attendance'] as _i12.AttendanceEndpoint)
                  .listForMatch(
                    session,
                    matchId: params['matchId'],
                    teamId: params['teamId'],
                  ),
        ),
      },
    );
    connectors['scheduledMatch'] = _i1.EndpointConnector(
      name: 'scheduledMatch',
      endpoint: endpoints['scheduledMatch']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'leagueId': _i1.ParameterDescription(
              name: 'leagueId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'homeTeamId': _i1.ParameterDescription(
              name: 'homeTeamId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'awayTeamId': _i1.ParameterDescription(
              name: 'awayTeamId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'scheduledAt': _i1.ParameterDescription(
              name: 'scheduledAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scheduledMatch'] as _i13.ScheduledMatchEndpoint)
                      .create(
                        session,
                        leagueId: params['leagueId'],
                        homeTeamId: params['homeTeamId'],
                        awayTeamId: params['awayTeamId'],
                        scheduledAt: params['scheduledAt'],
                        location: params['location'],
                      ),
        ),
        'getById': _i1.MethodConnector(
          name: 'getById',
          params: {
            'matchId': _i1.ParameterDescription(
              name: 'matchId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scheduledMatch'] as _i13.ScheduledMatchEndpoint)
                      .getById(
                        session,
                        params['matchId'],
                      ),
        ),
        'listByLeague': _i1.MethodConnector(
          name: 'listByLeague',
          params: {
            'leagueId': _i1.ParameterDescription(
              name: 'leagueId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scheduledMatch'] as _i13.ScheduledMatchEndpoint)
                      .listByLeague(
                        session,
                        params['leagueId'],
                      ),
        ),
        'update': _i1.MethodConnector(
          name: 'update',
          params: {
            'matchId': _i1.ParameterDescription(
              name: 'matchId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'scheduledAt': _i1.ParameterDescription(
              name: 'scheduledAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scheduledMatch'] as _i13.ScheduledMatchEndpoint)
                      .update(
                        session,
                        params['matchId'],
                        scheduledAt: params['scheduledAt'],
                        location: params['location'],
                      ),
        ),
        'cancel': _i1.MethodConnector(
          name: 'cancel',
          params: {
            'matchId': _i1.ParameterDescription(
              name: 'matchId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scheduledMatch'] as _i13.ScheduledMatchEndpoint)
                      .cancel(
                        session,
                        params['matchId'],
                      ),
        ),
        'recordResult': _i1.MethodConnector(
          name: 'recordResult',
          params: {
            'matchId': _i1.ParameterDescription(
              name: 'matchId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'homeScore': _i1.ParameterDescription(
              name: 'homeScore',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'awayScore': _i1.ParameterDescription(
              name: 'awayScore',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['scheduledMatch'] as _i13.ScheduledMatchEndpoint)
                      .recordResult(
                        session,
                        matchId: params['matchId'],
                        homeScore: params['homeScore'],
                        awayScore: params['awayScore'],
                      ),
        ),
      },
    );
    connectors['search'] = _i1.EndpointConnector(
      name: 'search',
      endpoint: endpoints['search']!,
      methodConnectors: {
        'search': _i1.MethodConnector(
          name: 'search',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'sport': _i1.ParameterDescription(
              name: 'sport',
              type: _i1.getType<_i17.Sport?>(),
              nullable: true,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['search'] as _i14.SearchEndpoint).search(
                session,
                query: params['query'],
                sport: params['sport'],
                location: params['location'],
              ),
        ),
      },
    );
    connectors['standing'] = _i1.EndpointConnector(
      name: 'standing',
      endpoint: endpoints['standing']!,
      methodConnectors: {
        'listByLeague': _i1.MethodConnector(
          name: 'listByLeague',
          params: {
            'leagueId': _i1.ParameterDescription(
              name: 'leagueId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['standing'] as _i15.StandingEndpoint).listByLeague(
                    session,
                    params['leagueId'],
                  ),
        ),
      },
    );
    connectors['team'] = _i1.EndpointConnector(
      name: 'team',
      endpoint: endpoints['team']!,
      methodConnectors: {
        'create': _i1.MethodConnector(
          name: 'create',
          params: {
            'leagueId': _i1.ParameterDescription(
              name: 'leagueId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['team'] as _i16.TeamEndpoint).create(
                session,
                leagueId: params['leagueId'],
                name: params['name'],
              ),
        ),
        'getById': _i1.MethodConnector(
          name: 'getById',
          params: {
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['team'] as _i16.TeamEndpoint).getById(
                session,
                params['teamId'],
              ),
        ),
        'listByLeague': _i1.MethodConnector(
          name: 'listByLeague',
          params: {
            'leagueId': _i1.ParameterDescription(
              name: 'leagueId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['team'] as _i16.TeamEndpoint).listByLeague(
                session,
                params['leagueId'],
              ),
        ),
        'listMembers': _i1.MethodConnector(
          name: 'listMembers',
          params: {
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['team'] as _i16.TeamEndpoint).listMembers(
                session,
                params['teamId'],
              ),
        ),
        'invitePlayer': _i1.MethodConnector(
          name: 'invitePlayer',
          params: {
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<_i21.TeamMemberRole?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['team'] as _i16.TeamEndpoint).invitePlayer(
                session,
                teamId: params['teamId'],
                email: params['email'],
                role: params['role'],
              ),
        ),
        'acceptInvite': _i1.MethodConnector(
          name: 'acceptInvite',
          params: {
            'membershipId': _i1.ParameterDescription(
              name: 'membershipId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['team'] as _i16.TeamEndpoint).acceptInvite(
                session,
                params['membershipId'],
              ),
        ),
        'declineInvite': _i1.MethodConnector(
          name: 'declineInvite',
          params: {
            'membershipId': _i1.ParameterDescription(
              name: 'membershipId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['team'] as _i16.TeamEndpoint).declineInvite(
                session,
                params['membershipId'],
              ),
        ),
        'listMine': _i1.MethodConnector(
          name: 'listMine',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['team'] as _i16.TeamEndpoint).listMine(session),
        ),
      },
    );
    modules['serverpod_auth_core'] = _i22.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_idp'] = _i23.Endpoints()
      ..initializeEndpoints(server);
  }
}
