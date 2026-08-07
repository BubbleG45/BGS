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
import '../../scheduling/models/scheduled_match.dart' as _i2;
import '../../teams/models/team_membership.dart' as _i3;
import '../../scheduling/models/attendance_status.dart' as _i4;
import 'package:bgs_client/src/protocol/protocol.dart' as _i5;

/// Whether a specific roster member (by [TeamMembership], not directly by
/// user -- so a record is naturally scoped to one team's roster) was
/// present or absent for a [ScheduledMatch]. Lightweight v1: recorded
/// after the fact by whoever manages the team, not a player-facing RSVP
/// (see BUILD_PLAN.md for that deferred feature).
abstract class MatchAttendance implements _i1.SerializableModel {
  MatchAttendance._({
    this.id,
    required this.matchId,
    this.match,
    required this.teamMembershipId,
    this.teamMembership,
    required this.status,
    DateTime? recordedAt,
  }) : recordedAt = recordedAt ?? DateTime.now();

  factory MatchAttendance({
    _i1.UuidValue? id,
    required _i1.UuidValue matchId,
    _i2.ScheduledMatch? match,
    required _i1.UuidValue teamMembershipId,
    _i3.TeamMembership? teamMembership,
    required _i4.AttendanceStatus status,
    DateTime? recordedAt,
  }) = _MatchAttendanceImpl;

  factory MatchAttendance.fromJson(Map<String, dynamic> jsonSerialization) {
    return MatchAttendance(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      matchId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['matchId'],
      ),
      match: jsonSerialization['match'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.ScheduledMatch>(
              jsonSerialization['match'],
            ),
      teamMembershipId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['teamMembershipId'],
      ),
      teamMembership: jsonSerialization['teamMembership'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.TeamMembership>(
              jsonSerialization['teamMembership'],
            ),
      status: _i4.AttendanceStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      recordedAt: jsonSerialization['recordedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['recordedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue matchId;

  _i2.ScheduledMatch? match;

  _i1.UuidValue teamMembershipId;

  _i3.TeamMembership? teamMembership;

  _i4.AttendanceStatus status;

  DateTime recordedAt;

  /// Returns a shallow copy of this [MatchAttendance]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MatchAttendance copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? matchId,
    _i2.ScheduledMatch? match,
    _i1.UuidValue? teamMembershipId,
    _i3.TeamMembership? teamMembership,
    _i4.AttendanceStatus? status,
    DateTime? recordedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MatchAttendance',
      if (id != null) 'id': id?.toJson(),
      'matchId': matchId.toJson(),
      if (match != null) 'match': match?.toJson(),
      'teamMembershipId': teamMembershipId.toJson(),
      if (teamMembership != null) 'teamMembership': teamMembership?.toJson(),
      'status': status.toJson(),
      'recordedAt': recordedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MatchAttendanceImpl extends MatchAttendance {
  _MatchAttendanceImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue matchId,
    _i2.ScheduledMatch? match,
    required _i1.UuidValue teamMembershipId,
    _i3.TeamMembership? teamMembership,
    required _i4.AttendanceStatus status,
    DateTime? recordedAt,
  }) : super._(
         id: id,
         matchId: matchId,
         match: match,
         teamMembershipId: teamMembershipId,
         teamMembership: teamMembership,
         status: status,
         recordedAt: recordedAt,
       );

  /// Returns a shallow copy of this [MatchAttendance]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MatchAttendance copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? matchId,
    Object? match = _Undefined,
    _i1.UuidValue? teamMembershipId,
    Object? teamMembership = _Undefined,
    _i4.AttendanceStatus? status,
    DateTime? recordedAt,
  }) {
    return MatchAttendance(
      id: id is _i1.UuidValue? ? id : this.id,
      matchId: matchId ?? this.matchId,
      match: match is _i2.ScheduledMatch? ? match : this.match?.copyWith(),
      teamMembershipId: teamMembershipId ?? this.teamMembershipId,
      teamMembership: teamMembership is _i3.TeamMembership?
          ? teamMembership
          : this.teamMembership?.copyWith(),
      status: status ?? this.status,
      recordedAt: recordedAt ?? this.recordedAt,
    );
  }
}
