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
import '../../events/models/event_registration_status.dart' as _i2;
import '../../events/models/event.dart' as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'package:bgs_server/src/generated/protocol.dart' as _i5;

/// A single registration for an [Event] by the [AuthUser] who signed up.
///
/// Kept minimal for Phase 1 -- no persistent Team link, since events
/// aren't necessarily tied to a league [Team].
abstract class EventRegistration
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  EventRegistration._({
    this.id,
    required this.eventId,
    this.event,
    required this.registeredByAuthUserId,
    this.registeredByAuthUser,
    this.teamName,
    _i2.EventRegistrationStatus? status,
    DateTime? createdAt,
  }) : status = status ?? _i2.EventRegistrationStatus.registered,
       createdAt = createdAt ?? DateTime.now();

  factory EventRegistration({
    _i1.UuidValue? id,
    required _i1.UuidValue eventId,
    _i3.Event? event,
    required _i1.UuidValue registeredByAuthUserId,
    _i4.AuthUser? registeredByAuthUser,
    String? teamName,
    _i2.EventRegistrationStatus? status,
    DateTime? createdAt,
  }) = _EventRegistrationImpl;

  factory EventRegistration.fromJson(Map<String, dynamic> jsonSerialization) {
    return EventRegistration(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      eventId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['eventId'],
      ),
      event: jsonSerialization['event'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Event>(jsonSerialization['event']),
      registeredByAuthUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['registeredByAuthUserId'],
      ),
      registeredByAuthUser: jsonSerialization['registeredByAuthUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.AuthUser>(
              jsonSerialization['registeredByAuthUser'],
            ),
      teamName: jsonSerialization['teamName'] as String?,
      status: jsonSerialization['status'] == null
          ? null
          : _i2.EventRegistrationStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = EventRegistrationTable();

  static const db = EventRegistrationRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue eventId;

  _i3.Event? event;

  _i1.UuidValue registeredByAuthUserId;

  _i4.AuthUser? registeredByAuthUser;

  /// Free-text team/group name for this registration, if applicable.
  String? teamName;

  _i2.EventRegistrationStatus status;

  DateTime createdAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [EventRegistration]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EventRegistration copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? eventId,
    _i3.Event? event,
    _i1.UuidValue? registeredByAuthUserId,
    _i4.AuthUser? registeredByAuthUser,
    String? teamName,
    _i2.EventRegistrationStatus? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventRegistration',
      if (id != null) 'id': id?.toJson(),
      'eventId': eventId.toJson(),
      if (event != null) 'event': event?.toJson(),
      'registeredByAuthUserId': registeredByAuthUserId.toJson(),
      if (registeredByAuthUser != null)
        'registeredByAuthUser': registeredByAuthUser?.toJson(),
      if (teamName != null) 'teamName': teamName,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'EventRegistration',
      if (id != null) 'id': id?.toJson(),
      'eventId': eventId.toJson(),
      if (event != null) 'event': event?.toJsonForProtocol(),
      'registeredByAuthUserId': registeredByAuthUserId.toJson(),
      if (registeredByAuthUser != null)
        'registeredByAuthUser': registeredByAuthUser?.toJsonForProtocol(),
      if (teamName != null) 'teamName': teamName,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static EventRegistrationInclude include({
    _i3.EventInclude? event,
    _i4.AuthUserInclude? registeredByAuthUser,
  }) {
    return EventRegistrationInclude._(
      event: event,
      registeredByAuthUser: registeredByAuthUser,
    );
  }

  static EventRegistrationIncludeList includeList({
    _i1.WhereExpressionBuilder<EventRegistrationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EventRegistrationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EventRegistrationTable>? orderByList,
    EventRegistrationInclude? include,
  }) {
    return EventRegistrationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EventRegistration.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(EventRegistration.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EventRegistrationImpl extends EventRegistration {
  _EventRegistrationImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue eventId,
    _i3.Event? event,
    required _i1.UuidValue registeredByAuthUserId,
    _i4.AuthUser? registeredByAuthUser,
    String? teamName,
    _i2.EventRegistrationStatus? status,
    DateTime? createdAt,
  }) : super._(
         id: id,
         eventId: eventId,
         event: event,
         registeredByAuthUserId: registeredByAuthUserId,
         registeredByAuthUser: registeredByAuthUser,
         teamName: teamName,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [EventRegistration]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EventRegistration copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? eventId,
    Object? event = _Undefined,
    _i1.UuidValue? registeredByAuthUserId,
    Object? registeredByAuthUser = _Undefined,
    Object? teamName = _Undefined,
    _i2.EventRegistrationStatus? status,
    DateTime? createdAt,
  }) {
    return EventRegistration(
      id: id is _i1.UuidValue? ? id : this.id,
      eventId: eventId ?? this.eventId,
      event: event is _i3.Event? ? event : this.event?.copyWith(),
      registeredByAuthUserId:
          registeredByAuthUserId ?? this.registeredByAuthUserId,
      registeredByAuthUser: registeredByAuthUser is _i4.AuthUser?
          ? registeredByAuthUser
          : this.registeredByAuthUser?.copyWith(),
      teamName: teamName is String? ? teamName : this.teamName,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class EventRegistrationUpdateTable
    extends _i1.UpdateTable<EventRegistrationTable> {
  EventRegistrationUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> eventId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.eventId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> registeredByAuthUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.registeredByAuthUserId,
    value,
  );

  _i1.ColumnValue<String, String> teamName(String? value) => _i1.ColumnValue(
    table.teamName,
    value,
  );

  _i1.ColumnValue<_i2.EventRegistrationStatus, _i2.EventRegistrationStatus>
  status(_i2.EventRegistrationStatus value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class EventRegistrationTable extends _i1.Table<_i1.UuidValue?> {
  EventRegistrationTable({super.tableRelation})
    : super(tableName: 'bgs_event_registration') {
    updateTable = EventRegistrationUpdateTable(this);
    eventId = _i1.ColumnUuid(
      'eventId',
      this,
    );
    registeredByAuthUserId = _i1.ColumnUuid(
      'registeredByAuthUserId',
      this,
    );
    teamName = _i1.ColumnString(
      'teamName',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final EventRegistrationUpdateTable updateTable;

  late final _i1.ColumnUuid eventId;

  _i3.EventTable? _event;

  late final _i1.ColumnUuid registeredByAuthUserId;

  _i4.AuthUserTable? _registeredByAuthUser;

  /// Free-text team/group name for this registration, if applicable.
  late final _i1.ColumnString teamName;

  late final _i1.ColumnEnum<_i2.EventRegistrationStatus> status;

  late final _i1.ColumnDateTime createdAt;

  _i3.EventTable get event {
    if (_event != null) return _event!;
    _event = _i1.createRelationTable(
      relationFieldName: 'event',
      field: EventRegistration.t.eventId,
      foreignField: _i3.Event.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.EventTable(tableRelation: foreignTableRelation),
    );
    return _event!;
  }

  _i4.AuthUserTable get registeredByAuthUser {
    if (_registeredByAuthUser != null) return _registeredByAuthUser!;
    _registeredByAuthUser = _i1.createRelationTable(
      relationFieldName: 'registeredByAuthUser',
      field: EventRegistration.t.registeredByAuthUserId,
      foreignField: _i4.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _registeredByAuthUser!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    eventId,
    registeredByAuthUserId,
    teamName,
    status,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'event') {
      return event;
    }
    if (relationField == 'registeredByAuthUser') {
      return registeredByAuthUser;
    }
    return null;
  }
}

class EventRegistrationInclude extends _i1.IncludeObject {
  EventRegistrationInclude._({
    _i3.EventInclude? event,
    _i4.AuthUserInclude? registeredByAuthUser,
  }) {
    _event = event;
    _registeredByAuthUser = registeredByAuthUser;
  }

  _i3.EventInclude? _event;

  _i4.AuthUserInclude? _registeredByAuthUser;

  @override
  Map<String, _i1.Include?> get includes => {
    'event': _event,
    'registeredByAuthUser': _registeredByAuthUser,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => EventRegistration.t;
}

class EventRegistrationIncludeList extends _i1.IncludeList {
  EventRegistrationIncludeList._({
    _i1.WhereExpressionBuilder<EventRegistrationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(EventRegistration.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => EventRegistration.t;
}

class EventRegistrationRepository {
  const EventRegistrationRepository._();

  final attachRow = const EventRegistrationAttachRowRepository._();

  /// Returns a list of [EventRegistration]s matching the given query parameters.
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
  Future<List<EventRegistration>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EventRegistrationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EventRegistrationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EventRegistrationTable>? orderByList,
    _i1.Transaction? transaction,
    EventRegistrationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<EventRegistration>(
      where: where?.call(EventRegistration.t),
      orderBy: orderBy?.call(EventRegistration.t),
      orderByList: orderByList?.call(EventRegistration.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [EventRegistration] matching the given query parameters.
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
  Future<EventRegistration?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EventRegistrationTable>? where,
    int? offset,
    _i1.OrderByBuilder<EventRegistrationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EventRegistrationTable>? orderByList,
    _i1.Transaction? transaction,
    EventRegistrationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<EventRegistration>(
      where: where?.call(EventRegistration.t),
      orderBy: orderBy?.call(EventRegistration.t),
      orderByList: orderByList?.call(EventRegistration.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [EventRegistration] by its [id] or null if no such row exists.
  Future<EventRegistration?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    EventRegistrationInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<EventRegistration>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [EventRegistration]s in the list and returns the inserted rows.
  ///
  /// The returned [EventRegistration]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<EventRegistration>> insert(
    _i1.DatabaseSession session,
    List<EventRegistration> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<EventRegistration>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [EventRegistration] and returns the inserted row.
  ///
  /// The returned [EventRegistration] will have its `id` field set.
  Future<EventRegistration> insertRow(
    _i1.DatabaseSession session,
    EventRegistration row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<EventRegistration>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [EventRegistration]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<EventRegistration>> update(
    _i1.DatabaseSession session,
    List<EventRegistration> rows, {
    _i1.ColumnSelections<EventRegistrationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<EventRegistration>(
      rows,
      columns: columns?.call(EventRegistration.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EventRegistration]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<EventRegistration> updateRow(
    _i1.DatabaseSession session,
    EventRegistration row, {
    _i1.ColumnSelections<EventRegistrationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<EventRegistration>(
      row,
      columns: columns?.call(EventRegistration.t),
      transaction: transaction,
    );
  }

  /// Updates a single [EventRegistration] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<EventRegistration?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<EventRegistrationUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<EventRegistration>(
      id,
      columnValues: columnValues(EventRegistration.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [EventRegistration]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<EventRegistration>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<EventRegistrationUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<EventRegistrationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EventRegistrationTable>? orderBy,
    _i1.OrderByListBuilder<EventRegistrationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<EventRegistration>(
      columnValues: columnValues(EventRegistration.t.updateTable),
      where: where(EventRegistration.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(EventRegistration.t),
      orderByList: orderByList?.call(EventRegistration.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [EventRegistration]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<EventRegistration>> delete(
    _i1.DatabaseSession session,
    List<EventRegistration> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<EventRegistration>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [EventRegistration].
  Future<EventRegistration> deleteRow(
    _i1.DatabaseSession session,
    EventRegistration row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<EventRegistration>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<EventRegistration>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<EventRegistrationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<EventRegistration>(
      where: where(EventRegistration.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EventRegistrationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<EventRegistration>(
      where: where?.call(EventRegistration.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [EventRegistration] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<EventRegistrationTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<EventRegistration>(
      where: where(EventRegistration.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class EventRegistrationAttachRowRepository {
  const EventRegistrationAttachRowRepository._();

  /// Creates a relation between the given [EventRegistration] and [Event]
  /// by setting the [EventRegistration]'s foreign key `eventId` to refer to the [Event].
  Future<void> event(
    _i1.DatabaseSession session,
    EventRegistration eventRegistration,
    _i3.Event event, {
    _i1.Transaction? transaction,
  }) async {
    if (eventRegistration.id == null) {
      throw ArgumentError.notNull('eventRegistration.id');
    }
    if (event.id == null) {
      throw ArgumentError.notNull('event.id');
    }

    var $eventRegistration = eventRegistration.copyWith(eventId: event.id);
    await session.db.updateRow<EventRegistration>(
      $eventRegistration,
      columns: [EventRegistration.t.eventId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [EventRegistration] and [AuthUser]
  /// by setting the [EventRegistration]'s foreign key `registeredByAuthUserId` to refer to the [AuthUser].
  Future<void> registeredByAuthUser(
    _i1.DatabaseSession session,
    EventRegistration eventRegistration,
    _i4.AuthUser registeredByAuthUser, {
    _i1.Transaction? transaction,
  }) async {
    if (eventRegistration.id == null) {
      throw ArgumentError.notNull('eventRegistration.id');
    }
    if (registeredByAuthUser.id == null) {
      throw ArgumentError.notNull('registeredByAuthUser.id');
    }

    var $eventRegistration = eventRegistration.copyWith(
      registeredByAuthUserId: registeredByAuthUser.id,
    );
    await session.db.updateRow<EventRegistration>(
      $eventRegistration,
      columns: [EventRegistration.t.registeredByAuthUserId],
      transaction: transaction,
    );
  }
}
