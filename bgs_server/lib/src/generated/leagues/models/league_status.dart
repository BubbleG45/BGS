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

enum LeagueStatus implements _i1.SerializableModel {
  /// Being set up by the organizer, not visible to players yet.
  draft,

  /// Live -- visible publicly, teams can register/be invited.
  active,

  /// Season has finished.
  completed,
  cancelled;

  static LeagueStatus fromJson(String name) {
    switch (name) {
      case 'draft':
        return LeagueStatus.draft;
      case 'active':
        return LeagueStatus.active;
      case 'completed':
        return LeagueStatus.completed;
      case 'cancelled':
        return LeagueStatus.cancelled;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "LeagueStatus"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
