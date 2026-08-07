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
import '../../events/models/event_status.dart' as _i2;
import '../../organizations/models/organization.dart' as _i3;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i4;
import '../../sports/models/sport.dart' as _i5;
import '../../sports/models/skill_level.dart' as _i6;
import 'package:bgs_client/src/protocol/protocol.dart' as _i7;

/// A one-off event (tournament or single-day activity). May belong to an
/// [Organization], or be "orgless" -- organization is nullable by design.
abstract class Event implements _i1.SerializableModel {
  Event._({
    this.id,
    this.organizationId,
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
    this.registrationOpensAt,
    this.registrationClosesAt,
    this.rulesUrl,
    DateTime? createdAt,
  }) : isTournament = isTournament ?? false,
       status = status ?? _i2.EventStatus.draft,
       createdAt = createdAt ?? DateTime.now();

  factory Event({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
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
    DateTime? registrationOpensAt,
    DateTime? registrationClosesAt,
    String? rulesUrl,
    DateTime? createdAt,
  }) = _EventImpl;

  factory Event.fromJson(Map<String, dynamic> jsonSerialization) {
    return Event(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: jsonSerialization['organizationId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue? organizationId;

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

  /// Registration window, both optional. Display-only for now -- same
  /// rationale as League.registrationOpensAt/registrationClosesAt.
  DateTime? registrationOpensAt;

  DateTime? registrationClosesAt;

  /// Link to an external rules doc/page. Display-only, no validation.
  String? rulesUrl;

  DateTime createdAt;

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
    DateTime? registrationOpensAt,
    DateTime? registrationClosesAt,
    String? rulesUrl,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Event',
      if (id != null) 'id': id?.toJson(),
      if (organizationId != null) 'organizationId': organizationId?.toJson(),
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
      if (registrationOpensAt != null)
        'registrationOpensAt': registrationOpensAt?.toJson(),
      if (registrationClosesAt != null)
        'registrationClosesAt': registrationClosesAt?.toJson(),
      if (rulesUrl != null) 'rulesUrl': rulesUrl,
      'createdAt': createdAt.toJson(),
    };
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
    _i1.UuidValue? organizationId,
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
    DateTime? registrationOpensAt,
    DateTime? registrationClosesAt,
    String? rulesUrl,
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
         registrationOpensAt: registrationOpensAt,
         registrationClosesAt: registrationClosesAt,
         rulesUrl: rulesUrl,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Event]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Event copyWith({
    Object? id = _Undefined,
    Object? organizationId = _Undefined,
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
    Object? registrationOpensAt = _Undefined,
    Object? registrationClosesAt = _Undefined,
    Object? rulesUrl = _Undefined,
    DateTime? createdAt,
  }) {
    return Event(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId is _i1.UuidValue?
          ? organizationId
          : this.organizationId,
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
