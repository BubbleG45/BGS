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
import '../../leagues/models/league_status.dart' as _i2;
import '../../organizations/models/organization.dart' as _i3;
import '../../sports/models/sport.dart' as _i4;
import '../../sports/models/skill_level.dart' as _i5;
import 'package:bgs_server/src/generated/protocol.dart' as _i6;

/// A full season run by an [Organization] for a single sport.
abstract class League
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  League._({
    this.id,
    required this.organizationId,
    this.organization,
    required this.name,
    required this.slug,
    required this.sport,
    this.skillLevel,
    this.description,
    this.location,
    _i2.LeagueStatus? status,
    required this.teamFeeCents,
    this.seasonStartAt,
    this.seasonEndAt,
    this.registrationOpensAt,
    this.registrationClosesAt,
    this.rulesUrl,
    DateTime? createdAt,
  }) : status = status ?? _i2.LeagueStatus.draft,
       createdAt = createdAt ?? DateTime.now();

  factory League({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    _i3.Organization? organization,
    required String name,
    required String slug,
    required _i4.Sport sport,
    _i5.SkillLevel? skillLevel,
    String? description,
    String? location,
    _i2.LeagueStatus? status,
    required int teamFeeCents,
    DateTime? seasonStartAt,
    DateTime? seasonEndAt,
    DateTime? registrationOpensAt,
    DateTime? registrationClosesAt,
    String? rulesUrl,
    DateTime? createdAt,
  }) = _LeagueImpl;

  factory League.fromJson(Map<String, dynamic> jsonSerialization) {
    return League(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizationId'],
      ),
      organization: jsonSerialization['organization'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.Organization>(
              jsonSerialization['organization'],
            ),
      name: jsonSerialization['name'] as String,
      slug: jsonSerialization['slug'] as String,
      sport: _i4.Sport.fromJson((jsonSerialization['sport'] as String)),
      skillLevel: jsonSerialization['skillLevel'] == null
          ? null
          : _i5.SkillLevel.fromJson(
              (jsonSerialization['skillLevel'] as String),
            ),
      description: jsonSerialization['description'] as String?,
      location: jsonSerialization['location'] as String?,
      status: jsonSerialization['status'] == null
          ? null
          : _i2.LeagueStatus.fromJson((jsonSerialization['status'] as String)),
      teamFeeCents: jsonSerialization['teamFeeCents'] as int,
      seasonStartAt: jsonSerialization['seasonStartAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['seasonStartAt'],
            ),
      seasonEndAt: jsonSerialization['seasonEndAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['seasonEndAt'],
            ),
      registrationOpensAt: jsonSerialization['registrationOpensAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['registrationOpensAt'],
            ),
      registrationClosesAt: jsonSerialization['registrationClosesAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['registrationClosesAt'],
            ),
      rulesUrl: jsonSerialization['rulesUrl'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = LeagueTable();

  static const db = LeagueRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  _i3.Organization? organization;

  String name;

  /// URL-safe identifier, unique within the organization (not globally).
  String slug;

  _i4.Sport sport;

  _i5.SkillLevel? skillLevel;

  String? description;

  /// Free-text venue/area, e.g. "Riverside Park Courts 1-3". Structured
  /// location management is a later phase (see BUILD_PLAN.md Phase 4);
  /// this is enough for Phase 1 display and basic search.
  String? location;

  _i2.LeagueStatus status;

  /// Team registration fee, in cents. Required at creation regardless of
  /// how the organizer actually collects payment -- see
  /// League_Platform_Pricing_Model.md. The platform charge itself is
  /// computed from this in the payments phase; this field just captures it.
  int teamFeeCents;

  /// Season window, both optional. Distinguishes an `active` league whose
  /// season hasn't started yet ("upcoming") from one actually in progress,
  /// for org-page grouping. Not used for any scheduling logic.
  DateTime? seasonStartAt;

  DateTime? seasonEndAt;

  /// Registration window, both optional. Display-only for now -- shown on
  /// the public league page for transparency; not enforced against actual
  /// registration attempts yet (see BUILD_PLAN.md Phase B).
  DateTime? registrationOpensAt;

  DateTime? registrationClosesAt;

  /// Link to an external rules doc/page. Display-only, no validation.
  String? rulesUrl;

  DateTime createdAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [League]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  League copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    _i3.Organization? organization,
    String? name,
    String? slug,
    _i4.Sport? sport,
    _i5.SkillLevel? skillLevel,
    String? description,
    String? location,
    _i2.LeagueStatus? status,
    int? teamFeeCents,
    DateTime? seasonStartAt,
    DateTime? seasonEndAt,
    DateTime? registrationOpensAt,
    DateTime? registrationClosesAt,
    String? rulesUrl,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'League',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      if (organization != null) 'organization': organization?.toJson(),
      'name': name,
      'slug': slug,
      'sport': sport.toJson(),
      if (skillLevel != null) 'skillLevel': skillLevel?.toJson(),
      if (description != null) 'description': description,
      if (location != null) 'location': location,
      'status': status.toJson(),
      'teamFeeCents': teamFeeCents,
      if (seasonStartAt != null) 'seasonStartAt': seasonStartAt?.toJson(),
      if (seasonEndAt != null) 'seasonEndAt': seasonEndAt?.toJson(),
      if (registrationOpensAt != null)
        'registrationOpensAt': registrationOpensAt?.toJson(),
      if (registrationClosesAt != null)
        'registrationClosesAt': registrationClosesAt?.toJson(),
      if (rulesUrl != null) 'rulesUrl': rulesUrl,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'League',
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'name': name,
      'slug': slug,
      'sport': sport.toJson(),
      if (skillLevel != null) 'skillLevel': skillLevel?.toJson(),
      if (description != null) 'description': description,
      if (location != null) 'location': location,
      'status': status.toJson(),
      'teamFeeCents': teamFeeCents,
      if (seasonStartAt != null) 'seasonStartAt': seasonStartAt?.toJson(),
      if (seasonEndAt != null) 'seasonEndAt': seasonEndAt?.toJson(),
      if (registrationOpensAt != null)
        'registrationOpensAt': registrationOpensAt?.toJson(),
      if (registrationClosesAt != null)
        'registrationClosesAt': registrationClosesAt?.toJson(),
      if (rulesUrl != null) 'rulesUrl': rulesUrl,
      'createdAt': createdAt.toJson(),
    };
  }

  static LeagueInclude include({_i3.OrganizationInclude? organization}) {
    return LeagueInclude._(organization: organization);
  }

  static LeagueIncludeList includeList({
    _i1.WhereExpressionBuilder<LeagueTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LeagueTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LeagueTable>? orderByList,
    LeagueInclude? include,
  }) {
    return LeagueIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(League.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(League.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LeagueImpl extends League {
  _LeagueImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    _i3.Organization? organization,
    required String name,
    required String slug,
    required _i4.Sport sport,
    _i5.SkillLevel? skillLevel,
    String? description,
    String? location,
    _i2.LeagueStatus? status,
    required int teamFeeCents,
    DateTime? seasonStartAt,
    DateTime? seasonEndAt,
    DateTime? registrationOpensAt,
    DateTime? registrationClosesAt,
    String? rulesUrl,
    DateTime? createdAt,
  }) : super._(
         id: id,
         organizationId: organizationId,
         organization: organization,
         name: name,
         slug: slug,
         sport: sport,
         skillLevel: skillLevel,
         description: description,
         location: location,
         status: status,
         teamFeeCents: teamFeeCents,
         seasonStartAt: seasonStartAt,
         seasonEndAt: seasonEndAt,
         registrationOpensAt: registrationOpensAt,
         registrationClosesAt: registrationClosesAt,
         rulesUrl: rulesUrl,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [League]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  League copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    Object? organization = _Undefined,
    String? name,
    String? slug,
    _i4.Sport? sport,
    Object? skillLevel = _Undefined,
    Object? description = _Undefined,
    Object? location = _Undefined,
    _i2.LeagueStatus? status,
    int? teamFeeCents,
    Object? seasonStartAt = _Undefined,
    Object? seasonEndAt = _Undefined,
    Object? registrationOpensAt = _Undefined,
    Object? registrationClosesAt = _Undefined,
    Object? rulesUrl = _Undefined,
    DateTime? createdAt,
  }) {
    return League(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i3.Organization?
          ? organization
          : this.organization?.copyWith(),
      name: name ?? this.name,
      slug: slug ?? this.slug,
      sport: sport ?? this.sport,
      skillLevel: skillLevel is _i5.SkillLevel? ? skillLevel : this.skillLevel,
      description: description is String? ? description : this.description,
      location: location is String? ? location : this.location,
      status: status ?? this.status,
      teamFeeCents: teamFeeCents ?? this.teamFeeCents,
      seasonStartAt: seasonStartAt is DateTime?
          ? seasonStartAt
          : this.seasonStartAt,
      seasonEndAt: seasonEndAt is DateTime? ? seasonEndAt : this.seasonEndAt,
      registrationOpensAt: registrationOpensAt is DateTime?
          ? registrationOpensAt
          : this.registrationOpensAt,
      registrationClosesAt: registrationClosesAt is DateTime?
          ? registrationClosesAt
          : this.registrationClosesAt,
      rulesUrl: rulesUrl is String? ? rulesUrl : this.rulesUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class LeagueUpdateTable extends _i1.UpdateTable<LeagueTable> {
  LeagueUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> organizationId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.organizationId,
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

  _i1.ColumnValue<_i4.Sport, _i4.Sport> sport(_i4.Sport value) =>
      _i1.ColumnValue(
        table.sport,
        value,
      );

  _i1.ColumnValue<_i5.SkillLevel, _i5.SkillLevel> skillLevel(
    _i5.SkillLevel? value,
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

  _i1.ColumnValue<_i2.LeagueStatus, _i2.LeagueStatus> status(
    _i2.LeagueStatus value,
  ) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<int, int> teamFeeCents(int value) => _i1.ColumnValue(
    table.teamFeeCents,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> seasonStartAt(DateTime? value) =>
      _i1.ColumnValue(
        table.seasonStartAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> seasonEndAt(DateTime? value) =>
      _i1.ColumnValue(
        table.seasonEndAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> registrationOpensAt(DateTime? value) =>
      _i1.ColumnValue(
        table.registrationOpensAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> registrationClosesAt(DateTime? value) =>
      _i1.ColumnValue(
        table.registrationClosesAt,
        value,
      );

  _i1.ColumnValue<String, String> rulesUrl(String? value) => _i1.ColumnValue(
    table.rulesUrl,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class LeagueTable extends _i1.Table<_i1.UuidValue?> {
  LeagueTable({super.tableRelation}) : super(tableName: 'bgs_league') {
    updateTable = LeagueUpdateTable(this);
    organizationId = _i1.ColumnUuid(
      'organizationId',
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
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    teamFeeCents = _i1.ColumnInt(
      'teamFeeCents',
      this,
    );
    seasonStartAt = _i1.ColumnDateTime(
      'seasonStartAt',
      this,
    );
    seasonEndAt = _i1.ColumnDateTime(
      'seasonEndAt',
      this,
    );
    registrationOpensAt = _i1.ColumnDateTime(
      'registrationOpensAt',
      this,
    );
    registrationClosesAt = _i1.ColumnDateTime(
      'registrationClosesAt',
      this,
    );
    rulesUrl = _i1.ColumnString(
      'rulesUrl',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final LeagueUpdateTable updateTable;

  late final _i1.ColumnUuid organizationId;

  _i3.OrganizationTable? _organization;

  late final _i1.ColumnString name;

  /// URL-safe identifier, unique within the organization (not globally).
  late final _i1.ColumnString slug;

  late final _i1.ColumnEnum<_i4.Sport> sport;

  late final _i1.ColumnEnum<_i5.SkillLevel> skillLevel;

  late final _i1.ColumnString description;

  /// Free-text venue/area, e.g. "Riverside Park Courts 1-3". Structured
  /// location management is a later phase (see BUILD_PLAN.md Phase 4);
  /// this is enough for Phase 1 display and basic search.
  late final _i1.ColumnString location;

  late final _i1.ColumnEnum<_i2.LeagueStatus> status;

  /// Team registration fee, in cents. Required at creation regardless of
  /// how the organizer actually collects payment -- see
  /// League_Platform_Pricing_Model.md. The platform charge itself is
  /// computed from this in the payments phase; this field just captures it.
  late final _i1.ColumnInt teamFeeCents;

  /// Season window, both optional. Distinguishes an `active` league whose
  /// season hasn't started yet ("upcoming") from one actually in progress,
  /// for org-page grouping. Not used for any scheduling logic.
  late final _i1.ColumnDateTime seasonStartAt;

  late final _i1.ColumnDateTime seasonEndAt;

  /// Registration window, both optional. Display-only for now -- shown on
  /// the public league page for transparency; not enforced against actual
  /// registration attempts yet (see BUILD_PLAN.md Phase B).
  late final _i1.ColumnDateTime registrationOpensAt;

  late final _i1.ColumnDateTime registrationClosesAt;

  /// Link to an external rules doc/page. Display-only, no validation.
  late final _i1.ColumnString rulesUrl;

  late final _i1.ColumnDateTime createdAt;

  _i3.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: League.t.organizationId,
      foreignField: _i3.Organization.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.OrganizationTable(tableRelation: foreignTableRelation),
    );
    return _organization!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    organizationId,
    name,
    slug,
    sport,
    skillLevel,
    description,
    location,
    status,
    teamFeeCents,
    seasonStartAt,
    seasonEndAt,
    registrationOpensAt,
    registrationClosesAt,
    rulesUrl,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    return null;
  }
}

class LeagueInclude extends _i1.IncludeObject {
  LeagueInclude._({_i3.OrganizationInclude? organization}) {
    _organization = organization;
  }

  _i3.OrganizationInclude? _organization;

  @override
  Map<String, _i1.Include?> get includes => {'organization': _organization};

  @override
  _i1.Table<_i1.UuidValue?> get table => League.t;
}

class LeagueIncludeList extends _i1.IncludeList {
  LeagueIncludeList._({
    _i1.WhereExpressionBuilder<LeagueTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(League.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => League.t;
}

class LeagueRepository {
  const LeagueRepository._();

  final attachRow = const LeagueAttachRowRepository._();

  /// Returns a list of [League]s matching the given query parameters.
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
  Future<List<League>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LeagueTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LeagueTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LeagueTable>? orderByList,
    _i1.Transaction? transaction,
    LeagueInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<League>(
      where: where?.call(League.t),
      orderBy: orderBy?.call(League.t),
      orderByList: orderByList?.call(League.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [League] matching the given query parameters.
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
  Future<League?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LeagueTable>? where,
    int? offset,
    _i1.OrderByBuilder<LeagueTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LeagueTable>? orderByList,
    _i1.Transaction? transaction,
    LeagueInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<League>(
      where: where?.call(League.t),
      orderBy: orderBy?.call(League.t),
      orderByList: orderByList?.call(League.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [League] by its [id] or null if no such row exists.
  Future<League?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    LeagueInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<League>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [League]s in the list and returns the inserted rows.
  ///
  /// The returned [League]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<League>> insert(
    _i1.DatabaseSession session,
    List<League> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<League>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [League] and returns the inserted row.
  ///
  /// The returned [League] will have its `id` field set.
  Future<League> insertRow(
    _i1.DatabaseSession session,
    League row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<League>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [League]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<League>> update(
    _i1.DatabaseSession session,
    List<League> rows, {
    _i1.ColumnSelections<LeagueTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<League>(
      rows,
      columns: columns?.call(League.t),
      transaction: transaction,
    );
  }

  /// Updates a single [League]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<League> updateRow(
    _i1.DatabaseSession session,
    League row, {
    _i1.ColumnSelections<LeagueTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<League>(
      row,
      columns: columns?.call(League.t),
      transaction: transaction,
    );
  }

  /// Updates a single [League] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<League?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<LeagueUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<League>(
      id,
      columnValues: columnValues(League.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [League]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<League>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<LeagueUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<LeagueTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LeagueTable>? orderBy,
    _i1.OrderByListBuilder<LeagueTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<League>(
      columnValues: columnValues(League.t.updateTable),
      where: where(League.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(League.t),
      orderByList: orderByList?.call(League.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [League]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<League>> delete(
    _i1.DatabaseSession session,
    List<League> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<League>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [League].
  Future<League> deleteRow(
    _i1.DatabaseSession session,
    League row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<League>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<League>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LeagueTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<League>(
      where: where(League.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<LeagueTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<League>(
      where: where?.call(League.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [League] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<LeagueTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<League>(
      where: where(League.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class LeagueAttachRowRepository {
  const LeagueAttachRowRepository._();

  /// Creates a relation between the given [League] and [Organization]
  /// by setting the [League]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.DatabaseSession session,
    League league,
    _i3.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (league.id == null) {
      throw ArgumentError.notNull('league.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $league = league.copyWith(organizationId: organization.id);
    await session.db.updateRow<League>(
      $league,
      columns: [League.t.organizationId],
      transaction: transaction,
    );
  }
}
