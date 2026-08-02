/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../../scheduling/models/match_status.dart' as _i2;
import '../../leagues/models/league.dart' as _i3;
import '../../teams/models/team.dart' as _i4;
import 'package:bgs_server/src/generated/protocol.dart' as _i5;

/// A single scheduled game between two teams within a [League]. Manual
/// scheduling only for Phase 1 -- no auto-scheduling algorithm yet.
abstract class ScheduledMatch
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
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

  static final t = ScheduledMatchTable();

  static const db = ScheduledMatchRepository._();

  @override
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

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ScheduledMatch',
      if (id != null) 'id': id?.toJson(),
      'leagueId': leagueId.toJson(),
      if (league != null) 'league': league?.toJsonForProtocol(),
      'homeTeamId': homeTeamId.toJson(),
      if (homeTeam != null) 'homeTeam': homeTeam?.toJsonForProtocol(),
      'awayTeamId': awayTeamId.toJson(),
      if (awayTeam != null) 'awayTeam': awayTeam?.toJsonForProtocol(),
      'scheduledAt': scheduledAt.toJson(),
      if (location != null) 'location': location,
      'status': status.toJson(),
      if (homeScore != null) 'homeScore': homeScore,
      if (awayScore != null) 'awayScore': awayScore,
      'createdAt': createdAt.toJson(),
    };
  }

  static ScheduledMatchInclude include({
    _i3.LeagueInclude? league,
    _i4.TeamInclude? homeTeam,
    _i4.TeamInclude? awayTeam,
  }) {
    return ScheduledMatchInclude._(
      league: league,
      homeTeam: homeTeam,
      awayTeam: awayTeam,
    );
  }

  static ScheduledMatchIncludeList includeList({
    _i1.WhereExpressionBuilder<ScheduledMatchTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduledMatchTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduledMatchTable>? orderByList,
    ScheduledMatchInclude? include,
  }) {
    return ScheduledMatchIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScheduledMatch.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ScheduledMatch.t),
      include: include,
    );
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

class ScheduledMatchUpdateTable extends _i1.UpdateTable<ScheduledMatchTable> {
  ScheduledMatchUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> leagueId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.leagueId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> homeTeamId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.homeTeamId,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> awayTeamId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.awayTeamId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> scheduledAt(DateTime value) =>
      _i1.ColumnValue(
        table.scheduledAt,
        value,
      );

  _i1.ColumnValue<String, String> location(String? value) => _i1.ColumnValue(
    table.location,
    value,
  );

  _i1.ColumnValue<_i2.MatchStatus, _i2.MatchStatus> status(
    _i2.MatchStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> homeScore(int? value) => _i1.ColumnValue(
    table.homeScore,
    value,
  );

  _i1.ColumnValue<int, int> awayScore(int? value) => _i1.ColumnValue(
    table.awayScore,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class ScheduledMatchTable extends _i1.Table<_i1.UuidValue?> {
  ScheduledMatchTable({super.tableRelation})
    : super(tableName: 'bgs_scheduled_match') {
    updateTable = ScheduledMatchUpdateTable(this);
    leagueId = _i1.ColumnUuid(
      'leagueId',
      this,
    );
    homeTeamId = _i1.ColumnUuid(
      'homeTeamId',
      this,
    );
    awayTeamId = _i1.ColumnUuid(
      'awayTeamId',
      this,
    );
    scheduledAt = _i1.ColumnDateTime(
      'scheduledAt',
      this,
    );
    location = _i1.ColumnString(
      'location',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    homeScore = _i1.ColumnInt(
      'homeScore',
      this,
    );
    awayScore = _i1.ColumnInt(
      'awayScore',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final ScheduledMatchUpdateTable updateTable;

  late final _i1.ColumnUuid leagueId;

  _i3.LeagueTable? _league;

  late final _i1.ColumnUuid homeTeamId;

  _i4.TeamTable? _homeTeam;

  late final _i1.ColumnUuid awayTeamId;

  _i4.TeamTable? _awayTeam;

  late final _i1.ColumnDateTime scheduledAt;

  late final _i1.ColumnString location;

  late final _i1.ColumnEnum<_i2.MatchStatus> status;

  /// Single running score. Sport-specific scoring structures (sets,
  /// innings, periods) are a later phase (see BUILD_PLAN.md Phase 2) --
  /// this is enough for basic win/loss standings in Phase 1.
  late final _i1.ColumnInt homeScore;

  late final _i1.ColumnInt awayScore;

  late final _i1.ColumnDateTime createdAt;

  _i3.LeagueTable get league {
    if (_league != null) return _league!;
    _league = _i1.createRelationTable(
      relationFieldName: 'league',
      field: ScheduledMatch.t.leagueId,
      foreignField: _i3.League.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.LeagueTable(tableRelation: foreignTableRelation),
    );
    return _league!;
  }

  _i4.TeamTable get homeTeam {
    if (_homeTeam != null) return _homeTeam!;
    _homeTeam = _i1.createRelationTable(
      relationFieldName: 'homeTeam',
      field: ScheduledMatch.t.homeTeamId,
      foreignField: _i4.Team.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.TeamTable(tableRelation: foreignTableRelation),
    );
    return _homeTeam!;
  }

  _i4.TeamTable get awayTeam {
    if (_awayTeam != null) return _awayTeam!;
    _awayTeam = _i1.createRelationTable(
      relationFieldName: 'awayTeam',
      field: ScheduledMatch.t.awayTeamId,
      foreignField: _i4.Team.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.TeamTable(tableRelation: foreignTableRelation),
    );
    return _awayTeam!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    leagueId,
    homeTeamId,
    awayTeamId,
    scheduledAt,
    location,
    status,
    homeScore,
    awayScore,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'league') {
      return league;
    }
    if (relationField == 'homeTeam') {
      return homeTeam;
    }
    if (relationField == 'awayTeam') {
      return awayTeam;
    }
    return null;
  }
}

class ScheduledMatchInclude extends _i1.IncludeObject {
  ScheduledMatchInclude._({
    _i3.LeagueInclude? league,
    _i4.TeamInclude? homeTeam,
    _i4.TeamInclude? awayTeam,
  }) {
    _league = league;
    _homeTeam = homeTeam;
    _awayTeam = awayTeam;
  }

  _i3.LeagueInclude? _league;

  _i4.TeamInclude? _homeTeam;

  _i4.TeamInclude? _awayTeam;

  @override
  Map<String, _i1.Include?> get includes => {
    'league': _league,
    'homeTeam': _homeTeam,
    'awayTeam': _awayTeam,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => ScheduledMatch.t;
}

class ScheduledMatchIncludeList extends _i1.IncludeList {
  ScheduledMatchIncludeList._({
    _i1.WhereExpressionBuilder<ScheduledMatchTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ScheduledMatch.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => ScheduledMatch.t;
}

class ScheduledMatchRepository {
  const ScheduledMatchRepository._();

  final attachRow = const ScheduledMatchAttachRowRepository._();

  /// Returns a list of [ScheduledMatch]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<ScheduledMatch>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ScheduledMatchTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduledMatchTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduledMatchTable>? orderByList,
    _i1.Transaction? transaction,
    ScheduledMatchInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ScheduledMatch>(
      where: where?.call(ScheduledMatch.t),
      orderBy: orderBy?.call(ScheduledMatch.t),
      orderByList: orderByList?.call(ScheduledMatch.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ScheduledMatch] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<ScheduledMatch?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ScheduledMatchTable>? where,
    int? offset,
    _i1.OrderByBuilder<ScheduledMatchTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ScheduledMatchTable>? orderByList,
    _i1.Transaction? transaction,
    ScheduledMatchInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ScheduledMatch>(
      where: where?.call(ScheduledMatch.t),
      orderBy: orderBy?.call(ScheduledMatch.t),
      orderByList: orderByList?.call(ScheduledMatch.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ScheduledMatch] by its [id] or null if no such row exists.
  Future<ScheduledMatch?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    ScheduledMatchInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ScheduledMatch>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ScheduledMatch]s in the list and returns the inserted rows.
  ///
  /// The returned [ScheduledMatch]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ScheduledMatch>> insert(
    _i1.DatabaseSession session,
    List<ScheduledMatch> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ScheduledMatch>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ScheduledMatch] and returns the inserted row.
  ///
  /// The returned [ScheduledMatch] will have its `id` field set.
  Future<ScheduledMatch> insertRow(
    _i1.DatabaseSession session,
    ScheduledMatch row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ScheduledMatch>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ScheduledMatch]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ScheduledMatch>> update(
    _i1.DatabaseSession session,
    List<ScheduledMatch> rows, {
    _i1.ColumnSelections<ScheduledMatchTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ScheduledMatch>(
      rows,
      columns: columns?.call(ScheduledMatch.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScheduledMatch]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ScheduledMatch> updateRow(
    _i1.DatabaseSession session,
    ScheduledMatch row, {
    _i1.ColumnSelections<ScheduledMatchTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ScheduledMatch>(
      row,
      columns: columns?.call(ScheduledMatch.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ScheduledMatch] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ScheduledMatch?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<ScheduledMatchUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ScheduledMatch>(
      id,
      columnValues: columnValues(ScheduledMatch.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ScheduledMatch]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ScheduledMatch>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ScheduledMatchUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ScheduledMatchTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ScheduledMatchTable>? orderBy,
    _i1.OrderByListBuilder<ScheduledMatchTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ScheduledMatch>(
      columnValues: columnValues(ScheduledMatch.t.updateTable),
      where: where(ScheduledMatch.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ScheduledMatch.t),
      orderByList: orderByList?.call(ScheduledMatch.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ScheduledMatch]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ScheduledMatch>> delete(
    _i1.DatabaseSession session,
    List<ScheduledMatch> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ScheduledMatch>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ScheduledMatch].
  Future<ScheduledMatch> deleteRow(
    _i1.DatabaseSession session,
    ScheduledMatch row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ScheduledMatch>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ScheduledMatch>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ScheduledMatchTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ScheduledMatch>(
      where: where(ScheduledMatch.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ScheduledMatchTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ScheduledMatch>(
      where: where?.call(ScheduledMatch.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ScheduledMatch] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ScheduledMatchTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ScheduledMatch>(
      where: where(ScheduledMatch.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ScheduledMatchAttachRowRepository {
  const ScheduledMatchAttachRowRepository._();

  /// Creates a relation between the given [ScheduledMatch] and [League]
  /// by setting the [ScheduledMatch]'s foreign key `leagueId` to refer to the [League].
  Future<void> league(
    _i1.DatabaseSession session,
    ScheduledMatch scheduledMatch,
    _i3.League league, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledMatch.id == null) {
      throw ArgumentError.notNull('scheduledMatch.id');
    }
    if (league.id == null) {
      throw ArgumentError.notNull('league.id');
    }

    var $scheduledMatch = scheduledMatch.copyWith(leagueId: league.id);
    await session.db.updateRow<ScheduledMatch>(
      $scheduledMatch,
      columns: [ScheduledMatch.t.leagueId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ScheduledMatch] and [Team]
  /// by setting the [ScheduledMatch]'s foreign key `homeTeamId` to refer to the [Team].
  Future<void> homeTeam(
    _i1.DatabaseSession session,
    ScheduledMatch scheduledMatch,
    _i4.Team homeTeam, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledMatch.id == null) {
      throw ArgumentError.notNull('scheduledMatch.id');
    }
    if (homeTeam.id == null) {
      throw ArgumentError.notNull('homeTeam.id');
    }

    var $scheduledMatch = scheduledMatch.copyWith(homeTeamId: homeTeam.id);
    await session.db.updateRow<ScheduledMatch>(
      $scheduledMatch,
      columns: [ScheduledMatch.t.homeTeamId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ScheduledMatch] and [Team]
  /// by setting the [ScheduledMatch]'s foreign key `awayTeamId` to refer to the [Team].
  Future<void> awayTeam(
    _i1.DatabaseSession session,
    ScheduledMatch scheduledMatch,
    _i4.Team awayTeam, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledMatch.id == null) {
      throw ArgumentError.notNull('scheduledMatch.id');
    }
    if (awayTeam.id == null) {
      throw ArgumentError.notNull('awayTeam.id');
    }

    var $scheduledMatch = scheduledMatch.copyWith(awayTeamId: awayTeam.id);
    await session.db.updateRow<ScheduledMatch>(
      $scheduledMatch,
      columns: [ScheduledMatch.t.awayTeamId],
      transaction: transaction,
    );
  }
}
