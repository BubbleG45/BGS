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
import '../../teams/models/team.dart' as _i3;
import 'package:bgs_server/src/generated/protocol.dart' as _i4;

/// A team's basic win/loss record within a [League]. Recomputed/updated as
/// [ScheduledMatch] results come in -- not itself the source of truth for
/// match results, just the aggregate.
abstract class Standing
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
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

  static final t = StandingTable();

  static const db = StandingRepository._();

  @override
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

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Standing',
      if (id != null) 'id': id?.toJson(),
      'leagueId': leagueId.toJson(),
      if (league != null) 'league': league?.toJsonForProtocol(),
      'teamId': teamId.toJson(),
      if (team != null) 'team': team?.toJsonForProtocol(),
      'wins': wins,
      'losses': losses,
      'ties': ties,
      'pointsFor': pointsFor,
      'pointsAgainst': pointsAgainst,
    };
  }

  static StandingInclude include({
    _i2.LeagueInclude? league,
    _i3.TeamInclude? team,
  }) {
    return StandingInclude._(
      league: league,
      team: team,
    );
  }

  static StandingIncludeList includeList({
    _i1.WhereExpressionBuilder<StandingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StandingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StandingTable>? orderByList,
    StandingInclude? include,
  }) {
    return StandingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Standing.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Standing.t),
      include: include,
    );
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

class StandingUpdateTable extends _i1.UpdateTable<StandingTable> {
  StandingUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> leagueId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.leagueId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> teamId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.teamId,
        value,
      );

  _i1.ColumnValue<int, int> wins(int value) => _i1.ColumnValue(
    table.wins,
    value,
  );

  _i1.ColumnValue<int, int> losses(int value) => _i1.ColumnValue(
    table.losses,
    value,
  );

  _i1.ColumnValue<int, int> ties(int value) => _i1.ColumnValue(
    table.ties,
    value,
  );

  _i1.ColumnValue<int, int> pointsFor(int value) => _i1.ColumnValue(
    table.pointsFor,
    value,
  );

  _i1.ColumnValue<int, int> pointsAgainst(int value) => _i1.ColumnValue(
    table.pointsAgainst,
    value,
  );
}

class StandingTable extends _i1.Table<_i1.UuidValue?> {
  StandingTable({super.tableRelation}) : super(tableName: 'bgs_standing') {
    updateTable = StandingUpdateTable(this);
    leagueId = _i1.ColumnUuid(
      'leagueId',
      this,
    );
    teamId = _i1.ColumnUuid(
      'teamId',
      this,
    );
    wins = _i1.ColumnInt(
      'wins',
      this,
    );
    losses = _i1.ColumnInt(
      'losses',
      this,
    );
    ties = _i1.ColumnInt(
      'ties',
      this,
    );
    pointsFor = _i1.ColumnInt(
      'pointsFor',
      this,
    );
    pointsAgainst = _i1.ColumnInt(
      'pointsAgainst',
      this,
    );
  }

  late final StandingUpdateTable updateTable;

  late final _i1.ColumnUuid leagueId;

  _i2.LeagueTable? _league;

  late final _i1.ColumnUuid teamId;

  _i3.TeamTable? _team;

  late final _i1.ColumnInt wins;

  late final _i1.ColumnInt losses;

  late final _i1.ColumnInt ties;

  late final _i1.ColumnInt pointsFor;

  late final _i1.ColumnInt pointsAgainst;

  _i2.LeagueTable get league {
    if (_league != null) return _league!;
    _league = _i1.createRelationTable(
      relationFieldName: 'league',
      field: Standing.t.leagueId,
      foreignField: _i2.League.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.LeagueTable(tableRelation: foreignTableRelation),
    );
    return _league!;
  }

  _i3.TeamTable get team {
    if (_team != null) return _team!;
    _team = _i1.createRelationTable(
      relationFieldName: 'team',
      field: Standing.t.teamId,
      foreignField: _i3.Team.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.TeamTable(tableRelation: foreignTableRelation),
    );
    return _team!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    leagueId,
    teamId,
    wins,
    losses,
    ties,
    pointsFor,
    pointsAgainst,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'league') {
      return league;
    }
    if (relationField == 'team') {
      return team;
    }
    return null;
  }
}

class StandingInclude extends _i1.IncludeObject {
  StandingInclude._({
    _i2.LeagueInclude? league,
    _i3.TeamInclude? team,
  }) {
    _league = league;
    _team = team;
  }

  _i2.LeagueInclude? _league;

  _i3.TeamInclude? _team;

  @override
  Map<String, _i1.Include?> get includes => {
    'league': _league,
    'team': _team,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => Standing.t;
}

class StandingIncludeList extends _i1.IncludeList {
  StandingIncludeList._({
    _i1.WhereExpressionBuilder<StandingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Standing.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Standing.t;
}

class StandingRepository {
  const StandingRepository._();

  final attachRow = const StandingAttachRowRepository._();

  /// Returns a list of [Standing]s matching the given query parameters.
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
  Future<List<Standing>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StandingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StandingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StandingTable>? orderByList,
    _i1.Transaction? transaction,
    StandingInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Standing>(
      where: where?.call(Standing.t),
      orderBy: orderBy?.call(Standing.t),
      orderByList: orderByList?.call(Standing.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Standing] matching the given query parameters.
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
  Future<Standing?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StandingTable>? where,
    int? offset,
    _i1.OrderByBuilder<StandingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StandingTable>? orderByList,
    _i1.Transaction? transaction,
    StandingInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Standing>(
      where: where?.call(Standing.t),
      orderBy: orderBy?.call(Standing.t),
      orderByList: orderByList?.call(Standing.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Standing] by its [id] or null if no such row exists.
  Future<Standing?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    StandingInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Standing>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Standing]s in the list and returns the inserted rows.
  ///
  /// The returned [Standing]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Standing>> insert(
    _i1.DatabaseSession session,
    List<Standing> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Standing>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Standing] and returns the inserted row.
  ///
  /// The returned [Standing] will have its `id` field set.
  Future<Standing> insertRow(
    _i1.DatabaseSession session,
    Standing row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Standing>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Standing]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Standing>> update(
    _i1.DatabaseSession session,
    List<Standing> rows, {
    _i1.ColumnSelections<StandingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Standing>(
      rows,
      columns: columns?.call(Standing.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Standing]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Standing> updateRow(
    _i1.DatabaseSession session,
    Standing row, {
    _i1.ColumnSelections<StandingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Standing>(
      row,
      columns: columns?.call(Standing.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Standing] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Standing?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<StandingUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Standing>(
      id,
      columnValues: columnValues(Standing.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Standing]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Standing>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<StandingUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StandingTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StandingTable>? orderBy,
    _i1.OrderByListBuilder<StandingTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Standing>(
      columnValues: columnValues(Standing.t.updateTable),
      where: where(Standing.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Standing.t),
      orderByList: orderByList?.call(Standing.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Standing]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Standing>> delete(
    _i1.DatabaseSession session,
    List<Standing> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Standing>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Standing].
  Future<Standing> deleteRow(
    _i1.DatabaseSession session,
    Standing row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Standing>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Standing>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StandingTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Standing>(
      where: where(Standing.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<StandingTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Standing>(
      where: where?.call(Standing.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Standing] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<StandingTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Standing>(
      where: where(Standing.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class StandingAttachRowRepository {
  const StandingAttachRowRepository._();

  /// Creates a relation between the given [Standing] and [League]
  /// by setting the [Standing]'s foreign key `leagueId` to refer to the [League].
  Future<void> league(
    _i1.DatabaseSession session,
    Standing standing,
    _i2.League league, {
    _i1.Transaction? transaction,
  }) async {
    if (standing.id == null) {
      throw ArgumentError.notNull('standing.id');
    }
    if (league.id == null) {
      throw ArgumentError.notNull('league.id');
    }

    var $standing = standing.copyWith(leagueId: league.id);
    await session.db.updateRow<Standing>(
      $standing,
      columns: [Standing.t.leagueId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Standing] and [Team]
  /// by setting the [Standing]'s foreign key `teamId` to refer to the [Team].
  Future<void> team(
    _i1.DatabaseSession session,
    Standing standing,
    _i3.Team team, {
    _i1.Transaction? transaction,
  }) async {
    if (standing.id == null) {
      throw ArgumentError.notNull('standing.id');
    }
    if (team.id == null) {
      throw ArgumentError.notNull('team.id');
    }

    var $standing = standing.copyWith(teamId: team.id);
    await session.db.updateRow<Standing>(
      $standing,
      columns: [Standing.t.teamId],
      transaction: transaction,
    );
  }
}
