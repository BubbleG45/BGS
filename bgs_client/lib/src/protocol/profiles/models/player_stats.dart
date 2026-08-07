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

/// Aggregated wins/losses/ties across every team the caller has been an
/// active member of. Transient (no `table:`) -- computed on read from
/// existing [Standing] rows, not stored. `teamCount` is how many teams
/// fed into the total, so the UI can distinguish "0-0-0, no games played
/// yet" from "0-0-0 across 3 teams".
abstract class PlayerStats implements _i1.SerializableModel {
  PlayerStats._({
    required this.wins,
    required this.losses,
    required this.ties,
    required this.teamCount,
  });

  factory PlayerStats({
    required int wins,
    required int losses,
    required int ties,
    required int teamCount,
  }) = _PlayerStatsImpl;

  factory PlayerStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlayerStats(
      wins: jsonSerialization['wins'] as int,
      losses: jsonSerialization['losses'] as int,
      ties: jsonSerialization['ties'] as int,
      teamCount: jsonSerialization['teamCount'] as int,
    );
  }

  int wins;

  int losses;

  int ties;

  int teamCount;

  /// Returns a shallow copy of this [PlayerStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlayerStats copyWith({
    int? wins,
    int? losses,
    int? ties,
    int? teamCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlayerStats',
      'wins': wins,
      'losses': losses,
      'ties': ties,
      'teamCount': teamCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _PlayerStatsImpl extends PlayerStats {
  _PlayerStatsImpl({
    required int wins,
    required int losses,
    required int ties,
    required int teamCount,
  }) : super._(
         wins: wins,
         losses: losses,
         ties: ties,
         teamCount: teamCount,
       );

  /// Returns a shallow copy of this [PlayerStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlayerStats copyWith({
    int? wins,
    int? losses,
    int? ties,
    int? teamCount,
  }) {
    return PlayerStats(
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
      ties: ties ?? this.ties,
      teamCount: teamCount ?? this.teamCount,
    );
  }
}
