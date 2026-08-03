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

/// Thrown when inviting a player who already has a membership row (any
/// status) for the target team.
abstract class TeamMembershipAlreadyExistsException
    implements _i1.SerializableException, _i1.SerializableModel {
  TeamMembershipAlreadyExistsException._({
    required this.teamId,
    required this.email,
  });

  factory TeamMembershipAlreadyExistsException({
    required _i1.UuidValue teamId,
    required String email,
  }) = _TeamMembershipAlreadyExistsExceptionImpl;

  factory TeamMembershipAlreadyExistsException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TeamMembershipAlreadyExistsException(
      teamId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['teamId']),
      email: jsonSerialization['email'] as String,
    );
  }

  _i1.UuidValue teamId;

  String email;

  /// Returns a shallow copy of this [TeamMembershipAlreadyExistsException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TeamMembershipAlreadyExistsException copyWith({
    _i1.UuidValue? teamId,
    String? email,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TeamMembershipAlreadyExistsException',
      'teamId': teamId.toJson(),
      'email': email,
    };
  }

  @override
  String toString() {
    return 'TeamMembershipAlreadyExistsException(teamId: $teamId, email: $email)';
  }
}

class _TeamMembershipAlreadyExistsExceptionImpl
    extends TeamMembershipAlreadyExistsException {
  _TeamMembershipAlreadyExistsExceptionImpl({
    required _i1.UuidValue teamId,
    required String email,
  }) : super._(
         teamId: teamId,
         email: email,
       );

  /// Returns a shallow copy of this [TeamMembershipAlreadyExistsException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TeamMembershipAlreadyExistsException copyWith({
    _i1.UuidValue? teamId,
    String? email,
  }) {
    return TeamMembershipAlreadyExistsException(
      teamId: teamId ?? this.teamId,
      email: email ?? this.email,
    );
  }
}
