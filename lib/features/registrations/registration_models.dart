import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_models.freezed.dart';
part 'registration_models.g.dart';

enum RegistrationStatus {
  @JsonValue('REGISTERED')
  registered,
  @JsonValue('CANCELED')
  canceled,
}

@freezed
abstract class RegistrationResponse with _$RegistrationResponse {
  const factory RegistrationResponse({
    required String registrationId,
    required String eventId,
    required String attendeeId,
    required RegistrationStatus status,
    required DateTime registeredAt,
    DateTime? canceledAt,
  }) = _RegistrationResponse;

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) =>
      _$RegistrationResponseFromJson(json);
}

@freezed
abstract class CreateRegistrationRequest with _$CreateRegistrationRequest {
  const factory CreateRegistrationRequest({required String eventId}) =
      _CreateRegistrationRequest;

  factory CreateRegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateRegistrationRequestFromJson(json);
}
