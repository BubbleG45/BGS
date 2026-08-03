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

/// Thrown when creating a league with a slug that's already taken within
/// the same organization (league slugs are unique per-org, not globally).
abstract class LeagueSlugTakenException
    implements _i1.SerializableException, _i1.SerializableModel {
  LeagueSlugTakenException._({
    required this.organizationId,
    required this.slug,
  });

  factory LeagueSlugTakenException({
    required _i1.UuidValue organizationId,
    required String slug,
  }) = _LeagueSlugTakenExceptionImpl;

  factory LeagueSlugTakenException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return LeagueSlugTakenException(
      organizationId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizationId'],
      ),
      slug: jsonSerialization['slug'] as String,
    );
  }

  _i1.UuidValue organizationId;

  String slug;

  /// Returns a shallow copy of this [LeagueSlugTakenException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LeagueSlugTakenException copyWith({
    _i1.UuidValue? organizationId,
    String? slug,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LeagueSlugTakenException',
      'organizationId': organizationId.toJson(),
      'slug': slug,
    };
  }

  @override
  String toString() {
    return 'LeagueSlugTakenException(organizationId: $organizationId, slug: $slug)';
  }
}

class _LeagueSlugTakenExceptionImpl extends LeagueSlugTakenException {
  _LeagueSlugTakenExceptionImpl({
    required _i1.UuidValue organizationId,
    required String slug,
  }) : super._(
         organizationId: organizationId,
         slug: slug,
       );

  /// Returns a shallow copy of this [LeagueSlugTakenException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LeagueSlugTakenException copyWith({
    _i1.UuidValue? organizationId,
    String? slug,
  }) {
    return LeagueSlugTakenException(
      organizationId: organizationId ?? this.organizationId,
      slug: slug ?? this.slug,
    );
  }
}
