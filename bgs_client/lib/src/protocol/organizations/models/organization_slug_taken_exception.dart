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

/// Thrown when creating or renaming an [Organization] to a slug that's
/// already taken.
abstract class OrganizationSlugTakenException
    implements _i1.SerializableException, _i1.SerializableModel {
  OrganizationSlugTakenException._({required this.slug});

  factory OrganizationSlugTakenException({required String slug}) =
      _OrganizationSlugTakenExceptionImpl;

  factory OrganizationSlugTakenException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return OrganizationSlugTakenException(
      slug: jsonSerialization['slug'] as String,
    );
  }

  String slug;

  /// Returns a shallow copy of this [OrganizationSlugTakenException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrganizationSlugTakenException copyWith({String? slug});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrganizationSlugTakenException',
      'slug': slug,
    };
  }

  @override
  String toString() {
    return 'OrganizationSlugTakenException(slug: $slug)';
  }
}

class _OrganizationSlugTakenExceptionImpl
    extends OrganizationSlugTakenException {
  _OrganizationSlugTakenExceptionImpl({required String slug})
    : super._(slug: slug);

  /// Returns a shallow copy of this [OrganizationSlugTakenException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrganizationSlugTakenException copyWith({String? slug}) {
    return OrganizationSlugTakenException(slug: slug ?? this.slug);
  }
}
