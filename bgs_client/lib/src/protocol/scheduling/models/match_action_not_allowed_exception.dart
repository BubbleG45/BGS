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
import '../../scheduling/models/match_status.dart' as _i2;

/// Thrown when trying to cancel or record a result for a match that isn't
/// currently `scheduled` (e.g. already completed or cancelled).
abstract class MatchActionNotAllowedException
    implements _i1.SerializableException, _i1.SerializableModel {
  MatchActionNotAllowedException._({
    required this.matchId,
    required this.currentStatus,
  });

  factory MatchActionNotAllowedException({
    required _i1.UuidValue matchId,
    required _i2.MatchStatus currentStatus,
  }) = _MatchActionNotAllowedExceptionImpl;

  factory MatchActionNotAllowedException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return MatchActionNotAllowedException(
      matchId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['matchId'],
      ),
      currentStatus: _i2.MatchStatus.fromJson(
        (jsonSerialization['currentStatus'] as String),
      ),
    );
  }

  _i1.UuidValue matchId;

  _i2.MatchStatus currentStatus;

  /// Returns a shallow copy of this [MatchActionNotAllowedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MatchActionNotAllowedException copyWith({
    _i1.UuidValue? matchId,
    _i2.MatchStatus? currentStatus,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MatchActionNotAllowedException',
      'matchId': matchId.toJson(),
      'currentStatus': currentStatus.toJson(),
    };
  }

  @override
  String toString() {
    return 'MatchActionNotAllowedException(matchId: $matchId, currentStatus: $currentStatus)';
  }
}

class _MatchActionNotAllowedExceptionImpl
    extends MatchActionNotAllowedException {
  _MatchActionNotAllowedExceptionImpl({
    required _i1.UuidValue matchId,
    required _i2.MatchStatus currentStatus,
  }) : super._(
         matchId: matchId,
         currentStatus: currentStatus,
       );

  /// Returns a shallow copy of this [MatchActionNotAllowedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MatchActionNotAllowedException copyWith({
    _i1.UuidValue? matchId,
    _i2.MatchStatus? currentStatus,
  }) {
    return MatchActionNotAllowedException(
      matchId: matchId ?? this.matchId,
      currentStatus: currentStatus ?? this.currentStatus,
    );
  }
}
