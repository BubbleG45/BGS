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
import '../../teams/models/team_membership.dart' as _i2;
import 'package:bgs_client/src/protocol/protocol.dart' as _i3;

/// Aggregated data for the Manager Dashboard -- "my team(s)". Only active
/// `manager`-role memberships; team rosters themselves are fetched
/// separately via TeamEndpoint.listMembers when a specific team is opened,
/// to keep this call cheap. Transient (no `table:`).
abstract class ManagerDashboard implements _i1.SerializableModel {
  ManagerDashboard._({required this.managedTeams});

  factory ManagerDashboard({required List<_i2.TeamMembership> managedTeams}) =
      _ManagerDashboardImpl;

  factory ManagerDashboard.fromJson(Map<String, dynamic> jsonSerialization) {
    return ManagerDashboard(
      managedTeams: _i3.Protocol().deserialize<List<_i2.TeamMembership>>(
        jsonSerialization['managedTeams'],
      ),
    );
  }

  List<_i2.TeamMembership> managedTeams;

  /// Returns a shallow copy of this [ManagerDashboard]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ManagerDashboard copyWith({List<_i2.TeamMembership>? managedTeams});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ManagerDashboard',
      'managedTeams': managedTeams.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ManagerDashboardImpl extends ManagerDashboard {
  _ManagerDashboardImpl({required List<_i2.TeamMembership> managedTeams})
    : super._(managedTeams: managedTeams);

  /// Returns a shallow copy of this [ManagerDashboard]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ManagerDashboard copyWith({List<_i2.TeamMembership>? managedTeams}) {
    return ManagerDashboard(
      managedTeams:
          managedTeams ?? this.managedTeams.map((e0) => e0.copyWith()).toList(),
    );
  }
}
