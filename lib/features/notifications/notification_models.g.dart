// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationResponse _$NotificationResponseFromJson(
  Map<String, dynamic> json,
) => _NotificationResponse(
  notificationId: json['notificationId'] as String,
  attendeeId: json['attendeeId'] as String,
  eventId: json['eventId'] as String,
  message: json['message'] as String,
  type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
  read: json['read'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$NotificationResponseToJson(
  _NotificationResponse instance,
) => <String, dynamic>{
  'notificationId': instance.notificationId,
  'attendeeId': instance.attendeeId,
  'eventId': instance.eventId,
  'message': instance.message,
  'type': _$NotificationTypeEnumMap[instance.type]!,
  'read': instance.read,
  'createdAt': instance.createdAt.toIso8601String(),
};

const _$NotificationTypeEnumMap = {
  NotificationType.updated: 'UPDATED',
  NotificationType.canceled: 'CANCELED',
};
