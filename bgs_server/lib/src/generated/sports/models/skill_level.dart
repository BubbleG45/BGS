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
import 'package:serverpod/serverpod.dart' as _i1;

/// Roughly how competitive a league or event is. Used for display and
/// search/filtering (see BUILD_PLAN.md Phase 1 basic search).
enum SkillLevel implements _i1.SerializableModel {
  beginner,
  intermediate,
  competitive;

  static SkillLevel fromJson(String name) {
    switch (name) {
      case 'beginner':
        return SkillLevel.beginner;
      case 'intermediate':
        return SkillLevel.intermediate;
      case 'competitive':
        return SkillLevel.competitive;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "SkillLevel"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
