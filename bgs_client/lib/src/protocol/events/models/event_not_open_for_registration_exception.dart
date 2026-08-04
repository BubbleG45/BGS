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
import '../../events/models/event_status.dart' as _i2;

/// Thrown when trying to register for an event that isn't `published`.
abstract class EventNotOpenForRegistrationException
    implements _i1.SerializableException, _i1.SerializableModel {
  EventNotOpenForRegistrationException._({
    required this.eventId,
    required this.currentStatus,
  });

  factory EventNotOpenForRegistrationException({
    required _i1.UuidValue eventId,
    required _i2.EventStatus currentStatus,
  }) = _EventNotOpenForRegistrationExceptionImpl;

  factory EventNotOpenForRegistrationException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EventNotOpenForRegistrationException(
      eventId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['eventId'],
      ),
      currentStatus: _i2.EventStatus.fromJson(
        (jsonSerialization['currentStatus'] as String),
      ),
    );
  }

  _i1.UuidValue eventId;

  _i2.EventStatus currentStatus;

  /// Returns a shallow copy of this [EventNotOpenForRegistrationException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EventNotOpenForRegistrationException copyWith({
    _i1.UuidValue? eventId,
    _i2.EventStatus? currentStatus,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventNotOpenForRegistrationException',
      'eventId': eventId.toJson(),
      'currentStatus': currentStatus.toJson(),
    };
  }

  @override
  String toString() {
    return 'EventNotOpenForRegistrationException(eventId: $eventId, currentStatus: $currentStatus)';
  }
}

class _EventNotOpenForRegistrationExceptionImpl
    extends EventNotOpenForRegistrationException {
  _EventNotOpenForRegistrationExceptionImpl({
    required _i1.UuidValue eventId,
    required _i2.EventStatus currentStatus,
  }) : super._(
         eventId: eventId,
         currentStatus: currentStatus,
       );

  /// Returns a shallow copy of this [EventNotOpenForRegistrationException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EventNotOpenForRegistrationException copyWith({
    _i1.UuidValue? eventId,
    _i2.EventStatus? currentStatus,
  }) {
    return EventNotOpenForRegistrationException(
      eventId: eventId ?? this.eventId,
      currentStatus: currentStatus ?? this.currentStatus,
    );
  }
}
