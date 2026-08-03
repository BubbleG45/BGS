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

/// Thrown when a team membership id doesn't correspond to any existing
/// membership.
abstract class TeamMembershipNotFoundException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  TeamMembershipNotFoundException._({required this.membershipId});

  factory TeamMembershipNotFoundException({
    required _i1.UuidValue membershipId,
  }) = _TeamMembershipNotFoundExceptionImpl;

  factory TeamMembershipNotFoundException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TeamMembershipNotFoundException(
      membershipId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['membershipId'],
      ),
    );
  }

  _i1.UuidValue membershipId;

  /// Returns a shallow copy of this [TeamMembershipNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TeamMembershipNotFoundException copyWith({_i1.UuidValue? membershipId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TeamMembershipNotFoundException',
      'membershipId': membershipId.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TeamMembershipNotFoundException',
      'membershipId': membershipId.toJson(),
    };
  }

  @override
  String toString() {
    return 'TeamMembershipNotFoundException(membershipId: $membershipId)';
  }
}

class _TeamMembershipNotFoundExceptionImpl
    extends TeamMembershipNotFoundException {
  _TeamMembershipNotFoundExceptionImpl({required _i1.UuidValue membershipId})
    : super._(membershipId: membershipId);

  /// Returns a shallow copy of this [TeamMembershipNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TeamMembershipNotFoundException copyWith({_i1.UuidValue? membershipId}) {
    return TeamMembershipNotFoundException(
      membershipId: membershipId ?? this.membershipId,
    );
  }
}
