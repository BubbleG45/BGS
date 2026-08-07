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
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i2;
import 'package:bgs_server/src/generated/protocol.dart' as _i3;

/// BGS-owned profile extension -- `UserProfile` itself belongs to the auth
/// module and can't have fields added to it directly. One row per user,
/// created lazily on first write. Also the natural future home for
/// per-sport positions once that gets designed (see BUILD_PLAN.md).
abstract class PlayerProfile
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  PlayerProfile._({
    this.id,
    required this.authUserId,
    this.authUser,
    this.bio,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  factory PlayerProfile({
    _i1.UuidValue? id,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    String? bio,
    DateTime? updatedAt,
  }) = _PlayerProfileImpl;

  factory PlayerProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlayerProfile(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.AuthUser>(
              jsonSerialization['authUser'],
            ),
      bio: jsonSerialization['bio'] as String?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = PlayerProfileTable();

  static const db = PlayerProfileRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue authUserId;

  _i2.AuthUser? authUser;

  String? bio;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [PlayerProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PlayerProfile copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? authUserId,
    _i2.AuthUser? authUser,
    String? bio,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlayerProfile',
      if (id != null) 'id': id?.toJson(),
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      if (bio != null) 'bio': bio,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlayerProfile',
      if (id != null) 'id': id?.toJson(),
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJsonForProtocol(),
      if (bio != null) 'bio': bio,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static PlayerProfileInclude include({_i2.AuthUserInclude? authUser}) {
    return PlayerProfileInclude._(authUser: authUser);
  }

  static PlayerProfileIncludeList includeList({
    _i1.WhereExpressionBuilder<PlayerProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlayerProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlayerProfileTable>? orderByList,
    PlayerProfileInclude? include,
  }) {
    return PlayerProfileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlayerProfile.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(PlayerProfile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlayerProfileImpl extends PlayerProfile {
  _PlayerProfileImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    String? bio,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         bio: bio,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [PlayerProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PlayerProfile copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? authUserId,
    Object? authUser = _Undefined,
    Object? bio = _Undefined,
    DateTime? updatedAt,
  }) {
    return PlayerProfile(
      id: id is _i1.UuidValue? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _i2.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      bio: bio is String? ? bio : this.bio,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class PlayerProfileUpdateTable extends _i1.UpdateTable<PlayerProfileTable> {
  PlayerProfileUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> authUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.authUserId,
    value,
  );

  _i1.ColumnValue<String, String> bio(String? value) => _i1.ColumnValue(
    table.bio,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class PlayerProfileTable extends _i1.Table<_i1.UuidValue?> {
  PlayerProfileTable({super.tableRelation})
    : super(tableName: 'bgs_player_profile') {
    updateTable = PlayerProfileUpdateTable(this);
    authUserId = _i1.ColumnUuid(
      'authUserId',
      this,
    );
    bio = _i1.ColumnString(
      'bio',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final PlayerProfileUpdateTable updateTable;

  late final _i1.ColumnUuid authUserId;

  _i2.AuthUserTable? _authUser;

  late final _i1.ColumnString bio;

  late final _i1.ColumnDateTime updatedAt;

  _i2.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _i1.createRelationTable(
      relationFieldName: 'authUser',
      field: PlayerProfile.t.authUserId,
      foreignField: _i2.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _authUser!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    authUserId,
    bio,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class PlayerProfileInclude extends _i1.IncludeObject {
  PlayerProfileInclude._({_i2.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _i2.AuthUserInclude? _authUser;

  @override
  Map<String, _i1.Include?> get includes => {'authUser': _authUser};

  @override
  _i1.Table<_i1.UuidValue?> get table => PlayerProfile.t;
}

class PlayerProfileIncludeList extends _i1.IncludeList {
  PlayerProfileIncludeList._({
    _i1.WhereExpressionBuilder<PlayerProfileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PlayerProfile.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => PlayerProfile.t;
}

class PlayerProfileRepository {
  const PlayerProfileRepository._();

  final attachRow = const PlayerProfileAttachRowRepository._();

  /// Returns a list of [PlayerProfile]s matching the given query parameters.
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
  Future<List<PlayerProfile>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PlayerProfileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlayerProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlayerProfileTable>? orderByList,
    _i1.Transaction? transaction,
    PlayerProfileInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PlayerProfile>(
      where: where?.call(PlayerProfile.t),
      orderBy: orderBy?.call(PlayerProfile.t),
      orderByList: orderByList?.call(PlayerProfile.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PlayerProfile] matching the given query parameters.
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
  Future<PlayerProfile?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PlayerProfileTable>? where,
    int? offset,
    _i1.OrderByBuilder<PlayerProfileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlayerProfileTable>? orderByList,
    _i1.Transaction? transaction,
    PlayerProfileInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PlayerProfile>(
      where: where?.call(PlayerProfile.t),
      orderBy: orderBy?.call(PlayerProfile.t),
      orderByList: orderByList?.call(PlayerProfile.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PlayerProfile] by its [id] or null if no such row exists.
  Future<PlayerProfile?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    PlayerProfileInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PlayerProfile>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PlayerProfile]s in the list and returns the inserted rows.
  ///
  /// The returned [PlayerProfile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<PlayerProfile>> insert(
    _i1.DatabaseSession session,
    List<PlayerProfile> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<PlayerProfile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [PlayerProfile] and returns the inserted row.
  ///
  /// The returned [PlayerProfile] will have its `id` field set.
  Future<PlayerProfile> insertRow(
    _i1.DatabaseSession session,
    PlayerProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<PlayerProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [PlayerProfile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<PlayerProfile>> update(
    _i1.DatabaseSession session,
    List<PlayerProfile> rows, {
    _i1.ColumnSelections<PlayerProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<PlayerProfile>(
      rows,
      columns: columns?.call(PlayerProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlayerProfile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PlayerProfile> updateRow(
    _i1.DatabaseSession session,
    PlayerProfile row, {
    _i1.ColumnSelections<PlayerProfileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<PlayerProfile>(
      row,
      columns: columns?.call(PlayerProfile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlayerProfile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PlayerProfile?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<PlayerProfileUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<PlayerProfile>(
      id,
      columnValues: columnValues(PlayerProfile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PlayerProfile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<PlayerProfile>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PlayerProfileUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PlayerProfileTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlayerProfileTable>? orderBy,
    _i1.OrderByListBuilder<PlayerProfileTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<PlayerProfile>(
      columnValues: columnValues(PlayerProfile.t.updateTable),
      where: where(PlayerProfile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlayerProfile.t),
      orderByList: orderByList?.call(PlayerProfile.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [PlayerProfile]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<PlayerProfile>> delete(
    _i1.DatabaseSession session,
    List<PlayerProfile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<PlayerProfile>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [PlayerProfile].
  Future<PlayerProfile> deleteRow(
    _i1.DatabaseSession session,
    PlayerProfile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PlayerProfile>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<PlayerProfile>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PlayerProfileTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<PlayerProfile>(
      where: where(PlayerProfile.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PlayerProfileTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<PlayerProfile>(
      where: where?.call(PlayerProfile.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PlayerProfile] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PlayerProfileTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PlayerProfile>(
      where: where(PlayerProfile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class PlayerProfileAttachRowRepository {
  const PlayerProfileAttachRowRepository._();

  /// Creates a relation between the given [PlayerProfile] and [AuthUser]
  /// by setting the [PlayerProfile]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _i1.DatabaseSession session,
    PlayerProfile playerProfile,
    _i2.AuthUser authUser, {
    _i1.Transaction? transaction,
  }) async {
    if (playerProfile.id == null) {
      throw ArgumentError.notNull('playerProfile.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $playerProfile = playerProfile.copyWith(authUserId: authUser.id);
    await session.db.updateRow<PlayerProfile>(
      $playerProfile,
      columns: [PlayerProfile.t.authUserId],
      transaction: transaction,
    );
  }
}
