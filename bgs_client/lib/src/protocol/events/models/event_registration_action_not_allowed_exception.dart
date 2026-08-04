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
import '../../events/models/event_registration_status.dart' as _i2;

/// Thrown when trying to cancel a registration that isn't currently
/// `registered` (e.g. already cancelled).
abstract class EventRegistrationActionNotAllowedException
    implements _i1.SerializableException, _i1.SerializableModel {
  EventRegistrationActionNotAllowedException._({
    required this.registrationId,
    required this.currentStatus,
  });

  factory EventRegistrationActionNotAllowedException({
    required _i1.UuidValue registrationId,
    required _i2.EventRegistrationStatus currentStatus,
  }) = _EventRegistrationActionNotAllowedExceptionImpl;

  factory EventRegistrationActionNotAllowedException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EventRegistrationActionNotAllowedException(
      registrationId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['registrationId'],
      ),
      currentStatus: _i2.EventRegistrationStatus.fromJson(
        (jsonSerialization['currentStatus'] as String),
      ),
    );
  }

  _i1.UuidValue registrationId;

  _i2.EventRegistrationStatus currentStatus;

  /// Returns a shallow copy of this [EventRegistrationActionNotAllowedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EventRegistrationActionNotAllowedException copyWith({
    _i1.UuidValue? registrationId,
    _i2.EventRegistrationStatus? currentStatus,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventRegistrationActionNotAllowedException',
      'registrationId': registrationId.toJson(),
      'currentStatus': currentStatus.toJson(),
    };
  }

  @override
  String toString() {
    return 'EventRegistrationActionNotAllowedException(registrationId: $registrationId, currentStatus: $currentStatus)';
  }
}

class _EventRegistrationActionNotAllowedExceptionImpl
    extends EventRegistrationActionNotAllowedException {
  _EventRegistrationActionNotAllowedExceptionImpl({
    required _i1.UuidValue registrationId,
    required _i2.EventRegistrationStatus currentStatus,
  }) : super._(
         registrationId: registrationId,
         currentStatus: currentStatus,
       );

  /// Returns a shallow copy of this [EventRegistrationActionNotAllowedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EventRegistrationActionNotAllowedException copyWith({
    _i1.UuidValue? registrationId,
    _i2.EventRegistrationStatus? currentStatus,
  }) {
    return EventRegistrationActionNotAllowedException(
      registrationId: registrationId ?? this.registrationId,
      currentStatus: currentStatus ?? this.currentStatus,
    );
  }
}
