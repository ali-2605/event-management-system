// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RegistrationResponse _$RegistrationResponseFromJson(
  Map<String, dynamic> json,
) => _RegistrationResponse(
  registrationId: json['registrationId'] as String,
  eventId: json['eventId'] as String,
  attendeeId: json['attendeeId'] as String,
  status: $enumDecode(_$RegistrationStatusEnumMap, json['status']),
  registeredAt: DateTime.parse(json['registeredAt'] as String),
  canceledAt: json['canceledAt'] == null
      ? null
      : DateTime.parse(json['canceledAt'] as String),
);

Map<String, dynamic> _$RegistrationResponseToJson(
  _RegistrationResponse instance,
) => <String, dynamic>{
  'registrationId': instance.registrationId,
  'eventId': instance.eventId,
  'attendeeId': instance.attendeeId,
  'status': _$RegistrationStatusEnumMap[instance.status]!,
  'registeredAt': instance.registeredAt.toIso8601String(),
  'canceledAt': instance.canceledAt?.toIso8601String(),
};

const _$RegistrationStatusEnumMap = {
  RegistrationStatus.registered: 'REGISTERED',
  RegistrationStatus.canceled: 'CANCELED',
};

_CreateRegistrationRequest _$CreateRegistrationRequestFromJson(
  Map<String, dynamic> json,
) => _CreateRegistrationRequest(eventId: json['eventId'] as String);

Map<String, dynamic> _$CreateRegistrationRequestToJson(
  _CreateRegistrationRequest instance,
) => <String, dynamic>{'eventId': instance.eventId};
