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

/// Thrown when the calling user tries to accept/decline a team invite that
/// isn't theirs. Authorization here is "is this the AuthUser on the
/// membership row" -- deliberately not an org-role check, since this is a
/// player-side action.
abstract class TeamMembershipAccessDeniedException
    implements _i1.SerializableException, _i1.SerializableModel {
  TeamMembershipAccessDeniedException._({required this.membershipId});

  factory TeamMembershipAccessDeniedException({
    required _i1.UuidValue membershipId,
  }) = _TeamMembershipAccessDeniedExceptionImpl;

  factory TeamMembershipAccessDeniedException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TeamMembershipAccessDeniedException(
      membershipId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['membershipId'],
      ),
    );
  }

  _i1.UuidValue membershipId;

  /// Returns a shallow copy of this [TeamMembershipAccessDeniedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TeamMembershipAccessDeniedException copyWith({_i1.UuidValue? membershipId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TeamMembershipAccessDeniedException',
      'membershipId': membershipId.toJson(),
    };
  }

  @override
  String toString() {
    return 'TeamMembershipAccessDeniedException(membershipId: $membershipId)';
  }
}

class _TeamMembershipAccessDeniedExceptionImpl
    extends TeamMembershipAccessDeniedException {
  _TeamMembershipAccessDeniedExceptionImpl({
    required _i1.UuidValue membershipId,
  }) : super._(membershipId: membershipId);

  /// Returns a shallow copy of this [TeamMembershipAccessDeniedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TeamMembershipAccessDeniedException copyWith({_i1.UuidValue? membershipId}) {
    return TeamMembershipAccessDeniedException(
      membershipId: membershipId ?? this.membershipId,
    );
  }
}
