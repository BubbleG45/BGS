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

/// Thrown when a registration id doesn't correspond to any existing
/// registration.
abstract class EventRegistrationNotFoundException
    implements _i1.SerializableException, _i1.SerializableModel {
  EventRegistrationNotFoundException._({required this.registrationId});

  factory EventRegistrationNotFoundException({
    required _i1.UuidValue registrationId,
  }) = _EventRegistrationNotFoundExceptionImpl;

  factory EventRegistrationNotFoundException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EventRegistrationNotFoundException(
      registrationId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['registrationId'],
      ),
    );
  }

  _i1.UuidValue registrationId;

  /// Returns a shallow copy of this [EventRegistrationNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EventRegistrationNotFoundException copyWith({_i1.UuidValue? registrationId});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EventRegistrationNotFoundException',
      'registrationId': registrationId.toJson(),
    };
  }

  @override
  String toString() {
    return 'EventRegistrationNotFoundException(registrationId: $registrationId)';
  }
}

class _EventRegistrationNotFoundExceptionImpl
    extends EventRegistrationNotFoundException {
  _EventRegistrationNotFoundExceptionImpl({
    required _i1.UuidValue registrationId,
  }) : super._(registrationId: registrationId);

  /// Returns a shallow copy of this [EventRegistrationNotFoundException]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EventRegistrationNotFoundException copyWith({_i1.UuidValue? registrationId}) {
    return EventRegistrationNotFoundException(
      registrationId: registrationId ?? this.registrationId,
    );
  }
}
