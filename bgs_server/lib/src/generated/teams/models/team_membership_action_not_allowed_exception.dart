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
import '../../teams/models/membership_status.dart' as _i2;

/// Thrown when accepting/declining a membership that isn't currently
/// `invited` (e.g. already accepted or declined).
abstract class TeamMembershipActionNotAllowedException
    implements
        _i1.SerializableException,
        _i1.SerializableModel,
        _i1.ProtocolSerialization {
  TeamMembershipActionNotAllowedException._({
    required this.membershipId,
    required this.currentStatus,
  });

  factory TeamMembershipActionNotAllowedException({
    required _i1.UuidValue membershipId,
    required _i2.MembershipStatus currentStatus,
  }) = _TeamMembershipActionNotAllowedExceptionImpl;

  factory TeamMembershipActionNotAllowedException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return TeamMembershipActionNotAllowedException(
      membershipId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['membershipId'],
      ),
      currentStatus: _i2.MembershipStatus.fromJson(
        (jsonSerialization['currentStatus'] as String),
      ),
    );
  }

  _i1.UuidValue membershipId;

  _i2.MembershipStatus currentStatus;

  /// Returns a shallow copy of this [TeamMembershipActionNotAllowedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TeamMembershipActionNotAllowedException copyWith({
    _i1.UuidValue? membershipId,
    _i2.MembershipStatus? currentStatus,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TeamMembershipActionNotAllowedException',
      'membershipId': membershipId.toJson(),
      'currentStatus': currentStatus.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TeamMembershipActionNotAllowedException',
      'membershipId': membershipId.toJson(),
      'currentStatus': currentStatus.toJson(),
    };
  }

  @override
  String toString() {
    return 'TeamMembershipActionNotAllowedException(membershipId: $membershipId, currentStatus: $currentStatus)';
  }
}

class _TeamMembershipActionNotAllowedExceptionImpl
    extends TeamMembershipActionNotAllowedException {
  _TeamMembershipActionNotAllowedExceptionImpl({
    required _i1.UuidValue membershipId,
    required _i2.MembershipStatus currentStatus,
  }) : super._(
         membershipId: membershipId,
         currentStatus: currentStatus,
       );

  /// Returns a shallow copy of this [TeamMembershipActionNotAllowedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TeamMembershipActionNotAllowedException copyWith({
    _i1.UuidValue? membershipId,
    _i2.MembershipStatus? currentStatus,
  }) {
    return TeamMembershipActionNotAllowedException(
      membershipId: membershipId ?? this.membershipId,
      currentStatus: currentStatus ?? this.currentStatus,
    );
  }
}
