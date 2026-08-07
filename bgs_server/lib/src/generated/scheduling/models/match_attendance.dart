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
import '../../scheduling/models/scheduled_match.dart' as _i2;
import '../../teams/models/team_membership.dart' as _i3;
import '../../scheduling/models/attendance_status.dart' as _i4;
import 'package:bgs_server/src/generated/protocol.dart' as _i5;

/// Whether a specific roster member (by [TeamMembership], not directly by
/// user -- so a record is naturally scoped to one team's roster) was
/// present or absent for a [ScheduledMatch]. Lightweight v1: recorded
/// after the fact by whoever manages the team, not a player-facing RSVP
/// (see BUILD_PLAN.md for that deferred feature).
abstract class MatchAttendance
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  MatchAttendance._({
    this.id,
    required this.matchId,
    this.match,
    required this.teamMembershipId,
    this.teamMembership,
    required this.status,
    DateTime? recordedAt,
  }) : recordedAt = recordedAt ?? DateTime.now();

  factory MatchAttendance({
    _i1.UuidValue? id,
    required _i1.UuidValue matchId,
    _i2.ScheduledMatch? match,
    required _i1.UuidValue teamMembershipId,
    _i3.TeamMembership? teamMembership,
    required _i4.AttendanceStatus status,
    DateTime? recordedAt,
  }) = _MatchAttendanceImpl;

  factory MatchAttendance.fromJson(Map<String, dynamic> jsonSerialization) {
    return MatchAttendance(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      matchId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['matchId'],
      ),
      match: jsonSerialization['match'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.ScheduledMatch>(
              jsonSerialization['match'],
            ),
      teamMembershipId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['teamMembershipId'],
      ),
      teamMembership: jsonSerialization['teamMembership'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.TeamMembership>(
              jsonSerialization['teamMembership'],
            ),
      status: _i4.AttendanceStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      recordedAt: jsonSerialization['recordedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['recordedAt']),
    );
  }

  static final t = MatchAttendanceTable();

  static const db = MatchAttendanceRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue matchId;

  _i2.ScheduledMatch? match;

  _i1.UuidValue teamMembershipId;

  _i3.TeamMembership? teamMembership;

  _i4.AttendanceStatus status;

  DateTime recordedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [MatchAttendance]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MatchAttendance copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? matchId,
    _i2.ScheduledMatch? match,
    _i1.UuidValue? teamMembershipId,
    _i3.TeamMembership? teamMembership,
    _i4.AttendanceStatus? status,
    DateTime? recordedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MatchAttendance',
      if (id != null) 'id': id?.toJson(),
      'matchId': matchId.toJson(),
      if (match != null) 'match': match?.toJson(),
      'teamMembershipId': teamMembershipId.toJson(),
      if (teamMembership != null) 'teamMembership': teamMembership?.toJson(),
      'status': status.toJson(),
      'recordedAt': recordedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MatchAttendance',
      if (id != null) 'id': id?.toJson(),
      'matchId': matchId.toJson(),
      if (match != null) 'match': match?.toJsonForProtocol(),
      'teamMembershipId': teamMembershipId.toJson(),
      if (teamMembership != null)
        'teamMembership': teamMembership?.toJsonForProtocol(),
      'status': status.toJson(),
      'recordedAt': recordedAt.toJson(),
    };
  }

  static MatchAttendanceInclude include({
    _i2.ScheduledMatchInclude? match,
    _i3.TeamMembershipInclude? teamMembership,
  }) {
    return MatchAttendanceInclude._(
      match: match,
      teamMembership: teamMembership,
    );
  }

  static MatchAttendanceIncludeList includeList({
    _i1.WhereExpressionBuilder<MatchAttendanceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MatchAttendanceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MatchAttendanceTable>? orderByList,
    MatchAttendanceInclude? include,
  }) {
    return MatchAttendanceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MatchAttendance.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MatchAttendance.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MatchAttendanceImpl extends MatchAttendance {
  _MatchAttendanceImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue matchId,
    _i2.ScheduledMatch? match,
    required _i1.UuidValue teamMembershipId,
    _i3.TeamMembership? teamMembership,
    required _i4.AttendanceStatus status,
    DateTime? recordedAt,
  }) : super._(
         id: id,
         matchId: matchId,
         match: match,
         teamMembershipId: teamMembershipId,
         teamMembership: teamMembership,
         status: status,
         recordedAt: recordedAt,
       );

  /// Returns a shallow copy of this [MatchAttendance]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MatchAttendance copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? matchId,
    Object? match = _Undefined,
    _i1.UuidValue? teamMembershipId,
    Object? teamMembership = _Undefined,
    _i4.AttendanceStatus? status,
    DateTime? recordedAt,
  }) {
    return MatchAttendance(
      id: id is _i1.UuidValue? ? id : this.id,
      matchId: matchId ?? this.matchId,
      match: match is _i2.ScheduledMatch? ? match : this.match?.copyWith(),
      teamMembershipId: teamMembershipId ?? this.teamMembershipId,
      teamMembership: teamMembership is _i3.TeamMembership?
          ? teamMembership
          : this.teamMembership?.copyWith(),
      status: status ?? this.status,
      recordedAt: recordedAt ?? this.recordedAt,
    );
  }
}

class MatchAttendanceUpdateTable extends _i1.UpdateTable<MatchAttendanceTable> {
  MatchAttendanceUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> matchId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.matchId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> teamMembershipId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.teamMembershipId,
    value,
  );

  _i1.ColumnValue<_i4.AttendanceStatus, _i4.AttendanceStatus> status(
    _i4.AttendanceStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> recordedAt(DateTime value) =>
      _i1.ColumnValue(
        table.recordedAt,
        value,
      );
}

class MatchAttendanceTable extends _i1.Table<_i1.UuidValue?> {
  MatchAttendanceTable({super.tableRelation})
    : super(tableName: 'bgs_match_attendance') {
    updateTable = MatchAttendanceUpdateTable(this);
    matchId = _i1.ColumnUuid(
      'matchId',
      this,
    );
    teamMembershipId = _i1.ColumnUuid(
      'teamMembershipId',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    recordedAt = _i1.ColumnDateTime(
      'recordedAt',
      this,
    );
  }

  late final MatchAttendanceUpdateTable updateTable;

  late final _i1.ColumnUuid matchId;

  _i2.ScheduledMatchTable? _match;

  late final _i1.ColumnUuid teamMembershipId;

  _i3.TeamMembershipTable? _teamMembership;

  late final _i1.ColumnEnum<_i4.AttendanceStatus> status;

  late final _i1.ColumnDateTime recordedAt;

  _i2.ScheduledMatchTable get match {
    if (_match != null) return _match!;
    _match = _i1.createRelationTable(
      relationFieldName: 'match',
      field: MatchAttendance.t.matchId,
      foreignField: _i2.ScheduledMatch.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ScheduledMatchTable(tableRelation: foreignTableRelation),
    );
    return _match!;
  }

  _i3.TeamMembershipTable get teamMembership {
    if (_teamMembership != null) return _teamMembership!;
    _teamMembership = _i1.createRelationTable(
      relationFieldName: 'teamMembership',
      field: MatchAttendance.t.teamMembershipId,
      foreignField: _i3.TeamMembership.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.TeamMembershipTable(tableRelation: foreignTableRelation),
    );
    return _teamMembership!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    matchId,
    teamMembershipId,
    status,
    recordedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'match') {
      return match;
    }
    if (relationField == 'teamMembership') {
      return teamMembership;
    }
    return null;
  }
}

class MatchAttendanceInclude extends _i1.IncludeObject {
  MatchAttendanceInclude._({
    _i2.ScheduledMatchInclude? match,
    _i3.TeamMembershipInclude? teamMembership,
  }) {
    _match = match;
    _teamMembership = teamMembership;
  }

  _i2.ScheduledMatchInclude? _match;

  _i3.TeamMembershipInclude? _teamMembership;

  @override
  Map<String, _i1.Include?> get includes => {
    'match': _match,
    'teamMembership': _teamMembership,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => MatchAttendance.t;
}

class MatchAttendanceIncludeList extends _i1.IncludeList {
  MatchAttendanceIncludeList._({
    _i1.WhereExpressionBuilder<MatchAttendanceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MatchAttendance.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => MatchAttendance.t;
}

class MatchAttendanceRepository {
  const MatchAttendanceRepository._();

  final attachRow = const MatchAttendanceAttachRowRepository._();

  /// Returns a list of [MatchAttendance]s matching the given query parameters.
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
  Future<List<MatchAttendance>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MatchAttendanceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MatchAttendanceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MatchAttendanceTable>? orderByList,
    _i1.Transaction? transaction,
    MatchAttendanceInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MatchAttendance>(
      where: where?.call(MatchAttendance.t),
      orderBy: orderBy?.call(MatchAttendance.t),
      orderByList: orderByList?.call(MatchAttendance.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MatchAttendance] matching the given query parameters.
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
  Future<MatchAttendance?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MatchAttendanceTable>? where,
    int? offset,
    _i1.OrderByBuilder<MatchAttendanceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MatchAttendanceTable>? orderByList,
    _i1.Transaction? transaction,
    MatchAttendanceInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MatchAttendance>(
      where: where?.call(MatchAttendance.t),
      orderBy: orderBy?.call(MatchAttendance.t),
      orderByList: orderByList?.call(MatchAttendance.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MatchAttendance] by its [id] or null if no such row exists.
  Future<MatchAttendance?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    MatchAttendanceInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MatchAttendance>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MatchAttendance]s in the list and returns the inserted rows.
  ///
  /// The returned [MatchAttendance]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<MatchAttendance>> insert(
    _i1.DatabaseSession session,
    List<MatchAttendance> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<MatchAttendance>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [MatchAttendance] and returns the inserted row.
  ///
  /// The returned [MatchAttendance] will have its `id` field set.
  Future<MatchAttendance> insertRow(
    _i1.DatabaseSession session,
    MatchAttendance row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MatchAttendance>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MatchAttendance]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MatchAttendance>> update(
    _i1.DatabaseSession session,
    List<MatchAttendance> rows, {
    _i1.ColumnSelections<MatchAttendanceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MatchAttendance>(
      rows,
      columns: columns?.call(MatchAttendance.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MatchAttendance]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MatchAttendance> updateRow(
    _i1.DatabaseSession session,
    MatchAttendance row, {
    _i1.ColumnSelections<MatchAttendanceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MatchAttendance>(
      row,
      columns: columns?.call(MatchAttendance.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MatchAttendance] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MatchAttendance?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<MatchAttendanceUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<MatchAttendance>(
      id,
      columnValues: columnValues(MatchAttendance.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MatchAttendance]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<MatchAttendance>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<MatchAttendanceUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<MatchAttendanceTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MatchAttendanceTable>? orderBy,
    _i1.OrderByListBuilder<MatchAttendanceTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<MatchAttendance>(
      columnValues: columnValues(MatchAttendance.t.updateTable),
      where: where(MatchAttendance.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MatchAttendance.t),
      orderByList: orderByList?.call(MatchAttendance.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [MatchAttendance]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MatchAttendance>> delete(
    _i1.DatabaseSession session,
    List<MatchAttendance> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MatchAttendance>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MatchAttendance].
  Future<MatchAttendance> deleteRow(
    _i1.DatabaseSession session,
    MatchAttendance row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MatchAttendance>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MatchAttendance>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MatchAttendanceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MatchAttendance>(
      where: where(MatchAttendance.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MatchAttendanceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MatchAttendance>(
      where: where?.call(MatchAttendance.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MatchAttendance] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MatchAttendanceTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MatchAttendance>(
      where: where(MatchAttendance.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class MatchAttendanceAttachRowRepository {
  const MatchAttendanceAttachRowRepository._();

  /// Creates a relation between the given [MatchAttendance] and [ScheduledMatch]
  /// by setting the [MatchAttendance]'s foreign key `matchId` to refer to the [ScheduledMatch].
  Future<void> match(
    _i1.DatabaseSession session,
    MatchAttendance matchAttendance,
    _i2.ScheduledMatch match, {
    _i1.Transaction? transaction,
  }) async {
    if (matchAttendance.id == null) {
      throw ArgumentError.notNull('matchAttendance.id');
    }
    if (match.id == null) {
      throw ArgumentError.notNull('match.id');
    }

    var $matchAttendance = matchAttendance.copyWith(matchId: match.id);
    await session.db.updateRow<MatchAttendance>(
      $matchAttendance,
      columns: [MatchAttendance.t.matchId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [MatchAttendance] and [TeamMembership]
  /// by setting the [MatchAttendance]'s foreign key `teamMembershipId` to refer to the [TeamMembership].
  Future<void> teamMembership(
    _i1.DatabaseSession session,
    MatchAttendance matchAttendance,
    _i3.TeamMembership teamMembership, {
    _i1.Transaction? transaction,
  }) async {
    if (matchAttendance.id == null) {
      throw ArgumentError.notNull('matchAttendance.id');
    }
    if (teamMembership.id == null) {
      throw ArgumentError.notNull('teamMembership.id');
    }

    var $matchAttendance = matchAttendance.copyWith(
      teamMembershipId: teamMembership.id,
    );
    await session.db.updateRow<MatchAttendance>(
      $matchAttendance,
      columns: [MatchAttendance.t.teamMembershipId],
      transaction: transaction,
    );
  }
}
