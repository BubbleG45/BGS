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

/// Thrown when the current user isn't an [OrganizationMember] with
/// sufficient role to perform the requested action.
abstract class OrganizationAccessDeniedException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  OrganizationAccessDeniedException._({required this.organizationId});

  factory OrganizationAccessDeniedException({
    required _i1.UuidValue organizationId,
  }) = _OrganizationAccessDeniedExceptionImpl;

  factory OrganizationAccessDeniedException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return OrganizationAccessDeniedException(
      organizationId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizationId'],
      ),
    );
  }

  _i1.UuidValue organizationId;

  /// Returns a shallow copy of this [OrganizationAccessDeniedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrganizationAccessDeniedException copyWith({_i1.UuidValue? organizationId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrganizationAccessDeniedException',
      'organizationId': organizationId.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrganizationAccessDeniedException',
      'organizationId': organizationId.toJson(),
    };
  }

  @override
  String toString() {
    return 'OrganizationAccessDeniedException(organizationId: $organizationId)';
  }
}

class _OrganizationAccessDeniedExceptionImpl
    extends OrganizationAccessDeniedException {
  _OrganizationAccessDeniedExceptionImpl({
    required _i1.UuidValue organizationId,
  }) : super._(organizationId: organizationId);

  /// Returns a shallow copy of this [OrganizationAccessDeniedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrganizationAccessDeniedException copyWith({_i1.UuidValue? organizationId}) {
    return OrganizationAccessDeniedException(
      organizationId: organizationId ?? this.organizationId,
    );
  }
}
