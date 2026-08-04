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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i3;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i4;
import 'events/models/event.dart' as _i5;
import 'events/models/event_access_denied_exception.dart' as _i6;
import 'events/models/event_not_found_exception.dart' as _i7;
import 'events/models/event_not_open_for_registration_exception.dart' as _i8;
import 'events/models/event_publish_not_allowed_exception.dart' as _i9;
import 'events/models/event_registration.dart' as _i10;
import 'events/models/event_registration_access_denied_exception.dart' as _i11;
import 'events/models/event_registration_action_not_allowed_exception.dart'
    as _i12;
import 'events/models/event_registration_already_exists_exception.dart' as _i13;
import 'events/models/event_registration_not_found_exception.dart' as _i14;
import 'events/models/event_registration_status.dart' as _i15;
import 'events/models/event_slug_taken_exception.dart' as _i16;
import 'events/models/event_status.dart' as _i17;
import 'greetings/greeting.dart' as _i18;
import 'leagues/models/league.dart' as _i19;
import 'leagues/models/league_activation_not_allowed_exception.dart' as _i20;
import 'leagues/models/league_not_found_exception.dart' as _i21;
import 'leagues/models/league_slug_taken_exception.dart' as _i22;
import 'leagues/models/league_status.dart' as _i23;
import 'organizations/models/org_member_role.dart' as _i24;
import 'organizations/models/organization.dart' as _i25;
import 'organizations/models/organization_access_denied_exception.dart' as _i26;
import 'organizations/models/organization_member.dart' as _i27;
import 'organizations/models/organization_membership.dart' as _i28;
import 'organizations/models/organization_slug_taken_exception.dart' as _i29;
import 'scheduling/models/match_action_not_allowed_exception.dart' as _i30;
import 'scheduling/models/match_status.dart' as _i31;
import 'scheduling/models/same_team_match_exception.dart' as _i32;
import 'scheduling/models/scheduled_match.dart' as _i33;
import 'scheduling/models/scheduled_match_not_found_exception.dart' as _i34;
import 'scheduling/models/team_not_in_league_exception.dart' as _i35;
import 'sports/models/skill_level.dart' as _i36;
import 'sports/models/sport.dart' as _i37;
import 'standings/models/standing.dart' as _i38;
import 'teams/models/membership_status.dart' as _i39;
import 'teams/models/player_not_found_exception.dart' as _i40;
import 'teams/models/team.dart' as _i41;
import 'teams/models/team_member_role.dart' as _i42;
import 'teams/models/team_membership.dart' as _i43;
import 'teams/models/team_membership_access_denied_exception.dart' as _i44;
import 'teams/models/team_membership_action_not_allowed_exception.dart' as _i45;
import 'teams/models/team_membership_already_exists_exception.dart' as _i46;
import 'teams/models/team_membership_not_found_exception.dart' as _i47;
import 'teams/models/team_not_found_exception.dart' as _i48;
import 'package:bgs_server/src/generated/events/models/event.dart' as _i49;
import 'package:bgs_server/src/generated/events/models/event_registration.dart'
    as _i50;
import 'package:bgs_server/src/generated/leagues/models/league.dart' as _i51;
import 'package:bgs_server/src/generated/organizations/models/organization_membership.dart'
    as _i52;
import 'package:bgs_server/src/generated/scheduling/models/scheduled_match.dart'
    as _i53;
import 'package:bgs_server/src/generated/standings/models/standing.dart'
    as _i54;
import 'package:bgs_server/src/generated/teams/models/team.dart' as _i55;
import 'package:bgs_server/src/generated/teams/models/team_membership.dart'
    as _i56;
export 'events/models/event.dart';
export 'events/models/event_access_denied_exception.dart';
export 'events/models/event_not_found_exception.dart';
export 'events/models/event_not_open_for_registration_exception.dart';
export 'events/models/event_publish_not_allowed_exception.dart';
export 'events/models/event_registration.dart';
export 'events/models/event_registration_access_denied_exception.dart';
export 'events/models/event_registration_action_not_allowed_exception.dart';
export 'events/models/event_registration_already_exists_exception.dart';
export 'events/models/event_registration_not_found_exception.dart';
export 'events/models/event_registration_status.dart';
export 'events/models/event_slug_taken_exception.dart';
export 'events/models/event_status.dart';
export 'greetings/greeting.dart';
export 'leagues/models/league.dart';
export 'leagues/models/league_activation_not_allowed_exception.dart';
export 'leagues/models/league_not_found_exception.dart';
export 'leagues/models/league_slug_taken_exception.dart';
export 'leagues/models/league_status.dart';
export 'organizations/models/org_member_role.dart';
export 'organizations/models/organization.dart';
export 'organizations/models/organization_access_denied_exception.dart';
export 'organizations/models/organization_member.dart';
export 'organizations/models/organization_membership.dart';
export 'organizations/models/organization_slug_taken_exception.dart';
export 'scheduling/models/match_action_not_allowed_exception.dart';
export 'scheduling/models/match_status.dart';
export 'scheduling/models/same_team_match_exception.dart';
export 'scheduling/models/scheduled_match.dart';
export 'scheduling/models/scheduled_match_not_found_exception.dart';
export 'scheduling/models/team_not_in_league_exception.dart';
export 'sports/models/skill_level.dart';
export 'sports/models/sport.dart';
export 'standings/models/standing.dart';
export 'teams/models/membership_status.dart';
export 'teams/models/player_not_found_exception.dart';
export 'teams/models/team.dart';
export 'teams/models/team_member_role.dart';
export 'teams/models/team_membership.dart';
export 'teams/models/team_membership_access_denied_exception.dart';
export 'teams/models/team_membership_action_not_allowed_exception.dart';
export 'teams/models/team_membership_already_exists_exception.dart';
export 'teams/models/team_membership_not_found_exception.dart';
export 'teams/models/team_not_found_exception.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'bgs_event',
      dartName: 'Event',
      schema: 'public',
      module: 'bgs',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _i2.ColumnDefinition(
          name: 'createdByAuthUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'slug',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'sport',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Sport',
        ),
        _i2.ColumnDefinition(
          name: 'skillLevel',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:SkillLevel?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'location',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'startAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'isTournament',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:EventStatus',
        ),
        _i2.ColumnDefinition(
          name: 'teamFeeCents',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'bgs_event_fk_0',
          columns: ['organizationId'],
          referenceTable: 'bgs_organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'bgs_event_fk_1',
          columns: ['createdByAuthUserId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'bgs_event_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'bgs_event_slug_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'slug',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'bgs_event_registration',
      dartName: 'EventRegistration',
      schema: 'public',
      module: 'bgs',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'eventId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'registeredByAuthUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'teamName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:EventRegistrationStatus',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'bgs_event_registration_fk_0',
          columns: ['eventId'],
          referenceTable: 'bgs_event',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'bgs_event_registration_fk_1',
          columns: ['registeredByAuthUserId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'bgs_event_registration_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'bgs_event_registration_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'eventId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'registeredByAuthUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'bgs_league',
      dartName: 'League',
      schema: 'public',
      module: 'bgs',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'slug',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'sport',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:Sport',
        ),
        _i2.ColumnDefinition(
          name: 'skillLevel',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:SkillLevel?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'location',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:LeagueStatus',
        ),
        _i2.ColumnDefinition(
          name: 'teamFeeCents',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'bgs_league_fk_0',
          columns: ['organizationId'],
          referenceTable: 'bgs_organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'bgs_league_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'bgs_league_org_slug_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'organizationId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'slug',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'bgs_organization',
      dartName: 'Organization',
      schema: 'public',
      module: 'bgs',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'slug',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'bgs_organization_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'bgs_organization_slug_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'slug',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'bgs_organization_member',
      dartName: 'OrganizationMember',
      schema: 'public',
      module: 'bgs',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'organizationId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'authUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'role',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:OrgMemberRole',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'bgs_organization_member_fk_0',
          columns: ['organizationId'],
          referenceTable: 'bgs_organization',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'bgs_organization_member_fk_1',
          columns: ['authUserId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'bgs_organization_member_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'bgs_organization_member_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'organizationId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'bgs_scheduled_match',
      dartName: 'ScheduledMatch',
      schema: 'public',
      module: 'bgs',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'leagueId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'homeTeamId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'awayTeamId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'scheduledAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'location',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MatchStatus',
        ),
        _i2.ColumnDefinition(
          name: 'homeScore',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'awayScore',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'bgs_scheduled_match_fk_0',
          columns: ['leagueId'],
          referenceTable: 'bgs_league',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'bgs_scheduled_match_fk_1',
          columns: ['homeTeamId'],
          referenceTable: 'bgs_team',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'bgs_scheduled_match_fk_2',
          columns: ['awayTeamId'],
          referenceTable: 'bgs_team',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'bgs_scheduled_match_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'bgs_standing',
      dartName: 'Standing',
      schema: 'public',
      module: 'bgs',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'leagueId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'teamId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'wins',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'losses',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'ties',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'pointsFor',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'pointsAgainst',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'bgs_standing_fk_0',
          columns: ['leagueId'],
          referenceTable: 'bgs_league',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'bgs_standing_fk_1',
          columns: ['teamId'],
          referenceTable: 'bgs_team',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'bgs_standing_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'bgs_standing_league_team_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'leagueId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'teamId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'bgs_team',
      dartName: 'Team',
      schema: 'public',
      module: 'bgs',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'leagueId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'bgs_team_fk_0',
          columns: ['leagueId'],
          referenceTable: 'bgs_league',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'bgs_team_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'bgs_team_membership',
      dartName: 'TeamMembership',
      schema: 'public',
      module: 'bgs',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'teamId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'authUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'role',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:TeamMemberRole',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MembershipStatus',
        ),
        _i2.ColumnDefinition(
          name: 'invitedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'joinedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'bgs_team_membership_fk_0',
          columns: ['teamId'],
          referenceTable: 'bgs_team',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'bgs_team_membership_fk_1',
          columns: ['authUserId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'bgs_team_membership_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'bgs_team_membership_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'teamId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i5.Event) {
      return _i5.Event.fromJson(data) as T;
    }
    if (t == _i6.EventAccessDeniedException) {
      return _i6.EventAccessDeniedException.fromJson(data) as T;
    }
    if (t == _i7.EventNotFoundException) {
      return _i7.EventNotFoundException.fromJson(data) as T;
    }
    if (t == _i8.EventNotOpenForRegistrationException) {
      return _i8.EventNotOpenForRegistrationException.fromJson(data) as T;
    }
    if (t == _i9.EventPublishNotAllowedException) {
      return _i9.EventPublishNotAllowedException.fromJson(data) as T;
    }
    if (t == _i10.EventRegistration) {
      return _i10.EventRegistration.fromJson(data) as T;
    }
    if (t == _i11.EventRegistrationAccessDeniedException) {
      return _i11.EventRegistrationAccessDeniedException.fromJson(data) as T;
    }
    if (t == _i12.EventRegistrationActionNotAllowedException) {
      return _i12.EventRegistrationActionNotAllowedException.fromJson(data)
          as T;
    }
    if (t == _i13.EventRegistrationAlreadyExistsException) {
      return _i13.EventRegistrationAlreadyExistsException.fromJson(data) as T;
    }
    if (t == _i14.EventRegistrationNotFoundException) {
      return _i14.EventRegistrationNotFoundException.fromJson(data) as T;
    }
    if (t == _i15.EventRegistrationStatus) {
      return _i15.EventRegistrationStatus.fromJson(data) as T;
    }
    if (t == _i16.EventSlugTakenException) {
      return _i16.EventSlugTakenException.fromJson(data) as T;
    }
    if (t == _i17.EventStatus) {
      return _i17.EventStatus.fromJson(data) as T;
    }
    if (t == _i18.Greeting) {
      return _i18.Greeting.fromJson(data) as T;
    }
    if (t == _i19.League) {
      return _i19.League.fromJson(data) as T;
    }
    if (t == _i20.LeagueActivationNotAllowedException) {
      return _i20.LeagueActivationNotAllowedException.fromJson(data) as T;
    }
    if (t == _i21.LeagueNotFoundException) {
      return _i21.LeagueNotFoundException.fromJson(data) as T;
    }
    if (t == _i22.LeagueSlugTakenException) {
      return _i22.LeagueSlugTakenException.fromJson(data) as T;
    }
    if (t == _i23.LeagueStatus) {
      return _i23.LeagueStatus.fromJson(data) as T;
    }
    if (t == _i24.OrgMemberRole) {
      return _i24.OrgMemberRole.fromJson(data) as T;
    }
    if (t == _i25.Organization) {
      return _i25.Organization.fromJson(data) as T;
    }
    if (t == _i26.OrganizationAccessDeniedException) {
      return _i26.OrganizationAccessDeniedException.fromJson(data) as T;
    }
    if (t == _i27.OrganizationMember) {
      return _i27.OrganizationMember.fromJson(data) as T;
    }
    if (t == _i28.OrganizationMembership) {
      return _i28.OrganizationMembership.fromJson(data) as T;
    }
    if (t == _i29.OrganizationSlugTakenException) {
      return _i29.OrganizationSlugTakenException.fromJson(data) as T;
    }
    if (t == _i30.MatchActionNotAllowedException) {
      return _i30.MatchActionNotAllowedException.fromJson(data) as T;
    }
    if (t == _i31.MatchStatus) {
      return _i31.MatchStatus.fromJson(data) as T;
    }
    if (t == _i32.SameTeamMatchException) {
      return _i32.SameTeamMatchException.fromJson(data) as T;
    }
    if (t == _i33.ScheduledMatch) {
      return _i33.ScheduledMatch.fromJson(data) as T;
    }
    if (t == _i34.ScheduledMatchNotFoundException) {
      return _i34.ScheduledMatchNotFoundException.fromJson(data) as T;
    }
    if (t == _i35.TeamNotInLeagueException) {
      return _i35.TeamNotInLeagueException.fromJson(data) as T;
    }
    if (t == _i36.SkillLevel) {
      return _i36.SkillLevel.fromJson(data) as T;
    }
    if (t == _i37.Sport) {
      return _i37.Sport.fromJson(data) as T;
    }
    if (t == _i38.Standing) {
      return _i38.Standing.fromJson(data) as T;
    }
    if (t == _i39.MembershipStatus) {
      return _i39.MembershipStatus.fromJson(data) as T;
    }
    if (t == _i40.PlayerNotFoundException) {
      return _i40.PlayerNotFoundException.fromJson(data) as T;
    }
    if (t == _i41.Team) {
      return _i41.Team.fromJson(data) as T;
    }
    if (t == _i42.TeamMemberRole) {
      return _i42.TeamMemberRole.fromJson(data) as T;
    }
    if (t == _i43.TeamMembership) {
      return _i43.TeamMembership.fromJson(data) as T;
    }
    if (t == _i44.TeamMembershipAccessDeniedException) {
      return _i44.TeamMembershipAccessDeniedException.fromJson(data) as T;
    }
    if (t == _i45.TeamMembershipActionNotAllowedException) {
      return _i45.TeamMembershipActionNotAllowedException.fromJson(data) as T;
    }
    if (t == _i46.TeamMembershipAlreadyExistsException) {
      return _i46.TeamMembershipAlreadyExistsException.fromJson(data) as T;
    }
    if (t == _i47.TeamMembershipNotFoundException) {
      return _i47.TeamMembershipNotFoundException.fromJson(data) as T;
    }
    if (t == _i48.TeamNotFoundException) {
      return _i48.TeamNotFoundException.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.Event?>()) {
      return (data != null ? _i5.Event.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.EventAccessDeniedException?>()) {
      return (data != null
              ? _i6.EventAccessDeniedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i7.EventNotFoundException?>()) {
      return (data != null ? _i7.EventNotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.EventNotOpenForRegistrationException?>()) {
      return (data != null
              ? _i8.EventNotOpenForRegistrationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i9.EventPublishNotAllowedException?>()) {
      return (data != null
              ? _i9.EventPublishNotAllowedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i10.EventRegistration?>()) {
      return (data != null ? _i10.EventRegistration.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.EventRegistrationAccessDeniedException?>()) {
      return (data != null
              ? _i11.EventRegistrationAccessDeniedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i12.EventRegistrationActionNotAllowedException?>()) {
      return (data != null
              ? _i12.EventRegistrationActionNotAllowedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i13.EventRegistrationAlreadyExistsException?>()) {
      return (data != null
              ? _i13.EventRegistrationAlreadyExistsException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i14.EventRegistrationNotFoundException?>()) {
      return (data != null
              ? _i14.EventRegistrationNotFoundException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i15.EventRegistrationStatus?>()) {
      return (data != null ? _i15.EventRegistrationStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.EventSlugTakenException?>()) {
      return (data != null ? _i16.EventSlugTakenException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.EventStatus?>()) {
      return (data != null ? _i17.EventStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.Greeting?>()) {
      return (data != null ? _i18.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.League?>()) {
      return (data != null ? _i19.League.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.LeagueActivationNotAllowedException?>()) {
      return (data != null
              ? _i20.LeagueActivationNotAllowedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i21.LeagueNotFoundException?>()) {
      return (data != null ? _i21.LeagueNotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.LeagueSlugTakenException?>()) {
      return (data != null
              ? _i22.LeagueSlugTakenException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i23.LeagueStatus?>()) {
      return (data != null ? _i23.LeagueStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.OrgMemberRole?>()) {
      return (data != null ? _i24.OrgMemberRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.Organization?>()) {
      return (data != null ? _i25.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.OrganizationAccessDeniedException?>()) {
      return (data != null
              ? _i26.OrganizationAccessDeniedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i27.OrganizationMember?>()) {
      return (data != null ? _i27.OrganizationMember.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.OrganizationMembership?>()) {
      return (data != null ? _i28.OrganizationMembership.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i29.OrganizationSlugTakenException?>()) {
      return (data != null
              ? _i29.OrganizationSlugTakenException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i30.MatchActionNotAllowedException?>()) {
      return (data != null
              ? _i30.MatchActionNotAllowedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i31.MatchStatus?>()) {
      return (data != null ? _i31.MatchStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.SameTeamMatchException?>()) {
      return (data != null ? _i32.SameTeamMatchException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i33.ScheduledMatch?>()) {
      return (data != null ? _i33.ScheduledMatch.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.ScheduledMatchNotFoundException?>()) {
      return (data != null
              ? _i34.ScheduledMatchNotFoundException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i35.TeamNotInLeagueException?>()) {
      return (data != null
              ? _i35.TeamNotInLeagueException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i36.SkillLevel?>()) {
      return (data != null ? _i36.SkillLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.Sport?>()) {
      return (data != null ? _i37.Sport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.Standing?>()) {
      return (data != null ? _i38.Standing.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.MembershipStatus?>()) {
      return (data != null ? _i39.MembershipStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.PlayerNotFoundException?>()) {
      return (data != null ? _i40.PlayerNotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i41.Team?>()) {
      return (data != null ? _i41.Team.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.TeamMemberRole?>()) {
      return (data != null ? _i42.TeamMemberRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.TeamMembership?>()) {
      return (data != null ? _i43.TeamMembership.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.TeamMembershipAccessDeniedException?>()) {
      return (data != null
              ? _i44.TeamMembershipAccessDeniedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i45.TeamMembershipActionNotAllowedException?>()) {
      return (data != null
              ? _i45.TeamMembershipActionNotAllowedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i46.TeamMembershipAlreadyExistsException?>()) {
      return (data != null
              ? _i46.TeamMembershipAlreadyExistsException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i47.TeamMembershipNotFoundException?>()) {
      return (data != null
              ? _i47.TeamMembershipNotFoundException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i48.TeamNotFoundException?>()) {
      return (data != null ? _i48.TeamNotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == List<_i33.ScheduledMatch>) {
      return (data as List)
              .map((e) => deserialize<_i33.ScheduledMatch>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i33.ScheduledMatch>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i33.ScheduledMatch>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i49.Event>) {
      return (data as List).map((e) => deserialize<_i49.Event>(e)).toList()
          as T;
    }
    if (t == List<_i50.EventRegistration>) {
      return (data as List)
              .map((e) => deserialize<_i50.EventRegistration>(e))
              .toList()
          as T;
    }
    if (t == List<_i51.League>) {
      return (data as List).map((e) => deserialize<_i51.League>(e)).toList()
          as T;
    }
    if (t == List<_i52.OrganizationMembership>) {
      return (data as List)
              .map((e) => deserialize<_i52.OrganizationMembership>(e))
              .toList()
          as T;
    }
    if (t == List<_i53.ScheduledMatch>) {
      return (data as List)
              .map((e) => deserialize<_i53.ScheduledMatch>(e))
              .toList()
          as T;
    }
    if (t == List<_i54.Standing>) {
      return (data as List).map((e) => deserialize<_i54.Standing>(e)).toList()
          as T;
    }
    if (t == List<_i55.Team>) {
      return (data as List).map((e) => deserialize<_i55.Team>(e)).toList() as T;
    }
    if (t == List<_i56.TeamMembership>) {
      return (data as List)
              .map((e) => deserialize<_i56.TeamMembership>(e))
              .toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.Event => 'Event',
      _i6.EventAccessDeniedException => 'EventAccessDeniedException',
      _i7.EventNotFoundException => 'EventNotFoundException',
      _i8.EventNotOpenForRegistrationException =>
        'EventNotOpenForRegistrationException',
      _i9.EventPublishNotAllowedException => 'EventPublishNotAllowedException',
      _i10.EventRegistration => 'EventRegistration',
      _i11.EventRegistrationAccessDeniedException =>
        'EventRegistrationAccessDeniedException',
      _i12.EventRegistrationActionNotAllowedException =>
        'EventRegistrationActionNotAllowedException',
      _i13.EventRegistrationAlreadyExistsException =>
        'EventRegistrationAlreadyExistsException',
      _i14.EventRegistrationNotFoundException =>
        'EventRegistrationNotFoundException',
      _i15.EventRegistrationStatus => 'EventRegistrationStatus',
      _i16.EventSlugTakenException => 'EventSlugTakenException',
      _i17.EventStatus => 'EventStatus',
      _i18.Greeting => 'Greeting',
      _i19.League => 'League',
      _i20.LeagueActivationNotAllowedException =>
        'LeagueActivationNotAllowedException',
      _i21.LeagueNotFoundException => 'LeagueNotFoundException',
      _i22.LeagueSlugTakenException => 'LeagueSlugTakenException',
      _i23.LeagueStatus => 'LeagueStatus',
      _i24.OrgMemberRole => 'OrgMemberRole',
      _i25.Organization => 'Organization',
      _i26.OrganizationAccessDeniedException =>
        'OrganizationAccessDeniedException',
      _i27.OrganizationMember => 'OrganizationMember',
      _i28.OrganizationMembership => 'OrganizationMembership',
      _i29.OrganizationSlugTakenException => 'OrganizationSlugTakenException',
      _i30.MatchActionNotAllowedException => 'MatchActionNotAllowedException',
      _i31.MatchStatus => 'MatchStatus',
      _i32.SameTeamMatchException => 'SameTeamMatchException',
      _i33.ScheduledMatch => 'ScheduledMatch',
      _i34.ScheduledMatchNotFoundException => 'ScheduledMatchNotFoundException',
      _i35.TeamNotInLeagueException => 'TeamNotInLeagueException',
      _i36.SkillLevel => 'SkillLevel',
      _i37.Sport => 'Sport',
      _i38.Standing => 'Standing',
      _i39.MembershipStatus => 'MembershipStatus',
      _i40.PlayerNotFoundException => 'PlayerNotFoundException',
      _i41.Team => 'Team',
      _i42.TeamMemberRole => 'TeamMemberRole',
      _i43.TeamMembership => 'TeamMembership',
      _i44.TeamMembershipAccessDeniedException =>
        'TeamMembershipAccessDeniedException',
      _i45.TeamMembershipActionNotAllowedException =>
        'TeamMembershipActionNotAllowedException',
      _i46.TeamMembershipAlreadyExistsException =>
        'TeamMembershipAlreadyExistsException',
      _i47.TeamMembershipNotFoundException => 'TeamMembershipNotFoundException',
      _i48.TeamNotFoundException => 'TeamNotFoundException',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('bgs.', '');
    }

    switch (data) {
      case _i5.Event():
        return 'Event';
      case _i6.EventAccessDeniedException():
        return 'EventAccessDeniedException';
      case _i7.EventNotFoundException():
        return 'EventNotFoundException';
      case _i8.EventNotOpenForRegistrationException():
        return 'EventNotOpenForRegistrationException';
      case _i9.EventPublishNotAllowedException():
        return 'EventPublishNotAllowedException';
      case _i10.EventRegistration():
        return 'EventRegistration';
      case _i11.EventRegistrationAccessDeniedException():
        return 'EventRegistrationAccessDeniedException';
      case _i12.EventRegistrationActionNotAllowedException():
        return 'EventRegistrationActionNotAllowedException';
      case _i13.EventRegistrationAlreadyExistsException():
        return 'EventRegistrationAlreadyExistsException';
      case _i14.EventRegistrationNotFoundException():
        return 'EventRegistrationNotFoundException';
      case _i15.EventRegistrationStatus():
        return 'EventRegistrationStatus';
      case _i16.EventSlugTakenException():
        return 'EventSlugTakenException';
      case _i17.EventStatus():
        return 'EventStatus';
      case _i18.Greeting():
        return 'Greeting';
      case _i19.League():
        return 'League';
      case _i20.LeagueActivationNotAllowedException():
        return 'LeagueActivationNotAllowedException';
      case _i21.LeagueNotFoundException():
        return 'LeagueNotFoundException';
      case _i22.LeagueSlugTakenException():
        return 'LeagueSlugTakenException';
      case _i23.LeagueStatus():
        return 'LeagueStatus';
      case _i24.OrgMemberRole():
        return 'OrgMemberRole';
      case _i25.Organization():
        return 'Organization';
      case _i26.OrganizationAccessDeniedException():
        return 'OrganizationAccessDeniedException';
      case _i27.OrganizationMember():
        return 'OrganizationMember';
      case _i28.OrganizationMembership():
        return 'OrganizationMembership';
      case _i29.OrganizationSlugTakenException():
        return 'OrganizationSlugTakenException';
      case _i30.MatchActionNotAllowedException():
        return 'MatchActionNotAllowedException';
      case _i31.MatchStatus():
        return 'MatchStatus';
      case _i32.SameTeamMatchException():
        return 'SameTeamMatchException';
      case _i33.ScheduledMatch():
        return 'ScheduledMatch';
      case _i34.ScheduledMatchNotFoundException():
        return 'ScheduledMatchNotFoundException';
      case _i35.TeamNotInLeagueException():
        return 'TeamNotInLeagueException';
      case _i36.SkillLevel():
        return 'SkillLevel';
      case _i37.Sport():
        return 'Sport';
      case _i38.Standing():
        return 'Standing';
      case _i39.MembershipStatus():
        return 'MembershipStatus';
      case _i40.PlayerNotFoundException():
        return 'PlayerNotFoundException';
      case _i41.Team():
        return 'Team';
      case _i42.TeamMemberRole():
        return 'TeamMemberRole';
      case _i43.TeamMembership():
        return 'TeamMembership';
      case _i44.TeamMembershipAccessDeniedException():
        return 'TeamMembershipAccessDeniedException';
      case _i45.TeamMembershipActionNotAllowedException():
        return 'TeamMembershipActionNotAllowedException';
      case _i46.TeamMembershipAlreadyExistsException():
        return 'TeamMembershipAlreadyExistsException';
      case _i47.TeamMembershipNotFoundException():
        return 'TeamMembershipNotFoundException';
      case _i48.TeamNotFoundException():
        return 'TeamNotFoundException';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Event') {
      return deserialize<_i5.Event>(data['data']);
    }
    if (dataClassName == 'EventAccessDeniedException') {
      return deserialize<_i6.EventAccessDeniedException>(data['data']);
    }
    if (dataClassName == 'EventNotFoundException') {
      return deserialize<_i7.EventNotFoundException>(data['data']);
    }
    if (dataClassName == 'EventNotOpenForRegistrationException') {
      return deserialize<_i8.EventNotOpenForRegistrationException>(
        data['data'],
      );
    }
    if (dataClassName == 'EventPublishNotAllowedException') {
      return deserialize<_i9.EventPublishNotAllowedException>(data['data']);
    }
    if (dataClassName == 'EventRegistration') {
      return deserialize<_i10.EventRegistration>(data['data']);
    }
    if (dataClassName == 'EventRegistrationAccessDeniedException') {
      return deserialize<_i11.EventRegistrationAccessDeniedException>(
        data['data'],
      );
    }
    if (dataClassName == 'EventRegistrationActionNotAllowedException') {
      return deserialize<_i12.EventRegistrationActionNotAllowedException>(
        data['data'],
      );
    }
    if (dataClassName == 'EventRegistrationAlreadyExistsException') {
      return deserialize<_i13.EventRegistrationAlreadyExistsException>(
        data['data'],
      );
    }
    if (dataClassName == 'EventRegistrationNotFoundException') {
      return deserialize<_i14.EventRegistrationNotFoundException>(data['data']);
    }
    if (dataClassName == 'EventRegistrationStatus') {
      return deserialize<_i15.EventRegistrationStatus>(data['data']);
    }
    if (dataClassName == 'EventSlugTakenException') {
      return deserialize<_i16.EventSlugTakenException>(data['data']);
    }
    if (dataClassName == 'EventStatus') {
      return deserialize<_i17.EventStatus>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i18.Greeting>(data['data']);
    }
    if (dataClassName == 'League') {
      return deserialize<_i19.League>(data['data']);
    }
    if (dataClassName == 'LeagueActivationNotAllowedException') {
      return deserialize<_i20.LeagueActivationNotAllowedException>(
        data['data'],
      );
    }
    if (dataClassName == 'LeagueNotFoundException') {
      return deserialize<_i21.LeagueNotFoundException>(data['data']);
    }
    if (dataClassName == 'LeagueSlugTakenException') {
      return deserialize<_i22.LeagueSlugTakenException>(data['data']);
    }
    if (dataClassName == 'LeagueStatus') {
      return deserialize<_i23.LeagueStatus>(data['data']);
    }
    if (dataClassName == 'OrgMemberRole') {
      return deserialize<_i24.OrgMemberRole>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i25.Organization>(data['data']);
    }
    if (dataClassName == 'OrganizationAccessDeniedException') {
      return deserialize<_i26.OrganizationAccessDeniedException>(data['data']);
    }
    if (dataClassName == 'OrganizationMember') {
      return deserialize<_i27.OrganizationMember>(data['data']);
    }
    if (dataClassName == 'OrganizationMembership') {
      return deserialize<_i28.OrganizationMembership>(data['data']);
    }
    if (dataClassName == 'OrganizationSlugTakenException') {
      return deserialize<_i29.OrganizationSlugTakenException>(data['data']);
    }
    if (dataClassName == 'MatchActionNotAllowedException') {
      return deserialize<_i30.MatchActionNotAllowedException>(data['data']);
    }
    if (dataClassName == 'MatchStatus') {
      return deserialize<_i31.MatchStatus>(data['data']);
    }
    if (dataClassName == 'SameTeamMatchException') {
      return deserialize<_i32.SameTeamMatchException>(data['data']);
    }
    if (dataClassName == 'ScheduledMatch') {
      return deserialize<_i33.ScheduledMatch>(data['data']);
    }
    if (dataClassName == 'ScheduledMatchNotFoundException') {
      return deserialize<_i34.ScheduledMatchNotFoundException>(data['data']);
    }
    if (dataClassName == 'TeamNotInLeagueException') {
      return deserialize<_i35.TeamNotInLeagueException>(data['data']);
    }
    if (dataClassName == 'SkillLevel') {
      return deserialize<_i36.SkillLevel>(data['data']);
    }
    if (dataClassName == 'Sport') {
      return deserialize<_i37.Sport>(data['data']);
    }
    if (dataClassName == 'Standing') {
      return deserialize<_i38.Standing>(data['data']);
    }
    if (dataClassName == 'MembershipStatus') {
      return deserialize<_i39.MembershipStatus>(data['data']);
    }
    if (dataClassName == 'PlayerNotFoundException') {
      return deserialize<_i40.PlayerNotFoundException>(data['data']);
    }
    if (dataClassName == 'Team') {
      return deserialize<_i41.Team>(data['data']);
    }
    if (dataClassName == 'TeamMemberRole') {
      return deserialize<_i42.TeamMemberRole>(data['data']);
    }
    if (dataClassName == 'TeamMembership') {
      return deserialize<_i43.TeamMembership>(data['data']);
    }
    if (dataClassName == 'TeamMembershipAccessDeniedException') {
      return deserialize<_i44.TeamMembershipAccessDeniedException>(
        data['data'],
      );
    }
    if (dataClassName == 'TeamMembershipActionNotAllowedException') {
      return deserialize<_i45.TeamMembershipActionNotAllowedException>(
        data['data'],
      );
    }
    if (dataClassName == 'TeamMembershipAlreadyExistsException') {
      return deserialize<_i46.TeamMembershipAlreadyExistsException>(
        data['data'],
      );
    }
    if (dataClassName == 'TeamMembershipNotFoundException') {
      return deserialize<_i47.TeamMembershipNotFoundException>(data['data']);
    }
    if (dataClassName == 'TeamNotFoundException') {
      return deserialize<_i48.TeamNotFoundException>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i5.Event:
        return _i5.Event.t;
      case _i10.EventRegistration:
        return _i10.EventRegistration.t;
      case _i19.League:
        return _i19.League.t;
      case _i25.Organization:
        return _i25.Organization.t;
      case _i27.OrganizationMember:
        return _i27.OrganizationMember.t;
      case _i33.ScheduledMatch:
        return _i33.ScheduledMatch.t;
      case _i38.Standing:
        return _i38.Standing.t;
      case _i41.Team:
        return _i41.Team.t;
      case _i43.TeamMembership:
        return _i43.TeamMembership.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'bgs';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
