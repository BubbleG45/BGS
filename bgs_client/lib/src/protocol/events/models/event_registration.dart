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
import '../../events/models/event.dart' as _i3;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i4;
import 'package:bgs_client/src/protocol/protocol.dart' as _i5;

/// A single registration for an [Event] by the [AuthUser] who signed up.
///
/// Kept minimal for Phase 1 -- no persistent Team link, since events
/// aren't necessarily tied to a league [Team].
abstract class EventRegistration implements _i1.SerializableModel {
  EventRegistration._({
    this.id,
    required this.eventId,
    this.event,
    required this.registeredByAuthUserId,
    this.registeredByAuthUser,
    this.teamName,
    _i2.EventRegistrationStatus? status,
    DateTime? createdAt,
  }) : status = status ?? _i2.EventRegistrationStatus.registered,
       createdAt = createdAt ?? DateTime.now();

  factory EventRegistration({
    _i1.UuidValue? id,
    required _i1.UuidValue eventId,
    _i3.Event? event,
    required _i1.UuidValue registeredByAuthUserId,
    _i4.AuthUser? registeredByAuthUser,
    String? teamName,
    _i2.EventRegistrationStatus? status,
    DateTime? createdAt,
  }) = _EventRegistrationImpl;

  factory EventRegistration.fromJson(Map<String, dynamic> jsonSerialization) {
    return EventRegistration(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      eventId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['eventId'],
      ),
      event: jsonSerialization['event'] == null
          ? null
          : _i5.Protocol().deserialize<_i3.Event>(jsonSerialization['event']),
      registeredByAuthUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['registeredByAuthUserId'],
      ),
      registeredByAuthUser: jsonSerialization['registeredByAuthUser'] == null
          ? null
          : _i5.Protocol().deserialize<_i4.AuthUser>(
              jsonSerialization['registeredByAuthUser'],
            ),
      teamName: jsonSerialization['teamName'] as String?,
      status: jsonSerialization['status'] == null
          ? null
          : _i2.EventRegistrationStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue eventId;

  _i3.Event? event;

  _i1.UuidValue registeredByAuthUserId;

  _i4.AuthUser? registeredByAuthUser;

  /// Free-text team/group name for this registration, if applicable.
  String? teamName;

  _i2.EventRegistrationStatus status;

  DateTime createdAt;

  /// Returns a shallow copy of this [EventRegistration]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EventRegistration copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? eventId,
    _i3.Event? event,
    _i1.UuidValue? registeredByAuthUserId,
    _i4.AuthUser? registeredByAuthUser,
    String? teamName,
    _i2.EventRegistrationStatus? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventRegistration',
      if (id != null) 'id': id?.toJson(),
      'eventId': eventId.toJson(),
      if (event != null) 'event': event?.toJson(),
      'registeredByAuthUserId': registeredByAuthUserId.toJson(),
      if (registeredByAuthUser != null)
        'registeredByAuthUser': registeredByAuthUser?.toJson(),
      if (teamName != null) 'teamName': teamName,
      'status': status.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EventRegistrationImpl extends EventRegistration {
  _EventRegistrationImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue eventId,
    _i3.Event? event,
    required _i1.UuidValue registeredByAuthUserId,
    _i4.AuthUser? registeredByAuthUser,
    String? teamName,
    _i2.EventRegistrationStatus? status,
    DateTime? createdAt,
  }) : super._(
         id: id,
         eventId: eventId,
         event: event,
         registeredByAuthUserId: registeredByAuthUserId,
         registeredByAuthUser: registeredByAuthUser,
         teamName: teamName,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [EventRegistration]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EventRegistration copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? eventId,
    Object? event = _Undefined,
    _i1.UuidValue? registeredByAuthUserId,
    Object? registeredByAuthUser = _Undefined,
    Object? teamName = _Undefined,
    _i2.EventRegistrationStatus? status,
    DateTime? createdAt,
  }) {
    return EventRegistration(
      id: id is _i1.UuidValue? ? id : this.id,
      eventId: eventId ?? this.eventId,
      event: event is _i3.Event? ? event : this.event?.copyWith(),
      registeredByAuthUserId:
          registeredByAuthUserId ?? this.registeredByAuthUserId,
      registeredByAuthUser: registeredByAuthUser is _i4.AuthUser?
          ? registeredByAuthUser
          : this.registeredByAuthUser?.copyWith(),
      teamName: teamName is String? ? teamName : this.teamName,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
