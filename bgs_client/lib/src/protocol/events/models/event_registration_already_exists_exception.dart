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

/// Thrown when the calling user already has a registration row (any
/// status) for this event -- register/cancel reuses the same row rather
/// than allowing duplicates, same pattern as TeamMembership.
abstract class EventRegistrationAlreadyExistsException
    implements _i1.SerializableException, _i1.SerializableModel {
  EventRegistrationAlreadyExistsException._({required this.eventId});

  factory EventRegistrationAlreadyExistsException({
    required _i1.UuidValue eventId,
  }) = _EventRegistrationAlreadyExistsExceptionImpl;

  factory EventRegistrationAlreadyExistsException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EventRegistrationAlreadyExistsException(
      eventId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['eventId'],
      ),
    );
  }

  _i1.UuidValue eventId;

  /// Returns a shallow copy of this [EventRegistrationAlreadyExistsException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EventRegistrationAlreadyExistsException copyWith({_i1.UuidValue? eventId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventRegistrationAlreadyExistsException',
      'eventId': eventId.toJson(),
    };
  }

  @override
  String toString() {
    return 'EventRegistrationAlreadyExistsException(eventId: $eventId)';
  }
}

class _EventRegistrationAlreadyExistsExceptionImpl
    extends EventRegistrationAlreadyExistsException {
  _EventRegistrationAlreadyExistsExceptionImpl({required _i1.UuidValue eventId})
    : super._(eventId: eventId);

  /// Returns a shallow copy of this [EventRegistrationAlreadyExistsException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EventRegistrationAlreadyExistsException copyWith({_i1.UuidValue? eventId}) {
    return EventRegistrationAlreadyExistsException(
      eventId: eventId ?? this.eventId,
    );
  }
}
