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
import '../../leagues/models/league_status.dart' as _i2;

/// Thrown when trying to complete a league that isn't currently `active`.
abstract class LeagueCompletionNotAllowedException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  LeagueCompletionNotAllowedException._({
    required this.leagueId,
    required this.currentStatus,
  });

  factory LeagueCompletionNotAllowedException({
    required _i1.UuidValue leagueId,
    required _i2.LeagueStatus currentStatus,
  }) = _LeagueCompletionNotAllowedExceptionImpl;

  factory LeagueCompletionNotAllowedException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return LeagueCompletionNotAllowedException(
      leagueId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['leagueId'],
      ),
      currentStatus: _i2.LeagueStatus.fromJson(
        (jsonSerialization['currentStatus'] as String),
      ),
    );
  }

  _i1.UuidValue leagueId;

  _i2.LeagueStatus currentStatus;

  /// Returns a shallow copy of this [LeagueCompletionNotAllowedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LeagueCompletionNotAllowedException copyWith({
    _i1.UuidValue? leagueId,
    _i2.LeagueStatus? currentStatus,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LeagueCompletionNotAllowedException',
      'leagueId': leagueId.toJson(),
      'currentStatus': currentStatus.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LeagueCompletionNotAllowedException',
      'leagueId': leagueId.toJson(),
      'currentStatus': currentStatus.toJson(),
    };
  }

  @override
  String toString() {
    return 'LeagueCompletionNotAllowedException(leagueId: $leagueId, currentStatus: $currentStatus)';
  }
}

class _LeagueCompletionNotAllowedExceptionImpl
    extends LeagueCompletionNotAllowedException {
  _LeagueCompletionNotAllowedExceptionImpl({
    required _i1.UuidValue leagueId,
    required _i2.LeagueStatus currentStatus,
  }) : super._(
         leagueId: leagueId,
         currentStatus: currentStatus,
       );

  /// Returns a shallow copy of this [LeagueCompletionNotAllowedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LeagueCompletionNotAllowedException copyWith({
    _i1.UuidValue? leagueId,
    _i2.LeagueStatus? currentStatus,
  }) {
    return LeagueCompletionNotAllowedException(
      leagueId: leagueId ?? this.leagueId,
      currentStatus: currentStatus ?? this.currentStatus,
    );
  }
}
