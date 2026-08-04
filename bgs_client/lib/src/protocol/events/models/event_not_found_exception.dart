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

/// Thrown when an event id doesn't correspond to any existing event.
abstract class EventNotFoundException
    implements _i1.SerializableException, _i1.SerializableModel {
  EventNotFoundException._({required this.eventId});

  factory EventNotFoundException({required _i1.UuidValue eventId}) =
      _EventNotFoundExceptionImpl;

  factory EventNotFoundException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EventNotFoundException(
      eventId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['eventId'],
      ),
    );
  }

  _i1.UuidValue eventId;

  /// Returns a shallow copy of this [EventNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EventNotFoundException copyWith({_i1.UuidValue? eventId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventNotFoundException',
      'eventId': eventId.toJson(),
    };
  }

  @override
  String toString() {
    return 'EventNotFoundException(eventId: $eventId)';
  }
}

class _EventNotFoundExceptionImpl extends EventNotFoundException {
  _EventNotFoundExceptionImpl({required _i1.UuidValue eventId})
    : super._(eventId: eventId);

  /// Returns a shallow copy of this [EventNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EventNotFoundException copyWith({_i1.UuidValue? eventId}) {
    return EventNotFoundException(eventId: eventId ?? this.eventId);
  }
}
