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
import 'leagues/models/league_activation_not_allowed_exception.dart' as _i8;
import 'leagues/models/league_not_found_exception.dart' as _i9;
import 'leagues/models/league_slug_taken_exception.dart' as _i10;
import 'leagues/models/league_status.dart' as _i11;
import 'organizations/models/org_member_role.dart' as _i12;
import 'organizations/models/organization.dart' as _i13;
import 'organizations/models/organization_access_denied_exception.dart' as _i14;
import 'organizations/models/organization_member.dart' as _i15;
import 'organizations/models/organization_membership.dart' as _i16;
import 'organizations/models/organization_slug_taken_exception.dart' as _i17;
import 'scheduling/models/match_status.dart' as _i18;
import 'scheduling/models/scheduled_match.dart' as _i19;
import 'sports/models/skill_level.dart' as _i20;
import 'sports/models/sport.dart' as _i21;
import 'standings/models/standing.dart' as _i22;
import 'teams/models/membership_status.dart' as _i23;
import 'teams/models/player_not_found_exception.dart' as _i24;
import 'teams/models/team.dart' as _i25;
import 'teams/models/team_member_role.dart' as _i26;
import 'teams/models/team_membership.dart' as _i27;
import 'teams/models/team_membership_access_denied_exception.dart' as _i28;
import 'teams/models/team_membership_action_not_allowed_exception.dart' as _i29;
import 'teams/models/team_membership_already_exists_exception.dart' as _i30;
import 'teams/models/team_membership_not_found_exception.dart' as _i31;
import 'teams/models/team_not_found_exception.dart' as _i32;
import 'package:bgs_client/src/protocol/leagues/models/league.dart' as _i33;
import 'package:bgs_client/src/protocol/organizations/models/organization_membership.dart'
    as _i34;
import 'package:bgs_client/src/protocol/teams/models/team.dart' as _i35;
import 'package:bgs_client/src/protocol/teams/models/team_membership.dart'
    as _i36;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i37;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i38;
export 'events/models/event.dart';
export 'events/models/event_registration.dart';
export 'events/models/event_registration_status.dart';
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
export 'scheduling/models/match_status.dart';
export 'scheduling/models/scheduled_match.dart';
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
    if (t == _i8.LeagueActivationNotAllowedException) {
      return _i8.LeagueActivationNotAllowedException.fromJson(data) as T;
    }
    if (t == _i9.LeagueNotFoundException) {
      return _i9.LeagueNotFoundException.fromJson(data) as T;
    }
    if (t == _i10.LeagueSlugTakenException) {
      return _i10.LeagueSlugTakenException.fromJson(data) as T;
    }
    if (t == _i11.LeagueStatus) {
      return _i11.LeagueStatus.fromJson(data) as T;
    }
    if (t == _i12.OrgMemberRole) {
      return _i12.OrgMemberRole.fromJson(data) as T;
    }
    if (t == _i13.Organization) {
      return _i13.Organization.fromJson(data) as T;
    }
    if (t == _i14.OrganizationAccessDeniedException) {
      return _i14.OrganizationAccessDeniedException.fromJson(data) as T;
    }
    if (t == _i15.OrganizationMember) {
      return _i15.OrganizationMember.fromJson(data) as T;
    }
    if (t == _i16.OrganizationMembership) {
      return _i16.OrganizationMembership.fromJson(data) as T;
    }
    if (t == _i17.OrganizationSlugTakenException) {
      return _i17.OrganizationSlugTakenException.fromJson(data) as T;
    }
    if (t == _i18.MatchStatus) {
      return _i18.MatchStatus.fromJson(data) as T;
    }
    if (t == _i19.ScheduledMatch) {
      return _i19.ScheduledMatch.fromJson(data) as T;
    }
    if (t == _i20.SkillLevel) {
      return _i20.SkillLevel.fromJson(data) as T;
    }
    if (t == _i21.Sport) {
      return _i21.Sport.fromJson(data) as T;
    }
    if (t == _i22.Standing) {
      return _i22.Standing.fromJson(data) as T;
    }
    if (t == _i23.MembershipStatus) {
      return _i23.MembershipStatus.fromJson(data) as T;
    }
    if (t == _i24.PlayerNotFoundException) {
      return _i24.PlayerNotFoundException.fromJson(data) as T;
    }
    if (t == _i25.Team) {
      return _i25.Team.fromJson(data) as T;
    }
    if (t == _i26.TeamMemberRole) {
      return _i26.TeamMemberRole.fromJson(data) as T;
    }
    if (t == _i27.TeamMembership) {
      return _i27.TeamMembership.fromJson(data) as T;
    }
    if (t == _i28.TeamMembershipAccessDeniedException) {
      return _i28.TeamMembershipAccessDeniedException.fromJson(data) as T;
    }
    if (t == _i29.TeamMembershipActionNotAllowedException) {
      return _i29.TeamMembershipActionNotAllowedException.fromJson(data) as T;
    }
    if (t == _i30.TeamMembershipAlreadyExistsException) {
      return _i30.TeamMembershipAlreadyExistsException.fromJson(data) as T;
    }
    if (t == _i31.TeamMembershipNotFoundException) {
      return _i31.TeamMembershipNotFoundException.fromJson(data) as T;
    }
    if (t == _i32.TeamNotFoundException) {
      return _i32.TeamNotFoundException.fromJson(data) as T;
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
    if (t == _i1.getType<_i8.LeagueActivationNotAllowedException?>()) {
      return (data != null
              ? _i8.LeagueActivationNotAllowedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i9.LeagueNotFoundException?>()) {
      return (data != null ? _i9.LeagueNotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.LeagueSlugTakenException?>()) {
      return (data != null
              ? _i10.LeagueSlugTakenException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i11.LeagueStatus?>()) {
      return (data != null ? _i11.LeagueStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.OrgMemberRole?>()) {
      return (data != null ? _i12.OrgMemberRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.Organization?>()) {
      return (data != null ? _i13.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.OrganizationAccessDeniedException?>()) {
      return (data != null
              ? _i14.OrganizationAccessDeniedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i15.OrganizationMember?>()) {
      return (data != null ? _i15.OrganizationMember.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.OrganizationMembership?>()) {
      return (data != null ? _i16.OrganizationMembership.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.OrganizationSlugTakenException?>()) {
      return (data != null
              ? _i17.OrganizationSlugTakenException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i18.MatchStatus?>()) {
      return (data != null ? _i18.MatchStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.ScheduledMatch?>()) {
      return (data != null ? _i19.ScheduledMatch.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.SkillLevel?>()) {
      return (data != null ? _i20.SkillLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.Sport?>()) {
      return (data != null ? _i21.Sport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.Standing?>()) {
      return (data != null ? _i22.Standing.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.MembershipStatus?>()) {
      return (data != null ? _i23.MembershipStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.PlayerNotFoundException?>()) {
      return (data != null ? _i24.PlayerNotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.Team?>()) {
      return (data != null ? _i25.Team.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.TeamMemberRole?>()) {
      return (data != null ? _i26.TeamMemberRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.TeamMembership?>()) {
      return (data != null ? _i27.TeamMembership.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.TeamMembershipAccessDeniedException?>()) {
      return (data != null
              ? _i28.TeamMembershipAccessDeniedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i29.TeamMembershipActionNotAllowedException?>()) {
      return (data != null
              ? _i29.TeamMembershipActionNotAllowedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i30.TeamMembershipAlreadyExistsException?>()) {
      return (data != null
              ? _i30.TeamMembershipAlreadyExistsException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i31.TeamMembershipNotFoundException?>()) {
      return (data != null
              ? _i31.TeamMembershipNotFoundException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i32.TeamNotFoundException?>()) {
      return (data != null ? _i32.TeamNotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == List<_i19.ScheduledMatch>) {
      return (data as List)
              .map((e) => deserialize<_i19.ScheduledMatch>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i19.ScheduledMatch>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i19.ScheduledMatch>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i33.League>) {
      return (data as List).map((e) => deserialize<_i33.League>(e)).toList()
          as T;
    }
    if (t == List<_i34.OrganizationMembership>) {
      return (data as List)
              .map((e) => deserialize<_i34.OrganizationMembership>(e))
              .toList()
          as T;
    }
    if (t == List<_i35.Team>) {
      return (data as List).map((e) => deserialize<_i35.Team>(e)).toList() as T;
    }
    if (t == List<_i36.TeamMembership>) {
      return (data as List)
              .map((e) => deserialize<_i36.TeamMembership>(e))
              .toList()
          as T;
    }
    try {
      return _i37.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i38.Protocol().deserialize<T>(data, t);
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
      _i8.LeagueActivationNotAllowedException =>
        'LeagueActivationNotAllowedException',
      _i9.LeagueNotFoundException => 'LeagueNotFoundException',
      _i10.LeagueSlugTakenException => 'LeagueSlugTakenException',
      _i11.LeagueStatus => 'LeagueStatus',
      _i12.OrgMemberRole => 'OrgMemberRole',
      _i13.Organization => 'Organization',
      _i14.OrganizationAccessDeniedException =>
        'OrganizationAccessDeniedException',
      _i15.OrganizationMember => 'OrganizationMember',
      _i16.OrganizationMembership => 'OrganizationMembership',
      _i17.OrganizationSlugTakenException => 'OrganizationSlugTakenException',
      _i18.MatchStatus => 'MatchStatus',
      _i19.ScheduledMatch => 'ScheduledMatch',
      _i20.SkillLevel => 'SkillLevel',
      _i21.Sport => 'Sport',
      _i22.Standing => 'Standing',
      _i23.MembershipStatus => 'MembershipStatus',
      _i24.PlayerNotFoundException => 'PlayerNotFoundException',
      _i25.Team => 'Team',
      _i26.TeamMemberRole => 'TeamMemberRole',
      _i27.TeamMembership => 'TeamMembership',
      _i28.TeamMembershipAccessDeniedException =>
        'TeamMembershipAccessDeniedException',
      _i29.TeamMembershipActionNotAllowedException =>
        'TeamMembershipActionNotAllowedException',
      _i30.TeamMembershipAlreadyExistsException =>
        'TeamMembershipAlreadyExistsException',
      _i31.TeamMembershipNotFoundException => 'TeamMembershipNotFoundException',
      _i32.TeamNotFoundException => 'TeamNotFoundException',
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
      case _i8.LeagueActivationNotAllowedException():
        return 'LeagueActivationNotAllowedException';
      case _i9.LeagueNotFoundException():
        return 'LeagueNotFoundException';
      case _i10.LeagueSlugTakenException():
        return 'LeagueSlugTakenException';
      case _i11.LeagueStatus():
        return 'LeagueStatus';
      case _i12.OrgMemberRole():
        return 'OrgMemberRole';
      case _i13.Organization():
        return 'Organization';
      case _i14.OrganizationAccessDeniedException():
        return 'OrganizationAccessDeniedException';
      case _i15.OrganizationMember():
        return 'OrganizationMember';
      case _i16.OrganizationMembership():
        return 'OrganizationMembership';
      case _i17.OrganizationSlugTakenException():
        return 'OrganizationSlugTakenException';
      case _i18.MatchStatus():
        return 'MatchStatus';
      case _i19.ScheduledMatch():
        return 'ScheduledMatch';
      case _i20.SkillLevel():
        return 'SkillLevel';
      case _i21.Sport():
        return 'Sport';
      case _i22.Standing():
        return 'Standing';
      case _i23.MembershipStatus():
        return 'MembershipStatus';
      case _i24.PlayerNotFoundException():
        return 'PlayerNotFoundException';
      case _i25.Team():
        return 'Team';
      case _i26.TeamMemberRole():
        return 'TeamMemberRole';
      case _i27.TeamMembership():
        return 'TeamMembership';
      case _i28.TeamMembershipAccessDeniedException():
        return 'TeamMembershipAccessDeniedException';
      case _i29.TeamMembershipActionNotAllowedException():
        return 'TeamMembershipActionNotAllowedException';
      case _i30.TeamMembershipAlreadyExistsException():
        return 'TeamMembershipAlreadyExistsException';
      case _i31.TeamMembershipNotFoundException():
        return 'TeamMembershipNotFoundException';
      case _i32.TeamNotFoundException():
        return 'TeamNotFoundException';
    }
    className = _i37.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    className = _i38.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'LeagueActivationNotAllowedException') {
      return deserialize<_i8.LeagueActivationNotAllowedException>(data['data']);
    }
    if (dataClassName == 'LeagueNotFoundException') {
      return deserialize<_i9.LeagueNotFoundException>(data['data']);
    }
    if (dataClassName == 'LeagueSlugTakenException') {
      return deserialize<_i10.LeagueSlugTakenException>(data['data']);
    }
    if (dataClassName == 'LeagueStatus') {
      return deserialize<_i11.LeagueStatus>(data['data']);
    }
    if (dataClassName == 'OrgMemberRole') {
      return deserialize<_i12.OrgMemberRole>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i13.Organization>(data['data']);
    }
    if (dataClassName == 'OrganizationAccessDeniedException') {
      return deserialize<_i14.OrganizationAccessDeniedException>(data['data']);
    }
    if (dataClassName == 'OrganizationMember') {
      return deserialize<_i15.OrganizationMember>(data['data']);
    }
    if (dataClassName == 'OrganizationMembership') {
      return deserialize<_i16.OrganizationMembership>(data['data']);
    }
    if (dataClassName == 'OrganizationSlugTakenException') {
      return deserialize<_i17.OrganizationSlugTakenException>(data['data']);
    }
    if (dataClassName == 'MatchStatus') {
      return deserialize<_i18.MatchStatus>(data['data']);
    }
    if (dataClassName == 'ScheduledMatch') {
      return deserialize<_i19.ScheduledMatch>(data['data']);
    }
    if (dataClassName == 'SkillLevel') {
      return deserialize<_i20.SkillLevel>(data['data']);
    }
    if (dataClassName == 'Sport') {
      return deserialize<_i21.Sport>(data['data']);
    }
    if (dataClassName == 'Standing') {
      return deserialize<_i22.Standing>(data['data']);
    }
    if (dataClassName == 'MembershipStatus') {
      return deserialize<_i23.MembershipStatus>(data['data']);
    }
    if (dataClassName == 'PlayerNotFoundException') {
      return deserialize<_i24.PlayerNotFoundException>(data['data']);
    }
    if (dataClassName == 'Team') {
      return deserialize<_i25.Team>(data['data']);
    }
    if (dataClassName == 'TeamMemberRole') {
      return deserialize<_i26.TeamMemberRole>(data['data']);
    }
    if (dataClassName == 'TeamMembership') {
      return deserialize<_i27.TeamMembership>(data['data']);
    }
    if (dataClassName == 'TeamMembershipAccessDeniedException') {
      return deserialize<_i28.TeamMembershipAccessDeniedException>(
        data['data'],
      );
    }
    if (dataClassName == 'TeamMembershipActionNotAllowedException') {
      return deserialize<_i29.TeamMembershipActionNotAllowedException>(
        data['data'],
      );
    }
    if (dataClassName == 'TeamMembershipAlreadyExistsException') {
      return deserialize<_i30.TeamMembershipAlreadyExistsException>(
        data['data'],
      );
    }
    if (dataClassName == 'TeamMembershipNotFoundException') {
      return deserialize<_i31.TeamMembershipNotFoundException>(data['data']);
    }
    if (dataClassName == 'TeamNotFoundException') {
      return deserialize<_i32.TeamNotFoundException>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i37.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i38.Protocol().deserializeByClassName(data);
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
      return _i37.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i38.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
