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

/// Thrown when creating an event with a slug that's already taken.
/// Event slugs are unique platform-wide (not per-org) -- even orgless
/// events need a globally shareable link, e.g. /e/<slug>.
abstract class EventSlugTakenException
    implements _i1.SerializableException, _i1.SerializableModel {
  EventSlugTakenException._({required this.slug});

  factory EventSlugTakenException({required String slug}) =
      _EventSlugTakenExceptionImpl;

  factory EventSlugTakenException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EventSlugTakenException(slug: jsonSerialization['slug'] as String);
  }

  String slug;

  /// Returns a shallow copy of this [EventSlugTakenException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EventSlugTakenException copyWith({String? slug});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventSlugTakenException',
      'slug': slug,
    };
  }

  @override
  String toString() {
    return 'EventSlugTakenException(slug: $slug)';
  }
}

class _EventSlugTakenExceptionImpl extends EventSlugTakenException {
  _EventSlugTakenExceptionImpl({required String slug}) : super._(slug: slug);

  /// Returns a shallow copy of this [EventSlugTakenException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EventSlugTakenException copyWith({String? slug}) {
    return EventSlugTakenException(slug: slug ?? this.slug);
  }
}
