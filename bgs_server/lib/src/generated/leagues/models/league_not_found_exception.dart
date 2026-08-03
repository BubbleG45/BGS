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

/// Thrown when a league id doesn't correspond to any existing league.
abstract class LeagueNotFoundException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  LeagueNotFoundException._({required this.leagueId});

  factory LeagueNotFoundException({required _i1.UuidValue leagueId}) =
      _LeagueNotFoundExceptionImpl;

  factory LeagueNotFoundException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return LeagueNotFoundException(
      leagueId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['leagueId'],
      ),
    );
  }

  _i1.UuidValue leagueId;

  /// Returns a shallow copy of this [LeagueNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LeagueNotFoundException copyWith({_i1.UuidValue? leagueId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LeagueNotFoundException',
      'leagueId': leagueId.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LeagueNotFoundException',
      'leagueId': leagueId.toJson(),
    };
  }

  @override
  String toString() {
    return 'LeagueNotFoundException(leagueId: $leagueId)';
  }
}

class _LeagueNotFoundExceptionImpl extends LeagueNotFoundException {
  _LeagueNotFoundExceptionImpl({required _i1.UuidValue leagueId})
    : super._(leagueId: leagueId);

  /// Returns a shallow copy of this [LeagueNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LeagueNotFoundException copyWith({_i1.UuidValue? leagueId}) {
    return LeagueNotFoundException(leagueId: leagueId ?? this.leagueId);
  }
}
