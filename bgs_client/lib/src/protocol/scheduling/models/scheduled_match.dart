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
import '../../leagues/models/league.dart' as _i3;
import '../../teams/models/team.dart' as _i4;
import 'package:bgs_client/src/protocol/protocol.dart' as _i5;

/// A single scheduled game between two teams within a [League]. Manual
/// scheduling only for Phase 1 -- no auto-scheduling algorithm yet.
abstract class ScheduledMatch implements _i1.SerializableModel {
  ScheduledMatch._({
    this.id,
    required this.leagueId,
    this.league,
    required this.homeTeamId,
    this.homeTeam,
    required this.awayTeamId,
    this.awayTeam,
    required this.scheduledAt,
    this.location,
    _i2.MatchStatus? status,
    this.homeScore,
    this.awayScore,
    DateTime? createdAt,
  }) : status = status ?? _i2.MatchStatus.scheduled,
       createdAt = createdAt ?? DateTime.now();

  factory ScheduledMatch({
    _i1.UuidValue? id,
    required _i1.UuidValue leagueId,
    _i3.League? league,
    required _i1.UuidValue homeTeamId,
    _i4.Team? homeTeam,
    required _i1.UuidValue awayTeamId,
    _i4.Team? awayTeam,
    required DateTime scheduledAt,
    String? location,
    _i2.MatchStatus? status,
    int? homeScore,
    int? awayScore,
    DateTime? createdAt,
  }) = _ScheduledMatchImpl;

  factory ScheduledMatch.fromJson(Map<String, dynamic> jsonSerialization) {
    return ScheduledMatch(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      leagueId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['leagueId'],
      ),
      league: jsonSerialization['league'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.League>(jsonSerialization['league']),
      homeTeamId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['homeTeamId'],
      ),
      homeTeam: jsonSerialization['homeTeam'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.Team>(jsonSerialization['homeTeam']),
      awayTeamId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['awayTeamId'],
      ),
      awayTeam: jsonSerialization['awayTeam'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.Team>(jsonSerialization['awayTeam']),
      scheduledAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['scheduledAt'],
      ),
      location: jsonSerialization['location'] as String?,
      status: jsonSerialization['status'] == null
          ? null
          : _i2.MatchStatus.fromJson((jsonSerialization['status'] as String)),
      homeScore: jsonSerialization['homeScore'] as int?,
      awayScore: jsonSerialization['awayScore'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue leagueId;

  _i3.League? league;

  _i1.UuidValue homeTeamId;

  _i4.Team? homeTeam;

  _i1.UuidValue awayTeamId;

  _i4.Team? awayTeam;

  DateTime scheduledAt;

  String? location;

  _i2.MatchStatus status;

  /// Single running score. Sport-specific scoring structures (sets,
  /// innings, periods) are a later phase (see BUILD_PLAN.md Phase 2) --
  /// this is enough for basic win/loss standings in Phase 1.
  int? homeScore;

  int? awayScore;

  DateTime createdAt;

  /// Returns a shallow copy of this [ScheduledMatch]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScheduledMatch copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? leagueId,
    _i3.League? league,
    _i1.UuidValue? homeTeamId,
    _i4.Team? homeTeam,
    _i1.UuidValue? awayTeamId,
    _i4.Team? awayTeam,
    DateTime? scheduledAt,
    String? location,
    _i2.MatchStatus? status,
    int? homeScore,
    int? awayScore,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScheduledMatch',
      if (id != null) 'id': id?.toJson(),
      'leagueId': leagueId.toJson(),
      if (league != null) 'league': league?.toJson(),
      'homeTeamId': homeTeamId.toJson(),
      if (homeTeam != null) 'homeTeam': homeTeam?.toJson(),
      'awayTeamId': awayTeamId.toJson(),
      if (awayTeam != null) 'awayTeam': awayTeam?.toJson(),
      'scheduledAt': scheduledAt.toJson(),
      if (location != null) 'location': location,
      'status': status.toJson(),
      if (homeScore != null) 'homeScore': homeScore,
      if (awayScore != null) 'awayScore': awayScore,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScheduledMatchImpl extends ScheduledMatch {
  _ScheduledMatchImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue leagueId,
    _i3.League? league,
    required _i1.UuidValue homeTeamId,
    _i4.Team? homeTeam,
    required _i1.UuidValue awayTeamId,
    _i4.Team? awayTeam,
    required DateTime scheduledAt,
    String? location,
    _i2.MatchStatus? status,
    int? homeScore,
    int? awayScore,
    DateTime? createdAt,
  }) : super._(
         id: id,
         leagueId: leagueId,
         league: league,
         homeTeamId: homeTeamId,
         homeTeam: homeTeam,
         awayTeamId: awayTeamId,
         awayTeam: awayTeam,
         scheduledAt: scheduledAt,
         location: location,
         status: status,
         homeScore: homeScore,
         awayScore: awayScore,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ScheduledMatch]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScheduledMatch copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? leagueId,
    Object? league = _Undefined,
    _i1.UuidValue? homeTeamId,
    Object? homeTeam = _Undefined,
    _i1.UuidValue? awayTeamId,
    Object? awayTeam = _Undefined,
    DateTime? scheduledAt,
    Object? location = _Undefined,
    _i2.MatchStatus? status,
    Object? homeScore = _Undefined,
    Object? awayScore = _Undefined,
    DateTime? createdAt,
  }) {
    return ScheduledMatch(
      id: id is _i1.UuidValue? ? id : this.id,
      leagueId: leagueId ?? this.leagueId,
      league: league is _i3.League? ? league : this.league?.copyWith(),
      homeTeamId: homeTeamId ?? this.homeTeamId,
      homeTeam: homeTeam is _i4.Team? ? homeTeam : this.homeTeam?.copyWith(),
      awayTeamId: awayTeamId ?? this.awayTeamId,
      awayTeam: awayTeam is _i4.Team? ? awayTeam : this.awayTeam?.copyWith(),
      scheduledAt: scheduledAt ?? this.scheduledAt,
      location: location is String? ? location : this.location,
      status: status ?? this.status,
      homeScore: homeScore is int? ? homeScore : this.homeScore,
      awayScore: awayScore is int? ? awayScore : this.awayScore,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
