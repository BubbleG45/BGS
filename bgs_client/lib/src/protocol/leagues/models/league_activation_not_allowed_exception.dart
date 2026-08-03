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
import '../../leagues/models/league_status.dart' as _i2;

/// Thrown when trying to activate a league that isn't currently `draft`.
abstract class LeagueActivationNotAllowedException
    implements _i1.SerializableException, _i1.SerializableModel {
  LeagueActivationNotAllowedException._({
    required this.leagueId,
    required this.currentStatus,
  });

  factory LeagueActivationNotAllowedException({
    required _i1.UuidValue leagueId,
    required _i2.LeagueStatus currentStatus,
  }) = _LeagueActivationNotAllowedExceptionImpl;

  factory LeagueActivationNotAllowedException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return LeagueActivationNotAllowedException(
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

  /// Returns a shallow copy of this [LeagueActivationNotAllowedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LeagueActivationNotAllowedException copyWith({
    _i1.UuidValue? leagueId,
    _i2.LeagueStatus? currentStatus,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LeagueActivationNotAllowedException',
      'leagueId': leagueId.toJson(),
      'currentStatus': currentStatus.toJson(),
    };
  }

  @override
  String toString() {
    return 'LeagueActivationNotAllowedException(leagueId: $leagueId, currentStatus: $currentStatus)';
  }
}

class _LeagueActivationNotAllowedExceptionImpl
    extends LeagueActivationNotAllowedException {
  _LeagueActivationNotAllowedExceptionImpl({
    required _i1.UuidValue leagueId,
    required _i2.LeagueStatus currentStatus,
  }) : super._(
         leagueId: leagueId,
         currentStatus: currentStatus,
       );

  /// Returns a shallow copy of this [LeagueActivationNotAllowedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LeagueActivationNotAllowedException copyWith({
    _i1.UuidValue? leagueId,
    _i2.LeagueStatus? currentStatus,
  }) {
    return LeagueActivationNotAllowedException(
      leagueId: leagueId ?? this.leagueId,
      currentStatus: currentStatus ?? this.currentStatus,
    );
  }
}
