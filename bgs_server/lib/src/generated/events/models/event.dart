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
import '../../events/models/event_status.dart' as _i2;
import '../../organizations/models/organization.dart' as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import '../../sports/models/sport.dart' as _i5;
import '../../sports/models/skill_level.dart' as _i6;
import 'package:bgs_server/src/generated/protocol.dart' as _i7;

/// A one-off event (tournament or single-day activity). May belong to an
/// [Organization], or be "orgless" -- organization is nullable by design.
abstract class Event
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Event._({
    this.id,
    required this.organizationId,
    this.organization,
    required this.createdByAuthUserId,
    this.createdByAuthUser,
    required this.name,
    required this.slug,
    required this.sport,
    this.skillLevel,
    this.description,
    this.location,
    required this.startAt,
    bool? isTournament,
    _i2.EventStatus? status,
    required this.teamFeeCents,
    DateTime? createdAt,
  }) : isTournament = isTournament ?? false,
       status = status ?? _i2.EventStatus.draft,
       createdAt = createdAt ?? DateTime.now();

  factory Event({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    _i3.Organization? organization,
    required _i1.UuidValue createdByAuthUserId,
    _i4.AuthUser? createdByAuthUser,
    required String name,
    required String slug,
    required _i5.Sport sport,
    _i6.SkillLevel? skillLevel,
    String? description,
    String? location,
    required DateTime startAt,
    bool? isTournament,
    _i2.EventStatus? status,
    required int teamFeeCents,
    DateTime? createdAt,
  }) = _EventImpl;

  factory Event.fromJson(Map<String, dynamic> jsonSerialization) {
    return Event(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizationId'],
      ),
      organization: jsonSerialization['organization'] == null
          ? null
          : _i7.Protocol().deserialize<_i3.Organization>(
              jsonSerialization['organization'],
            ),
      createdByAuthUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['createdByAuthUserId'],
      ),
      createdByAuthUser: jsonSerialization['createdByAuthUser'] == null
          ? null
          : _i7.Protocol().deserialize<_i4.AuthUser>(
              jsonSerialization['createdByAuthUser'],
            ),
      name: jsonSerialization['name'] as String,
      slug: jsonSerialization['slug'] as String,
      sport: _i5.Sport.fromJson((jsonSerialization['sport'] as String)),
      skillLevel: jsonSerialization['skillLevel'] == null
          ? null
          : _i6.SkillLevel.fromJson(
              (jsonSerialization['skillLevel'] as String),
            ),
      description: jsonSerialization['description'] as String?,
      location: jsonSerialization['location'] as String?,
      startAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startAt']),
      isTournament: jsonSerialization['isTournament'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isTournament']),
      status: jsonSerialization['status'] == null
          ? null
          : _i2.EventStatus.fromJson((jsonSerialization['status'] as String)),
      teamFeeCents: jsonSerialization['teamFeeCents'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = EventTable();

  static const db = EventRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  _i3.Organization? organization;

  _i1.UuidValue createdByAuthUserId;

  _i4.AuthUser? createdByAuthUser;

  String name;

  /// URL-safe identifier, unique across the platform since orgless events
  /// still need a global shareable link, e.g. /e/<slug>.
  String slug;

  _i5.Sport sport;

  _i6.SkillLevel? skillLevel;

  String? description;

  String? location;

  DateTime startAt;

  /// Whether this event runs as a bracket tournament. Bracket generation
  /// itself is a later phase (see BUILD_PLAN.md Phase 2) -- this just
  /// records intent at creation time.
  bool isTournament;

  _i2.EventStatus status;

  /// Team registration fee, in cents. Same rationale as
  /// League.teamFeeCents -- see League_Platform_Pricing_Model.md.
  int teamFeeCents;

  DateTime createdAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Event]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Event copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i3.Organization? organization,
    _i1.UuidValue? createdByAuthUserId,
    _i4.AuthUser? createdByAuthUser,
    String? name,
    String? slug,
    _i5.Sport? sport,
    _i6.SkillLevel? skillLevel,
    String? description,
    String? location,
    DateTime? startAt,
    bool? isTournament,
    _i2.EventStatus? status,
    int? teamFeeCents,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Event',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      if (organization != null) 'organization': organization?.toJson(),
      'createdByAuthUserId': createdByAuthUserId.toJson(),
      if (createdByAuthUser != null)
        'createdByAuthUser': createdByAuthUser?.toJson(),
      'name': name,
      'slug': slug,
      'sport': sport.toJson(),
      if (skillLevel != null) 'skillLevel': skillLevel?.toJson(),
      if (description != null) 'description': description,
      if (location != null) 'location': location,
      'startAt': startAt.toJson(),
      'isTournament': isTournament,
      'status': status.toJson(),
      'teamFeeCents': teamFeeCents,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Event',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'createdByAuthUserId': createdByAuthUserId.toJson(),
      if (createdByAuthUser != null)
        'createdByAuthUser': createdByAuthUser?.toJsonForProtocol(),
      'name': name,
      'slug': slug,
      'sport': sport.toJson(),
      if (skillLevel != null) 'skillLevel': skillLevel?.toJson(),
      if (description != null) 'description': description,
      if (location != null) 'location': location,
      'startAt': startAt.toJson(),
      'isTournament': isTournament,
      'status': status.toJson(),
      'teamFeeCents': teamFeeCents,
      'createdAt': createdAt.toJson(),
    };
  }

  static EventInclude include({
    _i3.OrganizationInclude? organization,
    _i4.AuthUserInclude? createdByAuthUser,
  }) {
    return EventInclude._(
      organization: organization,
      createdByAuthUser: createdByAuthUser,
    );
  }

  static EventIncludeList includeList({
    _i1.WhereExpressionBuilder<EventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EventTable>? orderByList,
    EventInclude? include,
  }) {
    return EventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Event.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Event.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EventImpl extends Event {
  _EventImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    _i3.Organization? organization,
    required _i1.UuidValue createdByAuthUserId,
    _i4.AuthUser? createdByAuthUser,
    required String name,
    required String slug,
    required _i5.Sport sport,
    _i6.SkillLevel? skillLevel,
    String? description,
    String? location,
    required DateTime startAt,
    bool? isTournament,
    _i2.EventStatus? status,
    required int teamFeeCents,
    DateTime? createdAt,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         createdByAuthUserId: createdByAuthUserId,
         createdByAuthUser: createdByAuthUser,
         name: name,
         slug: slug,
         sport: sport,
         skillLevel: skillLevel,
         description: description,
         location: location,
         startAt: startAt,
         isTournament: isTournament,
         status: status,
         teamFeeCents: teamFeeCents,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Event]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Event copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    Object? organization = _Undefined,
    _i1.UuidValue? createdByAuthUserId,
    Object? createdByAuthUser = _Undefined,
    String? name,
    String? slug,
    _i5.Sport? sport,
    Object? skillLevel = _Undefined,
    Object? description = _Undefined,
    Object? location = _Undefined,
    DateTime? startAt,
    bool? isTournament,
    _i2.EventStatus? status,
    int? teamFeeCents,
    DateTime? createdAt,
  }) {
    return Event(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i3.Organization?
          ? organization
          : this.organization?.copyWith(),
      createdByAuthUserId: createdByAuthUserId ?? this.createdByAuthUserId,
      createdByAuthUser: createdByAuthUser is _i4.AuthUser?
          ? createdByAuthUser
          : this.createdByAuthUser?.copyWith(),
      name: name ?? this.name,
      slug: slug ?? this.slug,
      sport: sport ?? this.sport,
      skillLevel: skillLevel is _i6.SkillLevel? ? skillLevel : this.skillLevel,
      description: description is String? ? description : this.description,
      location: location is String? ? location : this.location,
      startAt: startAt ?? this.startAt,
      isTournament: isTournament ?? this.isTournament,
      status: status ?? this.status,
      teamFeeCents: teamFeeCents ?? this.teamFeeCents,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class EventUpdateTable extends _i1.UpdateTable<EventTable> {
  EventUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> organizationId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> createdByAuthUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.createdByAuthUserId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> slug(String value) => _i1.ColumnValue(
    table.slug,
    value,
  );

  _i1.ColumnValue<_i5.Sport, _i5.Sport> sport(_i5.Sport value) =>
      _i1.ColumnValue(
        table.sport,
        value,
      );

  _i1.ColumnValue<_i6.SkillLevel, _i6.SkillLevel> skillLevel(
    _i6.SkillLevel? value,
  ) => _i1.ColumnValue(
    table.skillLevel,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<String, String> location(String? value) => _i1.ColumnValue(
    table.location,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> startAt(DateTime value) =>
      _i1.ColumnValue(
        table.startAt,
        value,
      );

  _i1.ColumnValue<bool, bool> isTournament(bool value) => _i1.ColumnValue(
    table.isTournament,
    value,
  );

  _i1.ColumnValue<_i2.EventStatus, _i2.EventStatus> status(
    _i2.EventStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> teamFeeCents(int value) => _i1.ColumnValue(
    table.teamFeeCents,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class EventTable extends _i1.Table<_i1.UuidValue?> {
  EventTable({super.tableRelation}) : super(tableName: 'bgs_event') {
    updateTable = EventUpdateTable(this);
    organizationId = _i1.ColumnUuid(
      'organizationId',
      this,
    );
    createdByAuthUserId = _i1.ColumnUuid(
      'createdByAuthUserId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    slug = _i1.ColumnString(
      'slug',
      this,
    );
    sport = _i1.ColumnEnum(
      'sport',
      this,
      _i1.EnumSerialization.byName,
    );
    skillLevel = _i1.ColumnEnum(
      'skillLevel',
      this,
      _i1.EnumSerialization.byName,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    location = _i1.ColumnString(
      'location',
      this,
    );
    startAt = _i1.ColumnDateTime(
      'startAt',
      this,
    );
    isTournament = _i1.ColumnBool(
      'isTournament',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    teamFeeCents = _i1.ColumnInt(
      'teamFeeCents',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final EventUpdateTable updateTable;

  late final _i1.ColumnUuid organizationId;

  _i3.OrganizationTable? _organization;

  late final _i1.ColumnUuid createdByAuthUserId;

  _i4.AuthUserTable? _createdByAuthUser;

  late final _i1.ColumnString name;

  /// URL-safe identifier, unique across the platform since orgless events
  /// still need a global shareable link, e.g. /e/<slug>.
  late final _i1.ColumnString slug;

  late final _i1.ColumnEnum<_i5.Sport> sport;

  late final _i1.ColumnEnum<_i6.SkillLevel> skillLevel;

  late final _i1.ColumnString description;

  late final _i1.ColumnString location;

  late final _i1.ColumnDateTime startAt;

  /// Whether this event runs as a bracket tournament. Bracket generation
  /// itself is a later phase (see BUILD_PLAN.md Phase 2) -- this just
  /// records intent at creation time.
  late final _i1.ColumnBool isTournament;

  late final _i1.ColumnEnum<_i2.EventStatus> status;

  /// Team registration fee, in cents. Same rationale as
  /// League.teamFeeCents -- see League_Platform_Pricing_Model.md.
  late final _i1.ColumnInt teamFeeCents;

  late final _i1.ColumnDateTime createdAt;

  _i3.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: Event.t.organizationId,
      foreignField: _i3.Organization.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.OrganizationTable(tableRelation: foreignTableRelation),
    );
    return _organization!;
  }

  _i4.AuthUserTable get createdByAuthUser {
    if (_createdByAuthUser != null) return _createdByAuthUser!;
    _createdByAuthUser = _i1.createRelationTable(
      relationFieldName: 'createdByAuthUser',
      field: Event.t.createdByAuthUserId,
      foreignField: _i4.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _createdByAuthUser!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    organizationId,
    createdByAuthUserId,
    name,
    slug,
    sport,
    skillLevel,
    description,
    location,
    startAt,
    isTournament,
    status,
    teamFeeCents,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    if (relationField == 'createdByAuthUser') {
      return createdByAuthUser;
    }
    return null;
  }
}

class EventInclude extends _i1.IncludeObject {
  EventInclude._({
    _i3.OrganizationInclude? organization,
    _i4.AuthUserInclude? createdByAuthUser,
  }) {
    _organization = organization;
    _createdByAuthUser = createdByAuthUser;
  }

  _i3.OrganizationInclude? _organization;

  _i4.AuthUserInclude? _createdByAuthUser;

  @override
  Map<String, _i1.Include?> get includes => {
    'organization': _organization,
    'createdByAuthUser': _createdByAuthUser,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => Event.t;
}

class EventIncludeList extends _i1.IncludeList {
  EventIncludeList._({
    _i1.WhereExpressionBuilder<EventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Event.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Event.t;
}

class EventRepository {
  const EventRepository._();

  final attachRow = const EventAttachRowRepository._();

  /// Returns a list of [Event]s matching the given query parameters.
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
  Future<List<Event>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EventTable>? orderByList,
    _i1.Transaction? transaction,
    EventInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Event>(
      where: where?.call(Event.t),
      orderBy: orderBy?.call(Event.t),
      orderByList: orderByList?.call(Event.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Event] matching the given query parameters.
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
  Future<Event?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EventTable>? where,
    int? offset,
    _i1.OrderByBuilder<EventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EventTable>? orderByList,
    _i1.Transaction? transaction,
    EventInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Event>(
      where: where?.call(Event.t),
      orderBy: orderBy?.call(Event.t),
      orderByList: orderByList?.call(Event.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Event] by its [id] or null if no such row exists.
  Future<Event?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    EventInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Event>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Event]s in the list and returns the inserted rows.
  ///
  /// The returned [Event]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Event>> insert(
    _i1.DatabaseSession session,
    List<Event> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Event>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Event] and returns the inserted row.
  ///
  /// The returned [Event] will have its `id` field set.
  Future<Event> insertRow(
    _i1.DatabaseSession session,
    Event row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Event>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Event]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Event>> update(
    _i1.DatabaseSession session,
    List<Event> rows, {
    _i1.ColumnSelections<EventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Event>(
      rows,
      columns: columns?.call(Event.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Event]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Event> updateRow(
    _i1.DatabaseSession session,
    Event row, {
    _i1.ColumnSelections<EventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Event>(
      row,
      columns: columns?.call(Event.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Event] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Event?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<EventUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Event>(
      id,
      columnValues: columnValues(Event.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Event]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Event>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<EventUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<EventTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EventTable>? orderBy,
    _i1.OrderByListBuilder<EventTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Event>(
      columnValues: columnValues(Event.t.updateTable),
      where: where(Event.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Event.t),
      orderByList: orderByList?.call(Event.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Event]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Event>> delete(
    _i1.DatabaseSession session,
    List<Event> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Event>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Event].
  Future<Event> deleteRow(
    _i1.DatabaseSession session,
    Event row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Event>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Event>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<EventTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Event>(
      where: where(Event.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EventTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Event>(
      where: where?.call(Event.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Event] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<EventTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Event>(
      where: where(Event.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class EventAttachRowRepository {
  const EventAttachRowRepository._();

  /// Creates a relation between the given [Event] and [Organization]
  /// by setting the [Event]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    Event event,
    _i3.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (event.id == null) {
      throw ArgumentError.notNull('event.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $event = event.copyWith(organizationId: organization.id);
    await session.db.updateRow<Event>(
      $event,
      columns: [Event.t.organizationId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Event] and [AuthUser]
  /// by setting the [Event]'s foreign key `createdByAuthUserId` to refer to the [AuthUser].
  Future<void> createdByAuthUser(
    _i1.DatabaseSession session,
    Event event,
    _i4.AuthUser createdByAuthUser, {
    _i1.Transaction? transaction,
  }) async {
    if (event.id == null) {
      throw ArgumentError.notNull('event.id');
    }
    if (createdByAuthUser.id == null) {
      throw ArgumentError.notNull('createdByAuthUser.id');
    }

    var $event = event.copyWith(createdByAuthUserId: createdByAuthUser.id);
    await session.db.updateRow<Event>(
      $event,
      columns: [Event.t.createdByAuthUserId],
      transaction: transaction,
    );
  }
}
