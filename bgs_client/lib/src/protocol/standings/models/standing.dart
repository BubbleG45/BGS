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
import '../../teams/models/team.dart' as _i3;
import 'package:bgs_client/src/protocol/protocol.dart' as _i4;

/// A team's basic win/loss record within a [League]. Recomputed/updated as
/// [ScheduledMatch] results come in -- not itself the source of truth for
/// match results, just the aggregate.
abstract class Standing implements _i1.SerializableModel {
  Standing._({
    this.id,
    required this.leagueId,
    this.league,
    required this.teamId,
    this.team,
    int? wins,
    int? losses,
    int? ties,
    int? pointsFor,
    int? pointsAgainst,
  }) : wins = wins ?? 0,
       losses = losses ?? 0,
       ties = ties ?? 0,
       pointsFor = pointsFor ?? 0,
       pointsAgainst = pointsAgainst ?? 0;

  factory Standing({
    _i1.UuidValue? id,
    required _i1.UuidValue leagueId,
    _i2.League? league,
    required _i1.UuidValue teamId,
    _i3.Team? team,
    int? wins,
    int? losses,
    int? ties,
    int? pointsFor,
    int? pointsAgainst,
  }) = _StandingImpl;

  factory Standing.fromJson(Map<String, dynamic> jsonSerialization) {
    return Standing(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      leagueId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['leagueId'],
      ),
      league: jsonSerialization['league'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.League>(jsonSerialization['league']),
      teamId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['teamId']),
      team: jsonSerialization['team'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Team>(jsonSerialization['team']),
      wins: jsonSerialization['wins'] as int?,
      losses: jsonSerialization['losses'] as int?,
      ties: jsonSerialization['ties'] as int?,
      pointsFor: jsonSerialization['pointsFor'] as int?,
      pointsAgainst: jsonSerialization['pointsAgainst'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue leagueId;

  _i2.League? league;

  _i1.UuidValue teamId;

  _i3.Team? team;

  int wins;

  int losses;

  int ties;

  int pointsFor;

  int pointsAgainst;

  /// Returns a shallow copy of this [Standing]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Standing copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? leagueId,
    _i2.League? league,
    _i1.UuidValue? teamId,
    _i3.Team? team,
    int? wins,
    int? losses,
    int? ties,
    int? pointsFor,
    int? pointsAgainst,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Standing',
      if (id != null) 'id': id?.toJson(),
      'leagueId': leagueId.toJson(),
      if (league != null) 'league': league?.toJson(),
      'teamId': teamId.toJson(),
      if (team != null) 'team': team?.toJson(),
      'wins': wins,
      'losses': losses,
      'ties': ties,
      'pointsFor': pointsFor,
      'pointsAgainst': pointsAgainst,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StandingImpl extends Standing {
  _StandingImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue leagueId,
    _i2.League? league,
    required _i1.UuidValue teamId,
    _i3.Team? team,
    int? wins,
    int? losses,
    int? ties,
    int? pointsFor,
    int? pointsAgainst,
  }) : super._(
         id: id,
         leagueId: leagueId,
         league: league,
         teamId: teamId,
         team: team,
         wins: wins,
         losses: losses,
         ties: ties,
         pointsFor: pointsFor,
         pointsAgainst: pointsAgainst,
       );

  /// Returns a shallow copy of this [Standing]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Standing copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? leagueId,
    Object? league = _Undefined,
    _i1.UuidValue? teamId,
    Object? team = _Undefined,
    int? wins,
    int? losses,
    int? ties,
    int? pointsFor,
    int? pointsAgainst,
  }) {
    return Standing(
      id: id is _i1.UuidValue? ? id : this.id,
      leagueId: leagueId ?? this.leagueId,
      league: league is _i2.League? ? league : this.league?.copyWith(),
      teamId: teamId ?? this.teamId,
      team: team is _i3.Team? ? team : this.team?.copyWith(),
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
      ties: ties ?? this.ties,
      pointsFor: pointsFor ?? this.pointsFor,
      pointsAgainst: pointsAgainst ?? this.pointsAgainst,
    );
  }
}
