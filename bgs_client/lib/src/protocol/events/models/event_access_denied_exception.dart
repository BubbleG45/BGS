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

/// Thrown when the calling user can't manage an event: not an `admin`+ on
/// the event's organization (org-scoped events), or not the event's
/// creator (orgless events, which have no organization to check a role
/// against).
abstract class EventAccessDeniedException
    implements _i1.SerializableException, _i1.SerializableModel {
  EventAccessDeniedException._({required this.eventId});

  factory EventAccessDeniedException({required _i1.UuidValue eventId}) =
      _EventAccessDeniedExceptionImpl;

  factory EventAccessDeniedException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EventAccessDeniedException(
      eventId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['eventId'],
      ),
    );
  }

  _i1.UuidValue eventId;

  /// Returns a shallow copy of this [EventAccessDeniedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EventAccessDeniedException copyWith({_i1.UuidValue? eventId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventAccessDeniedException',
      'eventId': eventId.toJson(),
    };
  }

  @override
  String toString() {
    return 'EventAccessDeniedException(eventId: $eventId)';
  }
}

class _EventAccessDeniedExceptionImpl extends EventAccessDeniedException {
  _EventAccessDeniedExceptionImpl({required _i1.UuidValue eventId})
    : super._(eventId: eventId);

  /// Returns a shallow copy of this [EventAccessDeniedException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EventAccessDeniedException copyWith({_i1.UuidValue? eventId}) {
    return EventAccessDeniedException(eventId: eventId ?? this.eventId);
  }
}
