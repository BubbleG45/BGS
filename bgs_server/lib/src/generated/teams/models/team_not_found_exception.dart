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

/// Thrown when a team id doesn't correspond to any existing team.
abstract class TeamNotFoundException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  TeamNotFoundException._({required this.teamId});

  factory TeamNotFoundException({required _i1.UuidValue teamId}) =
      _TeamNotFoundExceptionImpl;

  factory TeamNotFoundException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TeamNotFoundException(
      teamId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['teamId']),
    );
  }

  _i1.UuidValue teamId;

  /// Returns a shallow copy of this [TeamNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TeamNotFoundException copyWith({_i1.UuidValue? teamId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TeamNotFoundException',
      'teamId': teamId.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TeamNotFoundException',
      'teamId': teamId.toJson(),
    };
  }

  @override
  String toString() {
    return 'TeamNotFoundException(teamId: $teamId)';
  }
}

class _TeamNotFoundExceptionImpl extends TeamNotFoundException {
  _TeamNotFoundExceptionImpl({required _i1.UuidValue teamId})
    : super._(teamId: teamId);

  /// Returns a shallow copy of this [TeamNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TeamNotFoundException copyWith({_i1.UuidValue? teamId}) {
    return TeamNotFoundException(teamId: teamId ?? this.teamId);
  }
}
