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
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i2;
import 'package:bgs_client/src/protocol/protocol.dart' as _i3;

/// BGS-owned profile extension -- `UserProfile` itself belongs to the auth
/// module and can't have fields added to it directly. One row per user,
/// created lazily on first write. Also the natural future home for
/// per-sport positions once that gets designed (see BUILD_PLAN.md).
abstract class PlayerProfile implements _i1.SerializableModel {
  PlayerProfile._({
    this.id,
    required this.authUserId,
    this.authUser,
    this.bio,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  factory PlayerProfile({
    _i1.UuidValue? id,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    String? bio,
    DateTime? updatedAt,
  }) = _PlayerProfileImpl;

  factory PlayerProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlayerProfile(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.AuthUser>(
              jsonSerialization['authUser'],
            ),
      bio: jsonSerialization['bio'] as String?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue authUserId;

  _i2.AuthUser? authUser;

  String? bio;

  DateTime updatedAt;

  /// Returns a shallow copy of this [PlayerProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlayerProfile copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? authUserId,
    _i2.AuthUser? authUser,
    String? bio,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlayerProfile',
      if (id != null) 'id': id?.toJson(),
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      if (bio != null) 'bio': bio,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlayerProfileImpl extends PlayerProfile {
  _PlayerProfileImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    String? bio,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         bio: bio,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [PlayerProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlayerProfile copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? authUserId,
    Object? authUser = _Undefined,
    Object? bio = _Undefined,
    DateTime? updatedAt,
  }) {
    return PlayerProfile(
      id: id is _i1.UuidValue? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _i2.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      bio: bio is String? ? bio : this.bio,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
