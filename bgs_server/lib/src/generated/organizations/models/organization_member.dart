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
import '../../organizations/models/organization.dart' as _i2;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i3;
import '../../organizations/models/org_member_role.dart' as _i4;
import 'package:bgs_server/src/generated/protocol.dart' as _i5;

/// Links an [AuthUser] to an [Organization] with an organizer-side role.
///
/// This is how the "Organizer" role/dashboard is determined -- there is no
/// standalone role flag on the user, it's derived from having a row here.
abstract class OrganizationMember
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  OrganizationMember._({
    this.id,
    required this.organizationId,
    this.organization,
    required this.authUserId,
    this.authUser,
    required this.role,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory OrganizationMember({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    _i2.Organization? organization,
    required _i1.UuidValue authUserId,
    _i3.AuthUser? authUser,
    required _i4.OrgMemberRole role,
    DateTime? createdAt,
  }) = _OrganizationMemberImpl;

  factory OrganizationMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrganizationMember(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizationId'],
      ),
      organization: jsonSerialization['organization'] == null
          ? null
          : _i5.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.AuthUser>(
              jsonSerialization['authUser'],
            ),
      role: _i4.OrgMemberRole.fromJson((jsonSerialization['role'] as String)),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = OrganizationMemberTable();

  static const db = OrganizationMemberRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  _i2.Organization? organization;

  _i1.UuidValue authUserId;

  _i3.AuthUser? authUser;

  _i4.OrgMemberRole role;

  DateTime createdAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [OrganizationMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrganizationMember copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i2.Organization? organization,
    _i1.UuidValue? authUserId,
    _i3.AuthUser? authUser,
    _i4.OrgMemberRole? role,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrganizationMember',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      if (organization != null) 'organization': organization?.toJson(),
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'role': role.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OrganizationMember',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJsonForProtocol(),
      'role': role.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static OrganizationMemberInclude include({
    _i2.OrganizationInclude? organization,
    _i3.AuthUserInclude? authUser,
  }) {
    return OrganizationMemberInclude._(
      organization: organization,
      authUser: authUser,
    );
  }

  static OrganizationMemberIncludeList includeList({
    _i1.WhereExpressionBuilder<OrganizationMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrganizationMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationMemberTable>? orderByList,
    OrganizationMemberInclude? include,
  }) {
    return OrganizationMemberIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrganizationMember.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OrganizationMember.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OrganizationMemberImpl extends OrganizationMember {
  _OrganizationMemberImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    _i2.Organization? organization,
    required _i1.UuidValue authUserId,
    _i3.AuthUser? authUser,
    required _i4.OrgMemberRole role,
    DateTime? createdAt,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         authUserId: authUserId,
         authUser: authUser,
         role: role,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [OrganizationMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrganizationMember copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    Object? organization = _Undefined,
    _i1.UuidValue? authUserId,
    Object? authUser = _Undefined,
    _i4.OrgMemberRole? role,
    DateTime? createdAt,
  }) {
    return OrganizationMember(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _i3.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class OrganizationMemberUpdateTable
    extends _i1.UpdateTable<OrganizationMemberTable> {
  OrganizationMemberUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> organizationId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> authUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.authUserId,
    value,
  );

  _i1.ColumnValue<_i4.OrgMemberRole, _i4.OrgMemberRole> role(
    _i4.OrgMemberRole value,
  ) => _i1.ColumnValue(
    table.role,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class OrganizationMemberTable extends _i1.Table<_i1.UuidValue?> {
  OrganizationMemberTable({super.tableRelation})
    : super(tableName: 'bgs_organization_member') {
    updateTable = OrganizationMemberUpdateTable(this);
    organizationId = _i1.ColumnUuid(
      'organizationId',
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
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final OrganizationMemberUpdateTable updateTable;

  late final _i1.ColumnUuid organizationId;

  _i2.OrganizationTable? _organization;

  late final _i1.ColumnUuid authUserId;

  _i3.AuthUserTable? _authUser;

  late final _i1.ColumnEnum<_i4.OrgMemberRole> role;

  late final _i1.ColumnDateTime createdAt;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: OrganizationMember.t.organizationId,
      foreignField: _i2.Organization.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.OrganizationTable(tableRelation: foreignTableRelation),
    );
    return _organization!;
  }

  _i3.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _i1.createRelationTable(
      relationFieldName: 'authUser',
      field: OrganizationMember.t.authUserId,
      foreignField: _i3.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _authUser!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    organizationId,
    authUserId,
    role,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class OrganizationMemberInclude extends _i1.IncludeObject {
  OrganizationMemberInclude._({
    _i2.OrganizationInclude? organization,
    _i3.AuthUserInclude? authUser,
  }) {
    _organization = organization;
    _authUser = authUser;
  }

  _i2.OrganizationInclude? _organization;

  _i3.AuthUserInclude? _authUser;

  @override
  Map<String, _i1.Include?> get includes => {
    'organization': _organization,
    'authUser': _authUser,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => OrganizationMember.t;
}

class OrganizationMemberIncludeList extends _i1.IncludeList {
  OrganizationMemberIncludeList._({
    _i1.WhereExpressionBuilder<OrganizationMemberTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OrganizationMember.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => OrganizationMember.t;
}

class OrganizationMemberRepository {
  const OrganizationMemberRepository._();

  final attachRow = const OrganizationMemberAttachRowRepository._();

  /// Returns a list of [OrganizationMember]s matching the given query parameters.
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
  Future<List<OrganizationMember>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrganizationMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrganizationMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationMemberTable>? orderByList,
    _i1.Transaction? transaction,
    OrganizationMemberInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OrganizationMember>(
      where: where?.call(OrganizationMember.t),
      orderBy: orderBy?.call(OrganizationMember.t),
      orderByList: orderByList?.call(OrganizationMember.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OrganizationMember] matching the given query parameters.
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
  Future<OrganizationMember?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrganizationMemberTable>? where,
    int? offset,
    _i1.OrderByBuilder<OrganizationMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OrganizationMemberTable>? orderByList,
    _i1.Transaction? transaction,
    OrganizationMemberInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OrganizationMember>(
      where: where?.call(OrganizationMember.t),
      orderBy: orderBy?.call(OrganizationMember.t),
      orderByList: orderByList?.call(OrganizationMember.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OrganizationMember] by its [id] or null if no such row exists.
  Future<OrganizationMember?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    OrganizationMemberInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OrganizationMember>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OrganizationMember]s in the list and returns the inserted rows.
  ///
  /// The returned [OrganizationMember]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<OrganizationMember>> insert(
    _i1.DatabaseSession session,
    List<OrganizationMember> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<OrganizationMember>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [OrganizationMember] and returns the inserted row.
  ///
  /// The returned [OrganizationMember] will have its `id` field set.
  Future<OrganizationMember> insertRow(
    _i1.DatabaseSession session,
    OrganizationMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OrganizationMember>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [OrganizationMember]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OrganizationMember>> update(
    _i1.DatabaseSession session,
    List<OrganizationMember> rows, {
    _i1.ColumnSelections<OrganizationMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OrganizationMember>(
      rows,
      columns: columns?.call(OrganizationMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrganizationMember]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OrganizationMember> updateRow(
    _i1.DatabaseSession session,
    OrganizationMember row, {
    _i1.ColumnSelections<OrganizationMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OrganizationMember>(
      row,
      columns: columns?.call(OrganizationMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OrganizationMember] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OrganizationMember?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<OrganizationMemberUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OrganizationMember>(
      id,
      columnValues: columnValues(OrganizationMember.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OrganizationMember]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OrganizationMember>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<OrganizationMemberUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<OrganizationMemberTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OrganizationMemberTable>? orderBy,
    _i1.OrderByListBuilder<OrganizationMemberTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OrganizationMember>(
      columnValues: columnValues(OrganizationMember.t.updateTable),
      where: where(OrganizationMember.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OrganizationMember.t),
      orderByList: orderByList?.call(OrganizationMember.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OrganizationMember]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OrganizationMember>> delete(
    _i1.DatabaseSession session,
    List<OrganizationMember> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OrganizationMember>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [OrganizationMember].
  Future<OrganizationMember> deleteRow(
    _i1.DatabaseSession session,
    OrganizationMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OrganizationMember>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OrganizationMember>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OrganizationMemberTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OrganizationMember>(
      where: where(OrganizationMember.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OrganizationMemberTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OrganizationMember>(
      where: where?.call(OrganizationMember.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OrganizationMember] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OrganizationMemberTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OrganizationMember>(
      where: where(OrganizationMember.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class OrganizationMemberAttachRowRepository {
  const OrganizationMemberAttachRowRepository._();

  /// Creates a relation between the given [OrganizationMember] and [Organization]
  /// by setting the [OrganizationMember]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    OrganizationMember organizationMember,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (organizationMember.id == null) {
      throw ArgumentError.notNull('organizationMember.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $organizationMember = organizationMember.copyWith(
      organizationId: organization.id,
    );
    await session.db.updateRow<OrganizationMember>(
      $organizationMember,
      columns: [OrganizationMember.t.organizationId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [OrganizationMember] and [AuthUser]
  /// by setting the [OrganizationMember]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _i1.DatabaseSession session,
    OrganizationMember organizationMember,
    _i3.AuthUser authUser, {
    _i1.Transaction? transaction,
  }) async {
    if (organizationMember.id == null) {
      throw ArgumentError.notNull('organizationMember.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $organizationMember = organizationMember.copyWith(
      authUserId: authUser.id,
    );
    await session.db.updateRow<OrganizationMember>(
      $organizationMember,
      columns: [OrganizationMember.t.authUserId],
      transaction: transaction,
    );
  }
}
