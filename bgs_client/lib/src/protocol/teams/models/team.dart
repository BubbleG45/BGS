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
import '../../leagues/models/league.dart' as _i2;
import '../../scheduling/models/scheduled_match.dart' as _i3;
import 'package:bgs_client/src/protocol/protocol.dart' as _i4;

/// A team competing within a single [League]. Scoped to one league/season
/// for Phase 1 -- persistent clubs spanning multiple seasons are a later
/// enhancement, not needed for the initial broad-but-shallow slice.
abstract class Team implements _i1.SerializableModel {
  Team._({
    this.id,
    required this.leagueId,
    this.league,
    required this.name,
    DateTime? createdAt,
    this.homeMatches,
    this.awayMatches,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Team({
    _i1.UuidValue? id,
    required _i1.UuidValue leagueId,
    _i2.League? league,
    required String name,
    DateTime? createdAt,
    List<_i3.ScheduledMatch>? homeMatches,
    List<_i3.ScheduledMatch>? awayMatches,
  }) = _TeamImpl;

  factory Team.fromJson(Map<String, dynamic> jsonSerialization) {
    return Team(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      leagueId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['leagueId'],
      ),
      league: jsonSerialization['league'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.League>(jsonSerialization['league']),
      name: jsonSerialization['name'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      homeMatches: jsonSerialization['homeMatches'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.ScheduledMatch>>(
              jsonSerialization['homeMatches'],
            ),
      awayMatches: jsonSerialization['awayMatches'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.ScheduledMatch>>(
              jsonSerialization['awayMatches'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue leagueId;

  _i2.League? league;

  String name;

  DateTime createdAt;

  /// Reverse sides of [ScheduledMatch]'s named home/away relations -- not
  /// used directly for queries (those filter ScheduledMatch by FK), but
  /// required by Serverpod to disambiguate the two FKs to this table.
  List<_i3.ScheduledMatch>? homeMatches;

  List<_i3.ScheduledMatch>? awayMatches;

  /// Returns a shallow copy of this [Team]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Team copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? leagueId,
    _i2.League? league,
    String? name,
    DateTime? createdAt,
    List<_i3.ScheduledMatch>? homeMatches,
    List<_i3.ScheduledMatch>? awayMatches,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Team',
      if (id != null) 'id': id?.toJson(),
      'leagueId': leagueId.toJson(),
      if (league != null) 'league': league?.toJson(),
      'name': name,
      'createdAt': createdAt.toJson(),
      if (homeMatches != null)
        'homeMatches': homeMatches?.toJson(valueToJson: (v) => v.toJson()),
      if (awayMatches != null)
        'awayMatches': awayMatches?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TeamImpl extends Team {
  _TeamImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue leagueId,
    _i2.League? league,
    required String name,
    DateTime? createdAt,
    List<_i3.ScheduledMatch>? homeMatches,
    List<_i3.ScheduledMatch>? awayMatches,
  }) : super._(
         id: id,
         leagueId: leagueId,
         league: league,
         name: name,
         createdAt: createdAt,
         homeMatches: homeMatches,
         awayMatches: awayMatches,
       );

  /// Returns a shallow copy of this [Team]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Team copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? leagueId,
    Object? league = _Undefined,
    String? name,
    DateTime? createdAt,
    Object? homeMatches = _Undefined,
    Object? awayMatches = _Undefined,
  }) {
    return Team(
      id: id is _i1.UuidValue? ? id : this.id,
      leagueId: leagueId ?? this.leagueId,
      league: league is _i2.League? ? league : this.league?.copyWith(),
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      homeMatches: homeMatches is List<_i3.ScheduledMatch>?
          ? homeMatches
          : this.homeMatches?.map((e0) => e0.copyWith()).toList(),
      awayMatches: awayMatches is List<_i3.ScheduledMatch>?
          ? awayMatches
          : this.awayMatches?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
