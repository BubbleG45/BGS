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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'events/models/event.dart' as _i2;
import 'events/models/event_registration.dart' as _i3;
import 'events/models/event_registration_status.dart' as _i4;
import 'events/models/event_status.dart' as _i5;
import 'greetings/greeting.dart' as _i6;
import 'leagues/models/league.dart' as _i7;
import 'leagues/models/league_status.dart' as _i8;
import 'organizations/models/org_member_role.dart' as _i9;
import 'organizations/models/organization.dart' as _i10;
import 'organizations/models/organization_member.dart' as _i11;
import 'scheduling/models/match_status.dart' as _i12;
import 'scheduling/models/scheduled_match.dart' as _i13;
import 'sports/models/skill_level.dart' as _i14;
import 'sports/models/sport.dart' as _i15;
import 'standings/models/standing.dart' as _i16;
import 'teams/models/membership_status.dart' as _i17;
import 'teams/models/team.dart' as _i18;
import 'teams/models/team_member_role.dart' as _i19;
import 'teams/models/team_membership.dart' as _i20;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i21;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i22;
export 'events/models/event.dart';
export 'events/models/event_registration.dart';
export 'events/models/event_registration_status.dart';
export 'events/models/event_status.dart';
export 'greetings/greeting.dart';
export 'leagues/models/league.dart';
export 'leagues/models/league_status.dart';
export 'organizations/models/org_member_role.dart';
export 'organizations/models/organization.dart';
export 'organizations/models/organization_member.dart';
export 'scheduling/models/match_status.dart';
export 'scheduling/models/scheduled_match.dart';
export 'sports/models/skill_level.dart';
export 'sports/models/sport.dart';
export 'standings/models/standing.dart';
export 'teams/models/membership_status.dart';
export 'teams/models/team.dart';
export 'teams/models/team_member_role.dart';
export 'teams/models/team_membership.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

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

    if (t == _i2.Event) {
      return _i2.Event.fromJson(data) as T;
    }
    if (t == _i3.EventRegistration) {
      return _i3.EventRegistration.fromJson(data) as T;
    }
    if (t == _i4.EventRegistrationStatus) {
      return _i4.EventRegistrationStatus.fromJson(data) as T;
    }
    if (t == _i5.EventStatus) {
      return _i5.EventStatus.fromJson(data) as T;
    }
    if (t == _i6.Greeting) {
      return _i6.Greeting.fromJson(data) as T;
    }
    if (t == _i7.League) {
      return _i7.League.fromJson(data) as T;
    }
    if (t == _i8.LeagueStatus) {
      return _i8.LeagueStatus.fromJson(data) as T;
    }
    if (t == _i9.OrgMemberRole) {
      return _i9.OrgMemberRole.fromJson(data) as T;
    }
    if (t == _i10.Organization) {
      return _i10.Organization.fromJson(data) as T;
    }
    if (t == _i11.OrganizationMember) {
      return _i11.OrganizationMember.fromJson(data) as T;
    }
    if (t == _i12.MatchStatus) {
      return _i12.MatchStatus.fromJson(data) as T;
    }
    if (t == _i13.ScheduledMatch) {
      return _i13.ScheduledMatch.fromJson(data) as T;
    }
    if (t == _i14.SkillLevel) {
      return _i14.SkillLevel.fromJson(data) as T;
    }
    if (t == _i15.Sport) {
      return _i15.Sport.fromJson(data) as T;
    }
    if (t == _i16.Standing) {
      return _i16.Standing.fromJson(data) as T;
    }
    if (t == _i17.MembershipStatus) {
      return _i17.MembershipStatus.fromJson(data) as T;
    }
    if (t == _i18.Team) {
      return _i18.Team.fromJson(data) as T;
    }
    if (t == _i19.TeamMemberRole) {
      return _i19.TeamMemberRole.fromJson(data) as T;
    }
    if (t == _i20.TeamMembership) {
      return _i20.TeamMembership.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Event?>()) {
      return (data != null ? _i2.Event.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.EventRegistration?>()) {
      return (data != null ? _i3.EventRegistration.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.EventRegistrationStatus?>()) {
      return (data != null ? _i4.EventRegistrationStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i5.EventStatus?>()) {
      return (data != null ? _i5.EventStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Greeting?>()) {
      return (data != null ? _i6.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.League?>()) {
      return (data != null ? _i7.League.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.LeagueStatus?>()) {
      return (data != null ? _i8.LeagueStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.OrgMemberRole?>()) {
      return (data != null ? _i9.OrgMemberRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Organization?>()) {
      return (data != null ? _i10.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.OrganizationMember?>()) {
      return (data != null ? _i11.OrganizationMember.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.MatchStatus?>()) {
      return (data != null ? _i12.MatchStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.ScheduledMatch?>()) {
      return (data != null ? _i13.ScheduledMatch.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.SkillLevel?>()) {
      return (data != null ? _i14.SkillLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Sport?>()) {
      return (data != null ? _i15.Sport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.Standing?>()) {
      return (data != null ? _i16.Standing.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.MembershipStatus?>()) {
      return (data != null ? _i17.MembershipStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.Team?>()) {
      return (data != null ? _i18.Team.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.TeamMemberRole?>()) {
      return (data != null ? _i19.TeamMemberRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.TeamMembership?>()) {
      return (data != null ? _i20.TeamMembership.fromJson(data) : null) as T;
    }
    if (t == List<_i13.ScheduledMatch>) {
      return (data as List)
              .map((e) => deserialize<_i13.ScheduledMatch>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i13.ScheduledMatch>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i13.ScheduledMatch>(e))
                    .toList()
              : null)
          as T;
    }
    try {
      return _i21.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i22.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Event => 'Event',
      _i3.EventRegistration => 'EventRegistration',
      _i4.EventRegistrationStatus => 'EventRegistrationStatus',
      _i5.EventStatus => 'EventStatus',
      _i6.Greeting => 'Greeting',
      _i7.League => 'League',
      _i8.LeagueStatus => 'LeagueStatus',
      _i9.OrgMemberRole => 'OrgMemberRole',
      _i10.Organization => 'Organization',
      _i11.OrganizationMember => 'OrganizationMember',
      _i12.MatchStatus => 'MatchStatus',
      _i13.ScheduledMatch => 'ScheduledMatch',
      _i14.SkillLevel => 'SkillLevel',
      _i15.Sport => 'Sport',
      _i16.Standing => 'Standing',
      _i17.MembershipStatus => 'MembershipStatus',
      _i18.Team => 'Team',
      _i19.TeamMemberRole => 'TeamMemberRole',
      _i20.TeamMembership => 'TeamMembership',
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
      case _i2.Event():
        return 'Event';
      case _i3.EventRegistration():
        return 'EventRegistration';
      case _i4.EventRegistrationStatus():
        return 'EventRegistrationStatus';
      case _i5.EventStatus():
        return 'EventStatus';
      case _i6.Greeting():
        return 'Greeting';
      case _i7.League():
        return 'League';
      case _i8.LeagueStatus():
        return 'LeagueStatus';
      case _i9.OrgMemberRole():
        return 'OrgMemberRole';
      case _i10.Organization():
        return 'Organization';
      case _i11.OrganizationMember():
        return 'OrganizationMember';
      case _i12.MatchStatus():
        return 'MatchStatus';
      case _i13.ScheduledMatch():
        return 'ScheduledMatch';
      case _i14.SkillLevel():
        return 'SkillLevel';
      case _i15.Sport():
        return 'Sport';
      case _i16.Standing():
        return 'Standing';
      case _i17.MembershipStatus():
        return 'MembershipStatus';
      case _i18.Team():
        return 'Team';
      case _i19.TeamMemberRole():
        return 'TeamMemberRole';
      case _i20.TeamMembership():
        return 'TeamMembership';
    }
    className = _i21.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    className = _i22.Protocol().getClassNameForObject(data);
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
      return deserialize<_i2.Event>(data['data']);
    }
    if (dataClassName == 'EventRegistration') {
      return deserialize<_i3.EventRegistration>(data['data']);
    }
    if (dataClassName == 'EventRegistrationStatus') {
      return deserialize<_i4.EventRegistrationStatus>(data['data']);
    }
    if (dataClassName == 'EventStatus') {
      return deserialize<_i5.EventStatus>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i6.Greeting>(data['data']);
    }
    if (dataClassName == 'League') {
      return deserialize<_i7.League>(data['data']);
    }
    if (dataClassName == 'LeagueStatus') {
      return deserialize<_i8.LeagueStatus>(data['data']);
    }
    if (dataClassName == 'OrgMemberRole') {
      return deserialize<_i9.OrgMemberRole>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i10.Organization>(data['data']);
    }
    if (dataClassName == 'OrganizationMember') {
      return deserialize<_i11.OrganizationMember>(data['data']);
    }
    if (dataClassName == 'MatchStatus') {
      return deserialize<_i12.MatchStatus>(data['data']);
    }
    if (dataClassName == 'ScheduledMatch') {
      return deserialize<_i13.ScheduledMatch>(data['data']);
    }
    if (dataClassName == 'SkillLevel') {
      return deserialize<_i14.SkillLevel>(data['data']);
    }
    if (dataClassName == 'Sport') {
      return deserialize<_i15.Sport>(data['data']);
    }
    if (dataClassName == 'Standing') {
      return deserialize<_i16.Standing>(data['data']);
    }
    if (dataClassName == 'MembershipStatus') {
      return deserialize<_i17.MembershipStatus>(data['data']);
    }
    if (dataClassName == 'Team') {
      return deserialize<_i18.Team>(data['data']);
    }
    if (dataClassName == 'TeamMemberRole') {
      return deserialize<_i19.TeamMemberRole>(data['data']);
    }
    if (dataClassName == 'TeamMembership') {
      return deserialize<_i20.TeamMembership>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i21.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i22.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

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
      return _i21.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i22.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
