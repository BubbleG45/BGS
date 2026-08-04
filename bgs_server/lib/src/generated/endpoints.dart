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
import '../events/event_endpoint.dart' as _i4;
import '../greetings/greeting_endpoint.dart' as _i5;
import '../leagues/league_endpoint.dart' as _i6;
import '../organizations/organization_endpoint.dart' as _i7;
import '../scheduling/scheduled_match_endpoint.dart' as _i8;
import '../standings/standing_endpoint.dart' as _i9;
import '../teams/team_endpoint.dart' as _i10;
import 'package:bgs_server/src/generated/sports/models/sport.dart' as _i11;
import 'package:bgs_server/src/generated/sports/models/skill_level.dart'
    as _i12;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i13;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i14;

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
      'event': _i4.EventEndpoint()
        ..initialize(
          server,
          'event',
          null,
        ),
      'greeting': _i5.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'league': _i6.LeagueEndpoint()
        ..initialize(
          server,
          'league',
          null,
        ),
      'organization': _i7.OrganizationEndpoint()
        ..initialize(
          server,
          'organization',
          null,
        ),
      'scheduledMatch': _i8.ScheduledMatchEndpoint()
        ..initialize(
          server,
          'scheduledMatch',
          null,
        ),
      'standing': _i9.StandingEndpoint()
        ..initialize(
          server,
          'standing',
          null,
        ),
      'team': _i10.TeamEndpoint()
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
              type: _i1.getType<_i11.Sport>(),
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
              type: _i1.getType<_i12.SkillLevel?>(),
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _i4.EventEndpoint).create(
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
              ) async => (endpoints['event'] as _i4.EventEndpoint).getById(
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
              ) async => (endpoints['event'] as _i4.EventEndpoint).getBySlug(
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
                  (endpoints['event'] as _i4.EventEndpoint).listByOrganization(
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
              type: _i1.getType<_i12.SkillLevel?>(),
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['event'] as _i4.EventEndpoint).update(
                session,
                params['eventId'],
                name: params['name'],
                description: params['description'],
                location: params['location'],
                skillLevel: params['skillLevel'],
                startAt: params['startAt'],
                teamFeeCents: params['teamFeeCents'],
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
              ) async => (endpoints['event'] as _i4.EventEndpoint).publish(
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
              ) async => (endpoints['event'] as _i4.EventEndpoint).register(
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
                  (endpoints['event'] as _i4.EventEndpoint).cancelRegistration(
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
              ) async => (endpoints['event'] as _i4.EventEndpoint)
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
              ) async => (endpoints['greeting'] as _i5.GreetingEndpoint).hello(
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
              type: _i1.getType<_i11.Sport>(),
              nullable: false,
            ),
            'teamFeeCents': _i1.ParameterDescription(
              name: 'teamFeeCents',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'skillLevel': _i1.ParameterDescription(
              name: 'skillLevel',
              type: _i1.getType<_i12.SkillLevel?>(),
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['league'] as _i6.LeagueEndpoint).create(
                session,
                organizationId: params['organizationId'],
                name: params['name'],
                slug: params['slug'],
                sport: params['sport'],
                teamFeeCents: params['teamFeeCents'],
                skillLevel: params['skillLevel'],
                description: params['description'],
                location: params['location'],
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
              ) async => (endpoints['league'] as _i6.LeagueEndpoint).getById(
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
                  (endpoints['league'] as _i6.LeagueEndpoint).getByOrgAndSlug(
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
              ) async => (endpoints['league'] as _i6.LeagueEndpoint)
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
              type: _i1.getType<_i12.SkillLevel?>(),
              nullable: true,
            ),
            'teamFeeCents': _i1.ParameterDescription(
              name: 'teamFeeCents',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['league'] as _i6.LeagueEndpoint).update(
                session,
                params['leagueId'],
                name: params['name'],
                description: params['description'],
                location: params['location'],
                skillLevel: params['skillLevel'],
                teamFeeCents: params['teamFeeCents'],
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
              ) async => (endpoints['league'] as _i6.LeagueEndpoint).activate(
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
              ) async => (endpoints['organization'] as _i7.OrganizationEndpoint)
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
              ) async => (endpoints['organization'] as _i7.OrganizationEndpoint)
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
              ) async => (endpoints['organization'] as _i7.OrganizationEndpoint)
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
              ) async => (endpoints['organization'] as _i7.OrganizationEndpoint)
                  .listMine(session),
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
                  (endpoints['scheduledMatch'] as _i8.ScheduledMatchEndpoint)
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
                  (endpoints['scheduledMatch'] as _i8.ScheduledMatchEndpoint)
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
                  (endpoints['scheduledMatch'] as _i8.ScheduledMatchEndpoint)
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
                  (endpoints['scheduledMatch'] as _i8.ScheduledMatchEndpoint)
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
                  (endpoints['scheduledMatch'] as _i8.ScheduledMatchEndpoint)
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
                  (endpoints['scheduledMatch'] as _i8.ScheduledMatchEndpoint)
                      .recordResult(
                        session,
                        matchId: params['matchId'],
                        homeScore: params['homeScore'],
                        awayScore: params['awayScore'],
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
                  (endpoints['standing'] as _i9.StandingEndpoint).listByLeague(
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
              ) async => (endpoints['team'] as _i10.TeamEndpoint).create(
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
              ) async => (endpoints['team'] as _i10.TeamEndpoint).getById(
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
              ) async => (endpoints['team'] as _i10.TeamEndpoint).listByLeague(
                session,
                params['leagueId'],
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
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['team'] as _i10.TeamEndpoint).invitePlayer(
                session,
                teamId: params['teamId'],
                email: params['email'],
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
              ) async => (endpoints['team'] as _i10.TeamEndpoint).acceptInvite(
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
              ) async => (endpoints['team'] as _i10.TeamEndpoint).declineInvite(
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
                  (endpoints['team'] as _i10.TeamEndpoint).listMine(session),
        ),
      },
    );
    modules['serverpod_auth_core'] = _i13.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_idp'] = _i14.Endpoints()
      ..initializeEndpoints(server);
  }
}
