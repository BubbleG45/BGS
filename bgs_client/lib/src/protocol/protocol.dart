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
import 'events/models/event_access_denied_exception.dart' as _i3;
import 'events/models/event_not_found_exception.dart' as _i4;
import 'events/models/event_not_open_for_registration_exception.dart' as _i5;
import 'events/models/event_publish_not_allowed_exception.dart' as _i6;
import 'events/models/event_registration.dart' as _i7;
import 'events/models/event_registration_access_denied_exception.dart' as _i8;
import 'events/models/event_registration_action_not_allowed_exception.dart'
    as _i9;
import 'events/models/event_registration_already_exists_exception.dart' as _i10;
import 'events/models/event_registration_not_found_exception.dart' as _i11;
import 'events/models/event_registration_status.dart' as _i12;
import 'events/models/event_slug_taken_exception.dart' as _i13;
import 'events/models/event_status.dart' as _i14;
import 'greetings/greeting.dart' as _i15;
import 'leagues/models/league.dart' as _i16;
import 'leagues/models/league_activation_not_allowed_exception.dart' as _i17;
import 'leagues/models/league_not_found_exception.dart' as _i18;
import 'leagues/models/league_slug_taken_exception.dart' as _i19;
import 'leagues/models/league_status.dart' as _i20;
import 'organizations/models/org_member_role.dart' as _i21;
import 'organizations/models/organization.dart' as _i22;
import 'organizations/models/organization_access_denied_exception.dart' as _i23;
import 'organizations/models/organization_member.dart' as _i24;
import 'organizations/models/organization_membership.dart' as _i25;
import 'organizations/models/organization_slug_taken_exception.dart' as _i26;
import 'scheduling/models/match_action_not_allowed_exception.dart' as _i27;
import 'scheduling/models/match_status.dart' as _i28;
import 'scheduling/models/same_team_match_exception.dart' as _i29;
import 'scheduling/models/scheduled_match.dart' as _i30;
import 'scheduling/models/scheduled_match_not_found_exception.dart' as _i31;
import 'scheduling/models/team_not_in_league_exception.dart' as _i32;
import 'sports/models/skill_level.dart' as _i33;
import 'sports/models/sport.dart' as _i34;
import 'standings/models/standing.dart' as _i35;
import 'teams/models/membership_status.dart' as _i36;
import 'teams/models/player_not_found_exception.dart' as _i37;
import 'teams/models/team.dart' as _i38;
import 'teams/models/team_member_role.dart' as _i39;
import 'teams/models/team_membership.dart' as _i40;
import 'teams/models/team_membership_access_denied_exception.dart' as _i41;
import 'teams/models/team_membership_action_not_allowed_exception.dart' as _i42;
import 'teams/models/team_membership_already_exists_exception.dart' as _i43;
import 'teams/models/team_membership_not_found_exception.dart' as _i44;
import 'teams/models/team_not_found_exception.dart' as _i45;
import 'package:bgs_client/src/protocol/events/models/event.dart' as _i46;
import 'package:bgs_client/src/protocol/events/models/event_registration.dart'
    as _i47;
import 'package:bgs_client/src/protocol/leagues/models/league.dart' as _i48;
import 'package:bgs_client/src/protocol/organizations/models/organization_membership.dart'
    as _i49;
import 'package:bgs_client/src/protocol/scheduling/models/scheduled_match.dart'
    as _i50;
import 'package:bgs_client/src/protocol/standings/models/standing.dart' as _i51;
import 'package:bgs_client/src/protocol/teams/models/team.dart' as _i52;
import 'package:bgs_client/src/protocol/teams/models/team_membership.dart'
    as _i53;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i54;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i55;
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
    if (t == _i3.EventAccessDeniedException) {
      return _i3.EventAccessDeniedException.fromJson(data) as T;
    }
    if (t == _i4.EventNotFoundException) {
      return _i4.EventNotFoundException.fromJson(data) as T;
    }
    if (t == _i5.EventNotOpenForRegistrationException) {
      return _i5.EventNotOpenForRegistrationException.fromJson(data) as T;
    }
    if (t == _i6.EventPublishNotAllowedException) {
      return _i6.EventPublishNotAllowedException.fromJson(data) as T;
    }
    if (t == _i7.EventRegistration) {
      return _i7.EventRegistration.fromJson(data) as T;
    }
    if (t == _i8.EventRegistrationAccessDeniedException) {
      return _i8.EventRegistrationAccessDeniedException.fromJson(data) as T;
    }
    if (t == _i9.EventRegistrationActionNotAllowedException) {
      return _i9.EventRegistrationActionNotAllowedException.fromJson(data) as T;
    }
    if (t == _i10.EventRegistrationAlreadyExistsException) {
      return _i10.EventRegistrationAlreadyExistsException.fromJson(data) as T;
    }
    if (t == _i11.EventRegistrationNotFoundException) {
      return _i11.EventRegistrationNotFoundException.fromJson(data) as T;
    }
    if (t == _i12.EventRegistrationStatus) {
      return _i12.EventRegistrationStatus.fromJson(data) as T;
    }
    if (t == _i13.EventSlugTakenException) {
      return _i13.EventSlugTakenException.fromJson(data) as T;
    }
    if (t == _i14.EventStatus) {
      return _i14.EventStatus.fromJson(data) as T;
    }
    if (t == _i15.Greeting) {
      return _i15.Greeting.fromJson(data) as T;
    }
    if (t == _i16.League) {
      return _i16.League.fromJson(data) as T;
    }
    if (t == _i17.LeagueActivationNotAllowedException) {
      return _i17.LeagueActivationNotAllowedException.fromJson(data) as T;
    }
    if (t == _i18.LeagueNotFoundException) {
      return _i18.LeagueNotFoundException.fromJson(data) as T;
    }
    if (t == _i19.LeagueSlugTakenException) {
      return _i19.LeagueSlugTakenException.fromJson(data) as T;
    }
    if (t == _i20.LeagueStatus) {
      return _i20.LeagueStatus.fromJson(data) as T;
    }
    if (t == _i21.OrgMemberRole) {
      return _i21.OrgMemberRole.fromJson(data) as T;
    }
    if (t == _i22.Organization) {
      return _i22.Organization.fromJson(data) as T;
    }
    if (t == _i23.OrganizationAccessDeniedException) {
      return _i23.OrganizationAccessDeniedException.fromJson(data) as T;
    }
    if (t == _i24.OrganizationMember) {
      return _i24.OrganizationMember.fromJson(data) as T;
    }
    if (t == _i25.OrganizationMembership) {
      return _i25.OrganizationMembership.fromJson(data) as T;
    }
    if (t == _i26.OrganizationSlugTakenException) {
      return _i26.OrganizationSlugTakenException.fromJson(data) as T;
    }
    if (t == _i27.MatchActionNotAllowedException) {
      return _i27.MatchActionNotAllowedException.fromJson(data) as T;
    }
    if (t == _i28.MatchStatus) {
      return _i28.MatchStatus.fromJson(data) as T;
    }
    if (t == _i29.SameTeamMatchException) {
      return _i29.SameTeamMatchException.fromJson(data) as T;
    }
    if (t == _i30.ScheduledMatch) {
      return _i30.ScheduledMatch.fromJson(data) as T;
    }
    if (t == _i31.ScheduledMatchNotFoundException) {
      return _i31.ScheduledMatchNotFoundException.fromJson(data) as T;
    }
    if (t == _i32.TeamNotInLeagueException) {
      return _i32.TeamNotInLeagueException.fromJson(data) as T;
    }
    if (t == _i33.SkillLevel) {
      return _i33.SkillLevel.fromJson(data) as T;
    }
    if (t == _i34.Sport) {
      return _i34.Sport.fromJson(data) as T;
    }
    if (t == _i35.Standing) {
      return _i35.Standing.fromJson(data) as T;
    }
    if (t == _i36.MembershipStatus) {
      return _i36.MembershipStatus.fromJson(data) as T;
    }
    if (t == _i37.PlayerNotFoundException) {
      return _i37.PlayerNotFoundException.fromJson(data) as T;
    }
    if (t == _i38.Team) {
      return _i38.Team.fromJson(data) as T;
    }
    if (t == _i39.TeamMemberRole) {
      return _i39.TeamMemberRole.fromJson(data) as T;
    }
    if (t == _i40.TeamMembership) {
      return _i40.TeamMembership.fromJson(data) as T;
    }
    if (t == _i41.TeamMembershipAccessDeniedException) {
      return _i41.TeamMembershipAccessDeniedException.fromJson(data) as T;
    }
    if (t == _i42.TeamMembershipActionNotAllowedException) {
      return _i42.TeamMembershipActionNotAllowedException.fromJson(data) as T;
    }
    if (t == _i43.TeamMembershipAlreadyExistsException) {
      return _i43.TeamMembershipAlreadyExistsException.fromJson(data) as T;
    }
    if (t == _i44.TeamMembershipNotFoundException) {
      return _i44.TeamMembershipNotFoundException.fromJson(data) as T;
    }
    if (t == _i45.TeamNotFoundException) {
      return _i45.TeamNotFoundException.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Event?>()) {
      return (data != null ? _i2.Event.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.EventAccessDeniedException?>()) {
      return (data != null
              ? _i3.EventAccessDeniedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i4.EventNotFoundException?>()) {
      return (data != null ? _i4.EventNotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i5.EventNotOpenForRegistrationException?>()) {
      return (data != null
              ? _i5.EventNotOpenForRegistrationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i6.EventPublishNotAllowedException?>()) {
      return (data != null
              ? _i6.EventPublishNotAllowedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i7.EventRegistration?>()) {
      return (data != null ? _i7.EventRegistration.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.EventRegistrationAccessDeniedException?>()) {
      return (data != null
              ? _i8.EventRegistrationAccessDeniedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i9.EventRegistrationActionNotAllowedException?>()) {
      return (data != null
              ? _i9.EventRegistrationActionNotAllowedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i10.EventRegistrationAlreadyExistsException?>()) {
      return (data != null
              ? _i10.EventRegistrationAlreadyExistsException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i11.EventRegistrationNotFoundException?>()) {
      return (data != null
              ? _i11.EventRegistrationNotFoundException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i12.EventRegistrationStatus?>()) {
      return (data != null ? _i12.EventRegistrationStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.EventSlugTakenException?>()) {
      return (data != null ? _i13.EventSlugTakenException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.EventStatus?>()) {
      return (data != null ? _i14.EventStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Greeting?>()) {
      return (data != null ? _i15.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.League?>()) {
      return (data != null ? _i16.League.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.LeagueActivationNotAllowedException?>()) {
      return (data != null
              ? _i17.LeagueActivationNotAllowedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i18.LeagueNotFoundException?>()) {
      return (data != null ? _i18.LeagueNotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.LeagueSlugTakenException?>()) {
      return (data != null
              ? _i19.LeagueSlugTakenException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i20.LeagueStatus?>()) {
      return (data != null ? _i20.LeagueStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.OrgMemberRole?>()) {
      return (data != null ? _i21.OrgMemberRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.Organization?>()) {
      return (data != null ? _i22.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.OrganizationAccessDeniedException?>()) {
      return (data != null
              ? _i23.OrganizationAccessDeniedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i24.OrganizationMember?>()) {
      return (data != null ? _i24.OrganizationMember.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.OrganizationMembership?>()) {
      return (data != null ? _i25.OrganizationMembership.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.OrganizationSlugTakenException?>()) {
      return (data != null
              ? _i26.OrganizationSlugTakenException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i27.MatchActionNotAllowedException?>()) {
      return (data != null
              ? _i27.MatchActionNotAllowedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i28.MatchStatus?>()) {
      return (data != null ? _i28.MatchStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.SameTeamMatchException?>()) {
      return (data != null ? _i29.SameTeamMatchException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i30.ScheduledMatch?>()) {
      return (data != null ? _i30.ScheduledMatch.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.ScheduledMatchNotFoundException?>()) {
      return (data != null
              ? _i31.ScheduledMatchNotFoundException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i32.TeamNotInLeagueException?>()) {
      return (data != null
              ? _i32.TeamNotInLeagueException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i33.SkillLevel?>()) {
      return (data != null ? _i33.SkillLevel.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.Sport?>()) {
      return (data != null ? _i34.Sport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.Standing?>()) {
      return (data != null ? _i35.Standing.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.MembershipStatus?>()) {
      return (data != null ? _i36.MembershipStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.PlayerNotFoundException?>()) {
      return (data != null ? _i37.PlayerNotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i38.Team?>()) {
      return (data != null ? _i38.Team.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.TeamMemberRole?>()) {
      return (data != null ? _i39.TeamMemberRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.TeamMembership?>()) {
      return (data != null ? _i40.TeamMembership.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.TeamMembershipAccessDeniedException?>()) {
      return (data != null
              ? _i41.TeamMembershipAccessDeniedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i42.TeamMembershipActionNotAllowedException?>()) {
      return (data != null
              ? _i42.TeamMembershipActionNotAllowedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i43.TeamMembershipAlreadyExistsException?>()) {
      return (data != null
              ? _i43.TeamMembershipAlreadyExistsException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i44.TeamMembershipNotFoundException?>()) {
      return (data != null
              ? _i44.TeamMembershipNotFoundException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i45.TeamNotFoundException?>()) {
      return (data != null ? _i45.TeamNotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == List<_i30.ScheduledMatch>) {
      return (data as List)
              .map((e) => deserialize<_i30.ScheduledMatch>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i30.ScheduledMatch>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i30.ScheduledMatch>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i46.Event>) {
      return (data as List).map((e) => deserialize<_i46.Event>(e)).toList()
          as T;
    }
    if (t == List<_i47.EventRegistration>) {
      return (data as List)
              .map((e) => deserialize<_i47.EventRegistration>(e))
              .toList()
          as T;
    }
    if (t == List<_i48.League>) {
      return (data as List).map((e) => deserialize<_i48.League>(e)).toList()
          as T;
    }
    if (t == List<_i49.OrganizationMembership>) {
      return (data as List)
              .map((e) => deserialize<_i49.OrganizationMembership>(e))
              .toList()
          as T;
    }
    if (t == List<_i50.ScheduledMatch>) {
      return (data as List)
              .map((e) => deserialize<_i50.ScheduledMatch>(e))
              .toList()
          as T;
    }
    if (t == List<_i51.Standing>) {
      return (data as List).map((e) => deserialize<_i51.Standing>(e)).toList()
          as T;
    }
    if (t == List<_i52.Team>) {
      return (data as List).map((e) => deserialize<_i52.Team>(e)).toList() as T;
    }
    if (t == List<_i53.TeamMembership>) {
      return (data as List)
              .map((e) => deserialize<_i53.TeamMembership>(e))
              .toList()
          as T;
    }
    try {
      return _i54.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i55.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Event => 'Event',
      _i3.EventAccessDeniedException => 'EventAccessDeniedException',
      _i4.EventNotFoundException => 'EventNotFoundException',
      _i5.EventNotOpenForRegistrationException =>
        'EventNotOpenForRegistrationException',
      _i6.EventPublishNotAllowedException => 'EventPublishNotAllowedException',
      _i7.EventRegistration => 'EventRegistration',
      _i8.EventRegistrationAccessDeniedException =>
        'EventRegistrationAccessDeniedException',
      _i9.EventRegistrationActionNotAllowedException =>
        'EventRegistrationActionNotAllowedException',
      _i10.EventRegistrationAlreadyExistsException =>
        'EventRegistrationAlreadyExistsException',
      _i11.EventRegistrationNotFoundException =>
        'EventRegistrationNotFoundException',
      _i12.EventRegistrationStatus => 'EventRegistrationStatus',
      _i13.EventSlugTakenException => 'EventSlugTakenException',
      _i14.EventStatus => 'EventStatus',
      _i15.Greeting => 'Greeting',
      _i16.League => 'League',
      _i17.LeagueActivationNotAllowedException =>
        'LeagueActivationNotAllowedException',
      _i18.LeagueNotFoundException => 'LeagueNotFoundException',
      _i19.LeagueSlugTakenException => 'LeagueSlugTakenException',
      _i20.LeagueStatus => 'LeagueStatus',
      _i21.OrgMemberRole => 'OrgMemberRole',
      _i22.Organization => 'Organization',
      _i23.OrganizationAccessDeniedException =>
        'OrganizationAccessDeniedException',
      _i24.OrganizationMember => 'OrganizationMember',
      _i25.OrganizationMembership => 'OrganizationMembership',
      _i26.OrganizationSlugTakenException => 'OrganizationSlugTakenException',
      _i27.MatchActionNotAllowedException => 'MatchActionNotAllowedException',
      _i28.MatchStatus => 'MatchStatus',
      _i29.SameTeamMatchException => 'SameTeamMatchException',
      _i30.ScheduledMatch => 'ScheduledMatch',
      _i31.ScheduledMatchNotFoundException => 'ScheduledMatchNotFoundException',
      _i32.TeamNotInLeagueException => 'TeamNotInLeagueException',
      _i33.SkillLevel => 'SkillLevel',
      _i34.Sport => 'Sport',
      _i35.Standing => 'Standing',
      _i36.MembershipStatus => 'MembershipStatus',
      _i37.PlayerNotFoundException => 'PlayerNotFoundException',
      _i38.Team => 'Team',
      _i39.TeamMemberRole => 'TeamMemberRole',
      _i40.TeamMembership => 'TeamMembership',
      _i41.TeamMembershipAccessDeniedException =>
        'TeamMembershipAccessDeniedException',
      _i42.TeamMembershipActionNotAllowedException =>
        'TeamMembershipActionNotAllowedException',
      _i43.TeamMembershipAlreadyExistsException =>
        'TeamMembershipAlreadyExistsException',
      _i44.TeamMembershipNotFoundException => 'TeamMembershipNotFoundException',
      _i45.TeamNotFoundException => 'TeamNotFoundException',
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
      case _i3.EventAccessDeniedException():
        return 'EventAccessDeniedException';
      case _i4.EventNotFoundException():
        return 'EventNotFoundException';
      case _i5.EventNotOpenForRegistrationException():
        return 'EventNotOpenForRegistrationException';
      case _i6.EventPublishNotAllowedException():
        return 'EventPublishNotAllowedException';
      case _i7.EventRegistration():
        return 'EventRegistration';
      case _i8.EventRegistrationAccessDeniedException():
        return 'EventRegistrationAccessDeniedException';
      case _i9.EventRegistrationActionNotAllowedException():
        return 'EventRegistrationActionNotAllowedException';
      case _i10.EventRegistrationAlreadyExistsException():
        return 'EventRegistrationAlreadyExistsException';
      case _i11.EventRegistrationNotFoundException():
        return 'EventRegistrationNotFoundException';
      case _i12.EventRegistrationStatus():
        return 'EventRegistrationStatus';
      case _i13.EventSlugTakenException():
        return 'EventSlugTakenException';
      case _i14.EventStatus():
        return 'EventStatus';
      case _i15.Greeting():
        return 'Greeting';
      case _i16.League():
        return 'League';
      case _i17.LeagueActivationNotAllowedException():
        return 'LeagueActivationNotAllowedException';
      case _i18.LeagueNotFoundException():
        return 'LeagueNotFoundException';
      case _i19.LeagueSlugTakenException():
        return 'LeagueSlugTakenException';
      case _i20.LeagueStatus():
        return 'LeagueStatus';
      case _i21.OrgMemberRole():
        return 'OrgMemberRole';
      case _i22.Organization():
        return 'Organization';
      case _i23.OrganizationAccessDeniedException():
        return 'OrganizationAccessDeniedException';
      case _i24.OrganizationMember():
        return 'OrganizationMember';
      case _i25.OrganizationMembership():
        return 'OrganizationMembership';
      case _i26.OrganizationSlugTakenException():
        return 'OrganizationSlugTakenException';
      case _i27.MatchActionNotAllowedException():
        return 'MatchActionNotAllowedException';
      case _i28.MatchStatus():
        return 'MatchStatus';
      case _i29.SameTeamMatchException():
        return 'SameTeamMatchException';
      case _i30.ScheduledMatch():
        return 'ScheduledMatch';
      case _i31.ScheduledMatchNotFoundException():
        return 'ScheduledMatchNotFoundException';
      case _i32.TeamNotInLeagueException():
        return 'TeamNotInLeagueException';
      case _i33.SkillLevel():
        return 'SkillLevel';
      case _i34.Sport():
        return 'Sport';
      case _i35.Standing():
        return 'Standing';
      case _i36.MembershipStatus():
        return 'MembershipStatus';
      case _i37.PlayerNotFoundException():
        return 'PlayerNotFoundException';
      case _i38.Team():
        return 'Team';
      case _i39.TeamMemberRole():
        return 'TeamMemberRole';
      case _i40.TeamMembership():
        return 'TeamMembership';
      case _i41.TeamMembershipAccessDeniedException():
        return 'TeamMembershipAccessDeniedException';
      case _i42.TeamMembershipActionNotAllowedException():
        return 'TeamMembershipActionNotAllowedException';
      case _i43.TeamMembershipAlreadyExistsException():
        return 'TeamMembershipAlreadyExistsException';
      case _i44.TeamMembershipNotFoundException():
        return 'TeamMembershipNotFoundException';
      case _i45.TeamNotFoundException():
        return 'TeamNotFoundException';
    }
    className = _i54.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    className = _i55.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'EventAccessDeniedException') {
      return deserialize<_i3.EventAccessDeniedException>(data['data']);
    }
    if (dataClassName == 'EventNotFoundException') {
      return deserialize<_i4.EventNotFoundException>(data['data']);
    }
    if (dataClassName == 'EventNotOpenForRegistrationException') {
      return deserialize<_i5.EventNotOpenForRegistrationException>(
        data['data'],
      );
    }
    if (dataClassName == 'EventPublishNotAllowedException') {
      return deserialize<_i6.EventPublishNotAllowedException>(data['data']);
    }
    if (dataClassName == 'EventRegistration') {
      return deserialize<_i7.EventRegistration>(data['data']);
    }
    if (dataClassName == 'EventRegistrationAccessDeniedException') {
      return deserialize<_i8.EventRegistrationAccessDeniedException>(
        data['data'],
      );
    }
    if (dataClassName == 'EventRegistrationActionNotAllowedException') {
      return deserialize<_i9.EventRegistrationActionNotAllowedException>(
        data['data'],
      );
    }
    if (dataClassName == 'EventRegistrationAlreadyExistsException') {
      return deserialize<_i10.EventRegistrationAlreadyExistsException>(
        data['data'],
      );
    }
    if (dataClassName == 'EventRegistrationNotFoundException') {
      return deserialize<_i11.EventRegistrationNotFoundException>(data['data']);
    }
    if (dataClassName == 'EventRegistrationStatus') {
      return deserialize<_i12.EventRegistrationStatus>(data['data']);
    }
    if (dataClassName == 'EventSlugTakenException') {
      return deserialize<_i13.EventSlugTakenException>(data['data']);
    }
    if (dataClassName == 'EventStatus') {
      return deserialize<_i14.EventStatus>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i15.Greeting>(data['data']);
    }
    if (dataClassName == 'League') {
      return deserialize<_i16.League>(data['data']);
    }
    if (dataClassName == 'LeagueActivationNotAllowedException') {
      return deserialize<_i17.LeagueActivationNotAllowedException>(
        data['data'],
      );
    }
    if (dataClassName == 'LeagueNotFoundException') {
      return deserialize<_i18.LeagueNotFoundException>(data['data']);
    }
    if (dataClassName == 'LeagueSlugTakenException') {
      return deserialize<_i19.LeagueSlugTakenException>(data['data']);
    }
    if (dataClassName == 'LeagueStatus') {
      return deserialize<_i20.LeagueStatus>(data['data']);
    }
    if (dataClassName == 'OrgMemberRole') {
      return deserialize<_i21.OrgMemberRole>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i22.Organization>(data['data']);
    }
    if (dataClassName == 'OrganizationAccessDeniedException') {
      return deserialize<_i23.OrganizationAccessDeniedException>(data['data']);
    }
    if (dataClassName == 'OrganizationMember') {
      return deserialize<_i24.OrganizationMember>(data['data']);
    }
    if (dataClassName == 'OrganizationMembership') {
      return deserialize<_i25.OrganizationMembership>(data['data']);
    }
    if (dataClassName == 'OrganizationSlugTakenException') {
      return deserialize<_i26.OrganizationSlugTakenException>(data['data']);
    }
    if (dataClassName == 'MatchActionNotAllowedException') {
      return deserialize<_i27.MatchActionNotAllowedException>(data['data']);
    }
    if (dataClassName == 'MatchStatus') {
      return deserialize<_i28.MatchStatus>(data['data']);
    }
    if (dataClassName == 'SameTeamMatchException') {
      return deserialize<_i29.SameTeamMatchException>(data['data']);
    }
    if (dataClassName == 'ScheduledMatch') {
      return deserialize<_i30.ScheduledMatch>(data['data']);
    }
    if (dataClassName == 'ScheduledMatchNotFoundException') {
      return deserialize<_i31.ScheduledMatchNotFoundException>(data['data']);
    }
    if (dataClassName == 'TeamNotInLeagueException') {
      return deserialize<_i32.TeamNotInLeagueException>(data['data']);
    }
    if (dataClassName == 'SkillLevel') {
      return deserialize<_i33.SkillLevel>(data['data']);
    }
    if (dataClassName == 'Sport') {
      return deserialize<_i34.Sport>(data['data']);
    }
    if (dataClassName == 'Standing') {
      return deserialize<_i35.Standing>(data['data']);
    }
    if (dataClassName == 'MembershipStatus') {
      return deserialize<_i36.MembershipStatus>(data['data']);
    }
    if (dataClassName == 'PlayerNotFoundException') {
      return deserialize<_i37.PlayerNotFoundException>(data['data']);
    }
    if (dataClassName == 'Team') {
      return deserialize<_i38.Team>(data['data']);
    }
    if (dataClassName == 'TeamMemberRole') {
      return deserialize<_i39.TeamMemberRole>(data['data']);
    }
    if (dataClassName == 'TeamMembership') {
      return deserialize<_i40.TeamMembership>(data['data']);
    }
    if (dataClassName == 'TeamMembershipAccessDeniedException') {
      return deserialize<_i41.TeamMembershipAccessDeniedException>(
        data['data'],
      );
    }
    if (dataClassName == 'TeamMembershipActionNotAllowedException') {
      return deserialize<_i42.TeamMembershipActionNotAllowedException>(
        data['data'],
      );
    }
    if (dataClassName == 'TeamMembershipAlreadyExistsException') {
      return deserialize<_i43.TeamMembershipAlreadyExistsException>(
        data['data'],
      );
    }
    if (dataClassName == 'TeamMembershipNotFoundException') {
      return deserialize<_i44.TeamMembershipNotFoundException>(data['data']);
    }
    if (dataClassName == 'TeamNotFoundException') {
      return deserialize<_i45.TeamNotFoundException>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i54.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i55.Protocol().deserializeByClassName(data);
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
      return _i54.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i55.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
