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
import '../greetings/greeting_endpoint.dart' as _i4;
import '../leagues/league_endpoint.dart' as _i5;
import '../organizations/organization_endpoint.dart' as _i6;
import 'package:bgs_server/src/generated/sports/models/sport.dart' as _i7;
import 'package:bgs_server/src/generated/sports/models/skill_level.dart' as _i8;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i9;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i10;

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
      'greeting': _i4.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'league': _i5.LeagueEndpoint()
        ..initialize(
          server,
          'league',
          null,
        ),
      'organization': _i6.OrganizationEndpoint()
        ..initialize(
          server,
          'organization',
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
              ) async => (endpoints['greeting'] as _i4.GreetingEndpoint).hello(
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
              type: _i1.getType<_i7.Sport>(),
              nullable: false,
            ),
            'teamFeeCents': _i1.ParameterDescription(
              name: 'teamFeeCents',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'skillLevel': _i1.ParameterDescription(
              name: 'skillLevel',
              type: _i1.getType<_i8.SkillLevel?>(),
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
              ) async => (endpoints['league'] as _i5.LeagueEndpoint).create(
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
              ) async => (endpoints['league'] as _i5.LeagueEndpoint).getById(
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
                  (endpoints['league'] as _i5.LeagueEndpoint).getByOrgAndSlug(
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
              ) async => (endpoints['league'] as _i5.LeagueEndpoint)
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
              type: _i1.getType<_i8.SkillLevel?>(),
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
              ) async => (endpoints['league'] as _i5.LeagueEndpoint).update(
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
              ) async => (endpoints['league'] as _i5.LeagueEndpoint).activate(
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
              ) async => (endpoints['organization'] as _i6.OrganizationEndpoint)
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
              ) async => (endpoints['organization'] as _i6.OrganizationEndpoint)
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
              ) async => (endpoints['organization'] as _i6.OrganizationEndpoint)
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
              ) async => (endpoints['organization'] as _i6.OrganizationEndpoint)
                  .listMine(session),
        ),
      },
    );
    modules['serverpod_auth_core'] = _i9.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_idp'] = _i10.Endpoints()
      ..initializeEndpoints(server);
  }
}
