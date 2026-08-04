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
import '../../organizations/models/organization.dart' as _i2;
import '../../leagues/models/league.dart' as _i3;
import '../../events/models/event.dart' as _i4;
import 'package:bgs_client/src/protocol/protocol.dart' as _i5;

/// Combined results for a basic search across organizations, leagues, and
/// events. Transient (no `table:`).
abstract class SearchResults implements _i1.SerializableModel {
  SearchResults._({
    required this.organizations,
    required this.leagues,
    required this.events,
  });

  factory SearchResults({
    required List<_i2.Organization> organizations,
    required List<_i3.League> leagues,
    required List<_i4.Event> events,
  }) = _SearchResultsImpl;

  factory SearchResults.fromJson(Map<String, dynamic> jsonSerialization) {
    return SearchResults(
      organizations: _i5.Protocol().deserialize<List<_i2.Organization>>(
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

  List<_i2.Organization> organizations;

  List<_i3.League> leagues;

  List<_i4.Event> events;

  /// Returns a shallow copy of this [SearchResults]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SearchResults copyWith({
    List<_i2.Organization>? organizations,
    List<_i3.League>? leagues,
    List<_i4.Event>? events,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SearchResults',
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

class _SearchResultsImpl extends SearchResults {
  _SearchResultsImpl({
    required List<_i2.Organization> organizations,
    required List<_i3.League> leagues,
    required List<_i4.Event> events,
  }) : super._(
         organizations: organizations,
         leagues: leagues,
         events: events,
       );

  /// Returns a shallow copy of this [SearchResults]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SearchResults copyWith({
    List<_i2.Organization>? organizations,
    List<_i3.League>? leagues,
    List<_i4.Event>? events,
  }) {
    return SearchResults(
      organizations:
          organizations ??
          this.organizations.map((e0) => e0.copyWith()).toList(),
      leagues: leagues ?? this.leagues.map((e0) => e0.copyWith()).toList(),
      events: events ?? this.events.map((e0) => e0.copyWith()).toList(),
    );
  }
}
