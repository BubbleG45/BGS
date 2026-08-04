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

/// Thrown when a scheduled match id doesn't correspond to any existing
/// match.
abstract class ScheduledMatchNotFoundException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  ScheduledMatchNotFoundException._({required this.matchId});

  factory ScheduledMatchNotFoundException({required _i1.UuidValue matchId}) =
      _ScheduledMatchNotFoundExceptionImpl;

  factory ScheduledMatchNotFoundException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ScheduledMatchNotFoundException(
      matchId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['matchId'],
      ),
    );
  }

  _i1.UuidValue matchId;

  /// Returns a shallow copy of this [ScheduledMatchNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScheduledMatchNotFoundException copyWith({_i1.UuidValue? matchId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScheduledMatchNotFoundException',
      'matchId': matchId.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ScheduledMatchNotFoundException',
      'matchId': matchId.toJson(),
    };
  }

  @override
  String toString() {
    return 'ScheduledMatchNotFoundException(matchId: $matchId)';
  }
}

class _ScheduledMatchNotFoundExceptionImpl
    extends ScheduledMatchNotFoundException {
  _ScheduledMatchNotFoundExceptionImpl({required _i1.UuidValue matchId})
    : super._(matchId: matchId);

  /// Returns a shallow copy of this [ScheduledMatchNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScheduledMatchNotFoundException copyWith({_i1.UuidValue? matchId}) {
    return ScheduledMatchNotFoundException(matchId: matchId ?? this.matchId);
  }
}
