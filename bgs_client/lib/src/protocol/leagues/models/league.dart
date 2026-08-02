/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../leagues/models/league_status.dart' as _i2;
import '../../organizations/models/organization.dart' as _i3;
import '../../sports/models/sport.dart' as _i4;
import '../../sports/models/skill_level.dart' as _i5;
import 'package:bgs_client/src/protocol/protocol.dart' as _i6;

/// A full season run by an [Organization] for a single sport.
abstract class League implements _i1.SerializableModel {
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
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  DateTime createdAt;

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
      'createdAt': createdAt.toJson(),
    };
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
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
