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
import '../../organizations/models/org_member_role.dart' as _i3;
import 'package:bgs_client/src/protocol/protocol.dart' as _i4;

/// An [Organization] paired with the calling user's role in it.
///
/// Transient DTO (no `table:`) -- return shape for
/// [OrganizationEndpoint.listMine], which backs the Organizer Dashboard.
abstract class OrganizationMembership implements _i1.SerializableModel {
  OrganizationMembership._({
    required this.organization,
    required this.role,
  });

  factory OrganizationMembership({
    required _i2.Organization organization,
    required _i3.OrgMemberRole role,
  }) = _OrganizationMembershipImpl;

  factory OrganizationMembership.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return OrganizationMembership(
      organization: _i4.Protocol().deserialize<_i2.Organization>(
        jsonSerialization['organization'],
      ),
      role: _i3.OrgMemberRole.fromJson((jsonSerialization['role'] as String)),
    );
  }

  _i2.Organization organization;

  _i3.OrgMemberRole role;

  /// Returns a shallow copy of this [OrganizationMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrganizationMembership copyWith({
    _i2.Organization? organization,
    _i3.OrgMemberRole? role,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrganizationMembership',
      'organization': organization.toJson(),
      'role': role.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _OrganizationMembershipImpl extends OrganizationMembership {
  _OrganizationMembershipImpl({
    required _i2.Organization organization,
    required _i3.OrgMemberRole role,
  }) : super._(
         organization: organization,
         role: role,
       );

  /// Returns a shallow copy of this [OrganizationMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrganizationMembership copyWith({
    _i2.Organization? organization,
    _i3.OrgMemberRole? role,
  }) {
    return OrganizationMembership(
      organization: organization ?? this.organization.copyWith(),
      role: role ?? this.role,
    );
  }
}
