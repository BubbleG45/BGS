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
import '../../organizations/models/organization.dart' as _i2;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i3;
import '../../organizations/models/org_member_role.dart' as _i4;
import 'package:bgs_client/src/protocol/protocol.dart' as _i5;

/// Links an [AuthUser] to an [Organization] with an organizer-side role.
///
/// This is how the "Organizer" role/dashboard is determined -- there is no
/// standalone role flag on the user, it's derived from having a row here.
abstract class OrganizationMember implements _i1.SerializableModel {
  OrganizationMember._({
    this.id,
    required this.organizationId,
    this.organization,
    required this.authUserId,
    this.authUser,
    required this.role,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory OrganizationMember({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    _i2.Organization? organization,
    required _i1.UuidValue authUserId,
    _i3.AuthUser? authUser,
    required _i4.OrgMemberRole role,
    DateTime? createdAt,
  }) = _OrganizationMemberImpl;

  factory OrganizationMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrganizationMember(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizationId'],
      ),
      organization: jsonSerialization['organization'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.AuthUser>(
              jsonSerialization['authUser'],
            ),
      role: _i4.OrgMemberRole.fromJson((jsonSerialization['role'] as String)),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  _i2.Organization? organization;

  _i1.UuidValue authUserId;

  _i3.AuthUser? authUser;

  _i4.OrgMemberRole role;

  DateTime createdAt;

  /// Returns a shallow copy of this [OrganizationMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrganizationMember copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i2.Organization? organization,
    _i1.UuidValue? authUserId,
    _i3.AuthUser? authUser,
    _i4.OrgMemberRole? role,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrganizationMember',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      if (organization != null) 'organization': organization?.toJson(),
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'role': role.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrganizationMemberImpl extends OrganizationMember {
  _OrganizationMemberImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    _i2.Organization? organization,
    required _i1.UuidValue authUserId,
    _i3.AuthUser? authUser,
    required _i4.OrgMemberRole role,
    DateTime? createdAt,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         authUserId: authUserId,
         authUser: authUser,
         role: role,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [OrganizationMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrganizationMember copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    Object? organization = _Undefined,
    _i1.UuidValue? authUserId,
    Object? authUser = _Undefined,
    _i4.OrgMemberRole? role,
    DateTime? createdAt,
  }) {
    return OrganizationMember(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _i3.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
