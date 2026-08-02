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
import '../../leagues/models/league.dart' as _i2;
import '../../scheduling/models/scheduled_match.dart' as _i3;
import 'package:bgs_server/src/generated/protocol.dart' as _i4;

/// A team competing within a single [League]. Scoped to one league/season
/// for Phase 1 -- persistent clubs spanning multiple seasons are a later
/// enhancement, not needed for the initial broad-but-shallow slice.
abstract class Team
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
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

  static final t = TeamTable();

  static const db = TeamRepository._();

  @override
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

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Team',
      if (id != null) 'id': id?.toJson(),
      'leagueId': leagueId.toJson(),
      if (league != null) 'league': league?.toJsonForProtocol(),
      'name': name,
      'createdAt': createdAt.toJson(),
      if (homeMatches != null)
        'homeMatches': homeMatches?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (awayMatches != null)
        'awayMatches': awayMatches?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  static TeamInclude include({
    _i2.LeagueInclude? league,
    _i3.ScheduledMatchIncludeList? homeMatches,
    _i3.ScheduledMatchIncludeList? awayMatches,
  }) {
    return TeamInclude._(
      league: league,
      homeMatches: homeMatches,
      awayMatches: awayMatches,
    );
  }

  static TeamIncludeList includeList({
    _i1.WhereExpressionBuilder<TeamTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TeamTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TeamTable>? orderByList,
    TeamInclude? include,
  }) {
    return TeamIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Team.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Team.t),
      include: include,
    );
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

class TeamUpdateTable extends _i1.UpdateTable<TeamTable> {
  TeamUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> leagueId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.leagueId,
        value,
      );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class TeamTable extends _i1.Table<_i1.UuidValue?> {
  TeamTable({super.tableRelation}) : super(tableName: 'bgs_team') {
    updateTable = TeamUpdateTable(this);
    leagueId = _i1.ColumnUuid(
      'leagueId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final TeamUpdateTable updateTable;

  late final _i1.ColumnUuid leagueId;

  _i2.LeagueTable? _league;

  late final _i1.ColumnString name;

  late final _i1.ColumnDateTime createdAt;

  /// Reverse sides of [ScheduledMatch]'s named home/away relations -- not
  /// used directly for queries (those filter ScheduledMatch by FK), but
  /// required by Serverpod to disambiguate the two FKs to this table.
  _i3.ScheduledMatchTable? ___homeMatches;

  /// Reverse sides of [ScheduledMatch]'s named home/away relations -- not
  /// used directly for queries (those filter ScheduledMatch by FK), but
  /// required by Serverpod to disambiguate the two FKs to this table.
  _i1.ManyRelation<_i3.ScheduledMatchTable>? _homeMatches;

  _i3.ScheduledMatchTable? ___awayMatches;

  _i1.ManyRelation<_i3.ScheduledMatchTable>? _awayMatches;

  _i2.LeagueTable get league {
    if (_league != null) return _league!;
    _league = _i1.createRelationTable(
      relationFieldName: 'league',
      field: Team.t.leagueId,
      foreignField: _i2.League.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.LeagueTable(tableRelation: foreignTableRelation),
    );
    return _league!;
  }

  _i3.ScheduledMatchTable get __homeMatches {
    if (___homeMatches != null) return ___homeMatches!;
    ___homeMatches = _i1.createRelationTable(
      relationFieldName: '__homeMatches',
      field: Team.t.id,
      foreignField: _i3.ScheduledMatch.t.homeTeamId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ScheduledMatchTable(tableRelation: foreignTableRelation),
    );
    return ___homeMatches!;
  }

  _i3.ScheduledMatchTable get __awayMatches {
    if (___awayMatches != null) return ___awayMatches!;
    ___awayMatches = _i1.createRelationTable(
      relationFieldName: '__awayMatches',
      field: Team.t.id,
      foreignField: _i3.ScheduledMatch.t.awayTeamId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ScheduledMatchTable(tableRelation: foreignTableRelation),
    );
    return ___awayMatches!;
  }

  _i1.ManyRelation<_i3.ScheduledMatchTable> get homeMatches {
    if (_homeMatches != null) return _homeMatches!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'homeMatches',
      field: Team.t.id,
      foreignField: _i3.ScheduledMatch.t.homeTeamId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ScheduledMatchTable(tableRelation: foreignTableRelation),
    );
    _homeMatches = _i1.ManyRelation<_i3.ScheduledMatchTable>(
      tableWithRelations: relationTable,
      table: _i3.ScheduledMatchTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _homeMatches!;
  }

  _i1.ManyRelation<_i3.ScheduledMatchTable> get awayMatches {
    if (_awayMatches != null) return _awayMatches!;
    var relationTable = _i1.createRelationTable(
      relationFieldName: 'awayMatches',
      field: Team.t.id,
      foreignField: _i3.ScheduledMatch.t.awayTeamId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.ScheduledMatchTable(tableRelation: foreignTableRelation),
    );
    _awayMatches = _i1.ManyRelation<_i3.ScheduledMatchTable>(
      tableWithRelations: relationTable,
      table: _i3.ScheduledMatchTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _awayMatches!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    leagueId,
    name,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'league') {
      return league;
    }
    if (relationField == 'homeMatches') {
      return __homeMatches;
    }
    if (relationField == 'awayMatches') {
      return __awayMatches;
    }
    return null;
  }
}

class TeamInclude extends _i1.IncludeObject {
  TeamInclude._({
    _i2.LeagueInclude? league,
    _i3.ScheduledMatchIncludeList? homeMatches,
    _i3.ScheduledMatchIncludeList? awayMatches,
  }) {
    _league = league;
    _homeMatches = homeMatches;
    _awayMatches = awayMatches;
  }

  _i2.LeagueInclude? _league;

  _i3.ScheduledMatchIncludeList? _homeMatches;

  _i3.ScheduledMatchIncludeList? _awayMatches;

  @override
  Map<String, _i1.Include?> get includes => {
    'league': _league,
    'homeMatches': _homeMatches,
    'awayMatches': _awayMatches,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => Team.t;
}

class TeamIncludeList extends _i1.IncludeList {
  TeamIncludeList._({
    _i1.WhereExpressionBuilder<TeamTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Team.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Team.t;
}

class TeamRepository {
  const TeamRepository._();

  final attach = const TeamAttachRepository._();

  final attachRow = const TeamAttachRowRepository._();

  /// Returns a list of [Team]s matching the given query parameters.
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
  Future<List<Team>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TeamTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TeamTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TeamTable>? orderByList,
    _i1.Transaction? transaction,
    TeamInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Team>(
      where: where?.call(Team.t),
      orderBy: orderBy?.call(Team.t),
      orderByList: orderByList?.call(Team.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Team] matching the given query parameters.
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
  Future<Team?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TeamTable>? where,
    int? offset,
    _i1.OrderByBuilder<TeamTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TeamTable>? orderByList,
    _i1.Transaction? transaction,
    TeamInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Team>(
      where: where?.call(Team.t),
      orderBy: orderBy?.call(Team.t),
      orderByList: orderByList?.call(Team.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Team] by its [id] or null if no such row exists.
  Future<Team?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    TeamInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Team>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Team]s in the list and returns the inserted rows.
  ///
  /// The returned [Team]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Team>> insert(
    _i1.DatabaseSession session,
    List<Team> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Team>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Team] and returns the inserted row.
  ///
  /// The returned [Team] will have its `id` field set.
  Future<Team> insertRow(
    _i1.DatabaseSession session,
    Team row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Team>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Team]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Team>> update(
    _i1.DatabaseSession session,
    List<Team> rows, {
    _i1.ColumnSelections<TeamTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Team>(
      rows,
      columns: columns?.call(Team.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Team]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Team> updateRow(
    _i1.DatabaseSession session,
    Team row, {
    _i1.ColumnSelections<TeamTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Team>(
      row,
      columns: columns?.call(Team.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Team] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Team?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<TeamUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Team>(
      id,
      columnValues: columnValues(Team.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Team]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Team>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TeamUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TeamTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TeamTable>? orderBy,
    _i1.OrderByListBuilder<TeamTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Team>(
      columnValues: columnValues(Team.t.updateTable),
      where: where(Team.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Team.t),
      orderByList: orderByList?.call(Team.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Team]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Team>> delete(
    _i1.DatabaseSession session,
    List<Team> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Team>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Team].
  Future<Team> deleteRow(
    _i1.DatabaseSession session,
    Team row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Team>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Team>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TeamTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Team>(
      where: where(Team.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TeamTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Team>(
      where: where?.call(Team.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Team] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TeamTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Team>(
      where: where(Team.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TeamAttachRepository {
  const TeamAttachRepository._();

  /// Creates a relation between this [Team] and the given [ScheduledMatch]s
  /// by setting each [ScheduledMatch]'s foreign key `homeTeamId` to refer to this [Team].
  Future<void> homeMatches(
    _i1.DatabaseSession session,
    Team team,
    List<_i3.ScheduledMatch> scheduledMatch, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledMatch.any((e) => e.id == null)) {
      throw ArgumentError.notNull('scheduledMatch.id');
    }
    if (team.id == null) {
      throw ArgumentError.notNull('team.id');
    }

    var $scheduledMatch = scheduledMatch
        .map((e) => e.copyWith(homeTeamId: team.id))
        .toList();
    await session.db.update<_i3.ScheduledMatch>(
      $scheduledMatch,
      columns: [_i3.ScheduledMatch.t.homeTeamId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Team] and the given [ScheduledMatch]s
  /// by setting each [ScheduledMatch]'s foreign key `awayTeamId` to refer to this [Team].
  Future<void> awayMatches(
    _i1.DatabaseSession session,
    Team team,
    List<_i3.ScheduledMatch> scheduledMatch, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledMatch.any((e) => e.id == null)) {
      throw ArgumentError.notNull('scheduledMatch.id');
    }
    if (team.id == null) {
      throw ArgumentError.notNull('team.id');
    }

    var $scheduledMatch = scheduledMatch
        .map((e) => e.copyWith(awayTeamId: team.id))
        .toList();
    await session.db.update<_i3.ScheduledMatch>(
      $scheduledMatch,
      columns: [_i3.ScheduledMatch.t.awayTeamId],
      transaction: transaction,
    );
  }
}

class TeamAttachRowRepository {
  const TeamAttachRowRepository._();

  /// Creates a relation between the given [Team] and [League]
  /// by setting the [Team]'s foreign key `leagueId` to refer to the [League].
  Future<void> league(
    _i1.DatabaseSession session,
    Team team,
    _i2.League league, {
    _i1.Transaction? transaction,
  }) async {
    if (team.id == null) {
      throw ArgumentError.notNull('team.id');
    }
    if (league.id == null) {
      throw ArgumentError.notNull('league.id');
    }

    var $team = team.copyWith(leagueId: league.id);
    await session.db.updateRow<Team>(
      $team,
      columns: [Team.t.leagueId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Team] and the given [ScheduledMatch]
  /// by setting the [ScheduledMatch]'s foreign key `homeTeamId` to refer to this [Team].
  Future<void> homeMatches(
    _i1.DatabaseSession session,
    Team team,
    _i3.ScheduledMatch scheduledMatch, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledMatch.id == null) {
      throw ArgumentError.notNull('scheduledMatch.id');
    }
    if (team.id == null) {
      throw ArgumentError.notNull('team.id');
    }

    var $scheduledMatch = scheduledMatch.copyWith(homeTeamId: team.id);
    await session.db.updateRow<_i3.ScheduledMatch>(
      $scheduledMatch,
      columns: [_i3.ScheduledMatch.t.homeTeamId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [Team] and the given [ScheduledMatch]
  /// by setting the [ScheduledMatch]'s foreign key `awayTeamId` to refer to this [Team].
  Future<void> awayMatches(
    _i1.DatabaseSession session,
    Team team,
    _i3.ScheduledMatch scheduledMatch, {
    _i1.Transaction? transaction,
  }) async {
    if (scheduledMatch.id == null) {
      throw ArgumentError.notNull('scheduledMatch.id');
    }
    if (team.id == null) {
      throw ArgumentError.notNull('team.id');
    }

    var $scheduledMatch = scheduledMatch.copyWith(awayTeamId: team.id);
    await session.db.updateRow<_i3.ScheduledMatch>(
      $scheduledMatch,
      columns: [_i3.ScheduledMatch.t.awayTeamId],
      transaction: transaction,
    );
  }
}
