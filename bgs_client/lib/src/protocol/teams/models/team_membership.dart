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
import '../../teams/models/team_member_role.dart' as _i2;
import '../../teams/models/membership_status.dart' as _i3;
import '../../teams/models/team.dart' as _i4;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i5;
import 'package:bgs_client/src/protocol/protocol.dart' as _i6;

/// Links an [AuthUser] to a [Team]. This is how the "Player" and "Manager"
/// roles/dashboards are determined -- there is no standalone role flag on
/// the user, it's derived from having a row here.
abstract class TeamMembership implements _i1.SerializableModel {
  TeamMembership._({
    this.id,
    required this.teamId,
    this.team,
    required this.authUserId,
    this.authUser,
    _i2.TeamMemberRole? role,
    _i3.MembershipStatus? status,
    DateTime? invitedAt,
    this.joinedAt,
  }) : role = role ?? _i2.TeamMemberRole.player,
       status = status ?? _i3.MembershipStatus.invited,
       invitedAt = invitedAt ?? DateTime.now();

  factory TeamMembership({
    _i1.UuidValue? id,
    required _i1.UuidValue teamId,
    _i4.Team? team,
    required _i1.UuidValue authUserId,
    _i5.AuthUser? authUser,
    _i2.TeamMemberRole? role,
    _i3.MembershipStatus? status,
    DateTime? invitedAt,
    DateTime? joinedAt,
  }) = _TeamMembershipImpl;

  factory TeamMembership.fromJson(Map<String, dynamic> jsonSerialization) {
    return TeamMembership(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      teamId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['teamId']),
      team: jsonSerialization['team'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.Team>(jsonSerialization['team']),
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.AuthUser>(
              jsonSerialization['authUser'],
            ),
      role: jsonSerialization['role'] == null
          ? null
          : _i2.TeamMemberRole.fromJson((jsonSerialization['role'] as String)),
      status: jsonSerialization['status'] == null
          ? null
          : _i3.MembershipStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      invitedAt: jsonSerialization['invitedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['invitedAt']),
      joinedAt: jsonSerialization['joinedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['joinedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue teamId;

  _i4.Team? team;

  _i1.UuidValue authUserId;

  _i5.AuthUser? authUser;

  _i2.TeamMemberRole role;

  _i3.MembershipStatus status;

  DateTime invitedAt;

  DateTime? joinedAt;

  /// Returns a shallow copy of this [TeamMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TeamMembership copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? teamId,
    _i4.Team? team,
    _i1.UuidValue? authUserId,
    _i5.AuthUser? authUser,
    _i2.TeamMemberRole? role,
    _i3.MembershipStatus? status,
    DateTime? invitedAt,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TeamMembership',
      if (id != null) 'id': id?.toJson(),
      'teamId': teamId.toJson(),
      if (team != null) 'team': team?.toJson(),
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'role': role.toJson(),
      'status': status.toJson(),
      'invitedAt': invitedAt.toJson(),
      if (joinedAt != null) 'joinedAt': joinedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TeamMembershipImpl extends TeamMembership {
  _TeamMembershipImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue teamId,
    _i4.Team? team,
    required _i1.UuidValue authUserId,
    _i5.AuthUser? authUser,
    _i2.TeamMemberRole? role,
    _i3.MembershipStatus? status,
    DateTime? invitedAt,
    DateTime? joinedAt,
  }) : super._(
         id: id,
         teamId: teamId,
         team: team,
         authUserId: authUserId,
         authUser: authUser,
         role: role,
         status: status,
         invitedAt: invitedAt,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [TeamMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TeamMembership copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? teamId,
    Object? team = _Undefined,
    _i1.UuidValue? authUserId,
    Object? authUser = _Undefined,
    _i2.TeamMemberRole? role,
    _i3.MembershipStatus? status,
    DateTime? invitedAt,
    Object? joinedAt = _Undefined,
  }) {
    return TeamMembership(
      id: id is _i1.UuidValue? ? id : this.id,
      teamId: teamId ?? this.teamId,
      team: team is _i4.Team? ? team : this.team?.copyWith(),
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _i5.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      role: role ?? this.role,
      status: status ?? this.status,
      invitedAt: invitedAt ?? this.invitedAt,
      joinedAt: joinedAt is DateTime? ? joinedAt : this.joinedAt,
    );
  }
}
