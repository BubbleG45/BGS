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
import '../../organizations/models/organization_membership.dart' as _i2;
import '../../leagues/models/league.dart' as _i3;
import '../../events/models/event.dart' as _i4;
import 'package:bgs_client/src/protocol/protocol.dart' as _i5;

/// Aggregated data for the Organizer Dashboard -- "my orgs/leagues/events".
/// Transient (no `table:`).
abstract class OrganizerDashboard implements _i1.SerializableModel {
  OrganizerDashboard._({
    required this.organizations,
    required this.leagues,
    required this.events,
  });

  factory OrganizerDashboard({
    required List<_i2.OrganizationMembership> organizations,
    required List<_i3.League> leagues,
    required List<_i4.Event> events,
  }) = _OrganizerDashboardImpl;

  factory OrganizerDashboard.fromJson(Map<String, dynamic> jsonSerialization) {
    return OrganizerDashboard(
      organizations: _i5.Protocol()
          .deserialize<List<_i2.OrganizationMembership>>(
            jsonSerialization['organizations'],
          ),
      leagues: _i5.Protocol().deserialize<List<_i3.League>>(
        jsonSerialization['leagues'],
      ),
      events: _i5.Protocol().deserialize<List<_i4.Event>>(
        jsonSerialization['events'],
      ),
    );
  }

  List<_i2.OrganizationMembership> organizations;

  List<_i3.League> leagues;

  /// Org-scoped events across the calling user's organizations, plus any
  /// orgless events they created themselves.
  List<_i4.Event> events;

  /// Returns a shallow copy of this [OrganizerDashboard]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OrganizerDashboard copyWith({
    List<_i2.OrganizationMembership>? organizations,
    List<_i3.League>? leagues,
    List<_i4.Event>? events,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OrganizerDashboard',
      'organizations': organizations.toJson(valueToJson: (v) => v.toJson()),
      'leagues': leagues.toJson(valueToJson: (v) => v.toJson()),
      'events': events.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _OrganizerDashboardImpl extends OrganizerDashboard {
  _OrganizerDashboardImpl({
    required List<_i2.OrganizationMembership> organizations,
    required List<_i3.League> leagues,
    required List<_i4.Event> events,
  }) : super._(
         organizations: organizations,
         leagues: leagues,
         events: events,
       );

  /// Returns a shallow copy of this [OrganizerDashboard]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OrganizerDashboard copyWith({
    List<_i2.OrganizationMembership>? organizations,
    List<_i3.League>? leagues,
    List<_i4.Event>? events,
  }) {
    return OrganizerDashboard(
      organizations:
          organizations ??
          this.organizations.map((e0) => e0.copyWith()).toList(),
      leagues: leagues ?? this.leagues.map((e0) => e0.copyWith()).toList(),
      events: events ?? this.events.map((e0) => e0.copyWith()).toList(),
    );
  }
}
