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
import '../../teams/models/team_member_role.dart' as _i2;
import '../../teams/models/membership_status.dart' as _i3;
import '../../teams/models/team.dart' as _i4;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i5;
import 'package:bgs_server/src/generated/protocol.dart' as _i6;

/// Links an [AuthUser] to a [Team]. This is how the "Player" and "Manager"
/// roles/dashboards are determined -- there is no standalone role flag on
/// the user, it's derived from having a row here.
abstract class TeamMembership
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  TeamMembership._({
    this.id,
    required this.teamId,
    this.team,
    required this.authUserId,
    this.authUser,
    _i2.TeamMemberRole? role,
    _i3.MembershipStatus? status,
    DateTime? invitedAt,
    this.joinedAt,
  }) : role = role ?? _i2.TeamMemberRole.player,
       status = status ?? _i3.MembershipStatus.invited,
       invitedAt = invitedAt ?? DateTime.now();

  factory TeamMembership({
    _i1.UuidValue? id,
    required _i1.UuidValue teamId,
    _i4.Team? team,
    required _i1.UuidValue authUserId,
    _i5.AuthUser? authUser,
    _i2.TeamMemberRole? role,
    _i3.MembershipStatus? status,
    DateTime? invitedAt,
    DateTime? joinedAt,
  }) = _TeamMembershipImpl;

  factory TeamMembership.fromJson(Map<String, dynamic> jsonSerialization) {
    return TeamMembership(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      teamId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['teamId']),
      team: jsonSerialization['team'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.Team>(jsonSerialization['team']),
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.AuthUser>(
              jsonSerialization['authUser'],
            ),
      role: jsonSerialization['role'] == null
          ? null
          : _i2.TeamMemberRole.fromJson((jsonSerialization['role'] as String)),
      status: jsonSerialization['status'] == null
          ? null
          : _i3.MembershipStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      invitedAt: jsonSerialization['invitedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['invitedAt']),
      joinedAt: jsonSerialization['joinedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['joinedAt']),
    );
  }

  static final t = TeamMembershipTable();

  static const db = TeamMembershipRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue teamId;

  _i4.Team? team;

  _i1.UuidValue authUserId;

  _i5.AuthUser? authUser;

  _i2.TeamMemberRole role;

  _i3.MembershipStatus status;

  DateTime invitedAt;

  DateTime? joinedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [TeamMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TeamMembership copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? teamId,
    _i4.Team? team,
    _i1.UuidValue? authUserId,
    _i5.AuthUser? authUser,
    _i2.TeamMemberRole? role,
    _i3.MembershipStatus? status,
    DateTime? invitedAt,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TeamMembership',
      if (id != null) 'id': id?.toJson(),
      'teamId': teamId.toJson(),
      if (team != null) 'team': team?.toJson(),
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'role': role.toJson(),
      'status': status.toJson(),
      'invitedAt': invitedAt.toJson(),
      if (joinedAt != null) 'joinedAt': joinedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TeamMembership',
      if (id != null) 'id': id?.toJson(),
      'teamId': teamId.toJson(),
      if (team != null) 'team': team?.toJsonForProtocol(),
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJsonForProtocol(),
      'role': role.toJson(),
      'status': status.toJson(),
      'invitedAt': invitedAt.toJson(),
      if (joinedAt != null) 'joinedAt': joinedAt?.toJson(),
    };
  }

  static TeamMembershipInclude include({
    _i4.TeamInclude? team,
    _i5.AuthUserInclude? authUser,
  }) {
    return TeamMembershipInclude._(
      team: team,
      authUser: authUser,
    );
  }

  static TeamMembershipIncludeList includeList({
    _i1.WhereExpressionBuilder<TeamMembershipTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TeamMembershipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TeamMembershipTable>? orderByList,
    TeamMembershipInclude? include,
  }) {
    return TeamMembershipIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TeamMembership.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TeamMembership.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TeamMembershipImpl extends TeamMembership {
  _TeamMembershipImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue teamId,
    _i4.Team? team,
    required _i1.UuidValue authUserId,
    _i5.AuthUser? authUser,
    _i2.TeamMemberRole? role,
    _i3.MembershipStatus? status,
    DateTime? invitedAt,
    DateTime? joinedAt,
  }) : super._(
         id: id,
         teamId: teamId,
         team: team,
         authUserId: authUserId,
         authUser: authUser,
         role: role,
         status: status,
         invitedAt: invitedAt,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [TeamMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TeamMembership copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? teamId,
    Object? team = _Undefined,
    _i1.UuidValue? authUserId,
    Object? authUser = _Undefined,
    _i2.TeamMemberRole? role,
    _i3.MembershipStatus? status,
    DateTime? invitedAt,
    Object? joinedAt = _Undefined,
  }) {
    return TeamMembership(
      id: id is _i1.UuidValue? ? id : this.id,
      teamId: teamId ?? this.teamId,
      team: team is _i4.Team? ? team : this.team?.copyWith(),
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _i5.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      role: role ?? this.role,
      status: status ?? this.status,
      invitedAt: invitedAt ?? this.invitedAt,
      joinedAt: joinedAt is DateTime? ? joinedAt : this.joinedAt,
    );
  }
}

class TeamMembershipUpdateTable extends _i1.UpdateTable<TeamMembershipTable> {
  TeamMembershipUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> teamId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.teamId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> authUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.authUserId,
    value,
  );

  _i1.ColumnValue<_i2.TeamMemberRole, _i2.TeamMemberRole> role(
    _i2.TeamMemberRole value,
  ) => _i1.ColumnValue(
    table.role,
    value,
  );

  _i1.ColumnValue<_i3.MembershipStatus, _i3.MembershipStatus> status(
    _i3.MembershipStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> invitedAt(DateTime value) =>
      _i1.ColumnValue(
        table.invitedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> joinedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.joinedAt,
        value,
      );
}

class TeamMembershipTable extends _i1.Table<_i1.UuidValue?> {
  TeamMembershipTable({super.tableRelation})
    : super(tableName: 'bgs_team_membership') {
    updateTable = TeamMembershipUpdateTable(this);
    teamId = _i1.ColumnUuid(
      'teamId',
      this,
    );
    authUserId = _i1.ColumnUuid(
      'authUserId',
      this,
    );
    role = _i1.ColumnEnum(
      'role',
      this,
      _i1.EnumSerialization.byName,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    invitedAt = _i1.ColumnDateTime(
      'invitedAt',
      this,
    );
    joinedAt = _i1.ColumnDateTime(
      'joinedAt',
      this,
    );
  }

  late final TeamMembershipUpdateTable updateTable;

  late final _i1.ColumnUuid teamId;

  _i4.TeamTable? _team;

  late final _i1.ColumnUuid authUserId;

  _i5.AuthUserTable? _authUser;

  late final _i1.ColumnEnum<_i2.TeamMemberRole> role;

  late final _i1.ColumnEnum<_i3.MembershipStatus> status;

  late final _i1.ColumnDateTime invitedAt;

  late final _i1.ColumnDateTime joinedAt;

  _i4.TeamTable get team {
    if (_team != null) return _team!;
    _team = _i1.createRelationTable(
      relationFieldName: 'team',
      field: TeamMembership.t.teamId,
      foreignField: _i4.Team.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.TeamTable(tableRelation: foreignTableRelation),
    );
    return _team!;
  }

  _i5.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _i1.createRelationTable(
      relationFieldName: 'authUser',
      field: TeamMembership.t.authUserId,
      foreignField: _i5.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _authUser!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    teamId,
    authUserId,
    role,
    status,
    invitedAt,
    joinedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'team') {
      return team;
    }
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class TeamMembershipInclude extends _i1.IncludeObject {
  TeamMembershipInclude._({
    _i4.TeamInclude? team,
    _i5.AuthUserInclude? authUser,
  }) {
    _team = team;
    _authUser = authUser;
  }

  _i4.TeamInclude? _team;

  _i5.AuthUserInclude? _authUser;

  @override
  Map<String, _i1.Include?> get includes => {
    'team': _team,
    'authUser': _authUser,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => TeamMembership.t;
}

class TeamMembershipIncludeList extends _i1.IncludeList {
  TeamMembershipIncludeList._({
    _i1.WhereExpressionBuilder<TeamMembershipTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TeamMembership.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => TeamMembership.t;
}

class TeamMembershipRepository {
  const TeamMembershipRepository._();

  final attachRow = const TeamMembershipAttachRowRepository._();

  /// Returns a list of [TeamMembership]s matching the given query parameters.
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
  Future<List<TeamMembership>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TeamMembershipTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TeamMembershipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TeamMembershipTable>? orderByList,
    _i1.Transaction? transaction,
    TeamMembershipInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TeamMembership>(
      where: where?.call(TeamMembership.t),
      orderBy: orderBy?.call(TeamMembership.t),
      orderByList: orderByList?.call(TeamMembership.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TeamMembership] matching the given query parameters.
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
  Future<TeamMembership?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TeamMembershipTable>? where,
    int? offset,
    _i1.OrderByBuilder<TeamMembershipTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TeamMembershipTable>? orderByList,
    _i1.Transaction? transaction,
    TeamMembershipInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TeamMembership>(
      where: where?.call(TeamMembership.t),
      orderBy: orderBy?.call(TeamMembership.t),
      orderByList: orderByList?.call(TeamMembership.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TeamMembership] by its [id] or null if no such row exists.
  Future<TeamMembership?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    TeamMembershipInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TeamMembership>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TeamMembership]s in the list and returns the inserted rows.
  ///
  /// The returned [TeamMembership]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TeamMembership>> insert(
    _i1.DatabaseSession session,
    List<TeamMembership> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TeamMembership>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TeamMembership] and returns the inserted row.
  ///
  /// The returned [TeamMembership] will have its `id` field set.
  Future<TeamMembership> insertRow(
    _i1.DatabaseSession session,
    TeamMembership row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TeamMembership>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TeamMembership]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TeamMembership>> update(
    _i1.DatabaseSession session,
    List<TeamMembership> rows, {
    _i1.ColumnSelections<TeamMembershipTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TeamMembership>(
      rows,
      columns: columns?.call(TeamMembership.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TeamMembership]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TeamMembership> updateRow(
    _i1.DatabaseSession session,
    TeamMembership row, {
    _i1.ColumnSelections<TeamMembershipTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TeamMembership>(
      row,
      columns: columns?.call(TeamMembership.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TeamMembership] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TeamMembership?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<TeamMembershipUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TeamMembership>(
      id,
      columnValues: columnValues(TeamMembership.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TeamMembership]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TeamMembership>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TeamMembershipUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TeamMembershipTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TeamMembershipTable>? orderBy,
    _i1.OrderByListBuilder<TeamMembershipTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TeamMembership>(
      columnValues: columnValues(TeamMembership.t.updateTable),
      where: where(TeamMembership.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TeamMembership.t),
      orderByList: orderByList?.call(TeamMembership.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TeamMembership]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TeamMembership>> delete(
    _i1.DatabaseSession session,
    List<TeamMembership> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TeamMembership>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TeamMembership].
  Future<TeamMembership> deleteRow(
    _i1.DatabaseSession session,
    TeamMembership row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TeamMembership>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TeamMembership>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TeamMembershipTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TeamMembership>(
      where: where(TeamMembership.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TeamMembershipTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TeamMembership>(
      where: where?.call(TeamMembership.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TeamMembership] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TeamMembershipTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TeamMembership>(
      where: where(TeamMembership.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TeamMembershipAttachRowRepository {
  const TeamMembershipAttachRowRepository._();

  /// Creates a relation between the given [TeamMembership] and [Team]
  /// by setting the [TeamMembership]'s foreign key `teamId` to refer to the [Team].
  Future<void> team(
    _i1.DatabaseSession session,
    TeamMembership teamMembership,
    _i4.Team team, {
    _i1.Transaction? transaction,
  }) async {
    if (teamMembership.id == null) {
      throw ArgumentError.notNull('teamMembership.id');
    }
    if (team.id == null) {
      throw ArgumentError.notNull('team.id');
    }

    var $teamMembership = teamMembership.copyWith(teamId: team.id);
    await session.db.updateRow<TeamMembership>(
      $teamMembership,
      columns: [TeamMembership.t.teamId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [TeamMembership] and [AuthUser]
  /// by setting the [TeamMembership]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _i1.DatabaseSession session,
    TeamMembership teamMembership,
    _i5.AuthUser authUser, {
    _i1.Transaction? transaction,
  }) async {
    if (teamMembership.id == null) {
      throw ArgumentError.notNull('teamMembership.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $teamMembership = teamMembership.copyWith(authUserId: authUser.id);
    await session.db.updateRow<TeamMembership>(
      $teamMembership,
      columns: [TeamMembership.t.authUserId],
      transaction: transaction,
    );
  }
}
