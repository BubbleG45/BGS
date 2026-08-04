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
import '../../teams/models/team_membership.dart' as _i2;
import '../../events/models/event_registration.dart' as _i3;
import '../../scheduling/models/scheduled_match.dart' as _i4;
import 'package:bgs_client/src/protocol/protocol.dart' as _i5;

/// Aggregated data for the Player Dashboard -- "my teams/events". Pure
/// read composition over TeamMembership/EventRegistration/ScheduledMatch;
/// no new source-of-truth data lives here. Transient (no `table:`).
abstract class PlayerDashboard implements _i1.SerializableModel {
  PlayerDashboard._({
    required this.teamMemberships,
    required this.eventRegistrations,
    required this.upcomingMatches,
  });

  factory PlayerDashboard({
    required List<_i2.TeamMembership> teamMemberships,
    required List<_i3.EventRegistration> eventRegistrations,
    required List<_i4.ScheduledMatch> upcomingMatches,
  }) = _PlayerDashboardImpl;

  factory PlayerDashboard.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlayerDashboard(
      teamMemberships: _i5.Protocol().deserialize<List<_i2.TeamMembership>>(
        jsonSerialization['teamMemberships'],
      ),
      eventRegistrations: _i5.Protocol()
          .deserialize<List<_i3.EventRegistration>>(
            jsonSerialization['eventRegistrations'],
          ),
      upcomingMatches: _i5.Protocol().deserialize<List<_i4.ScheduledMatch>>(
        jsonSerialization['upcomingMatches'],
      ),
    );
  }

  List<_i2.TeamMembership> teamMemberships;

  List<_i3.EventRegistration> eventRegistrations;

  /// Scheduled (not yet played) matches for teams the player is actively
  /// on, soonest first.
  List<_i4.ScheduledMatch> upcomingMatches;

  /// Returns a shallow copy of this [PlayerDashboard]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlayerDashboard copyWith({
    List<_i2.TeamMembership>? teamMemberships,
    List<_i3.EventRegistration>? eventRegistrations,
    List<_i4.ScheduledMatch>? upcomingMatches,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlayerDashboard',
      'teamMemberships': teamMemberships.toJson(valueToJson: (v) => v.toJson()),
      'eventRegistrations': eventRegistrations.toJson(
        valueToJson: (v) => v.toJson(),
      ),
      'upcomingMatches': upcomingMatches.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _PlayerDashboardImpl extends PlayerDashboard {
  _PlayerDashboardImpl({
    required List<_i2.TeamMembership> teamMemberships,
    required List<_i3.EventRegistration> eventRegistrations,
    required List<_i4.ScheduledMatch> upcomingMatches,
  }) : super._(
         teamMemberships: teamMemberships,
         eventRegistrations: eventRegistrations,
         upcomingMatches: upcomingMatches,
       );

  /// Returns a shallow copy of this [PlayerDashboard]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlayerDashboard copyWith({
    List<_i2.TeamMembership>? teamMemberships,
    List<_i3.EventRegistration>? eventRegistrations,
    List<_i4.ScheduledMatch>? upcomingMatches,
  }) {
    return PlayerDashboard(
      teamMemberships:
          teamMemberships ??
          this.teamMemberships.map((e0) => e0.copyWith()).toList(),
      eventRegistrations:
          eventRegistrations ??
          this.eventRegistrations.map((e0) => e0.copyWith()).toList(),
      upcomingMatches:
          upcomingMatches ??
          this.upcomingMatches.map((e0) => e0.copyWith()).toList(),
    );
  }
}
