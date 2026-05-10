
part of 'event_models.dart';


_EventResponse _$EventResponseFromJson(Map<String, dynamic> json) =>
    _EventResponse(
      eventId: json['eventId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      startsAt: DateTime.parse(json['startsAt'] as String),
      endsAt: DateTime.parse(json['endsAt'] as String),
      capacity: (json['capacity'] as num).toInt(),
      organizerId: json['organizerId'] as String,
      status: $enumDecode(_$EventStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$EventResponseToJson(_EventResponse instance) =>
    <String, dynamic>{
      'eventId': instance.eventId,
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'startsAt': instance.startsAt.toIso8601String(),
      'endsAt': instance.endsAt.toIso8601String(),
      'capacity': instance.capacity,
      'organizerId': instance.organizerId,
      'status': _$EventStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$EventStatusEnumMap = {
  EventStatus.active: 'ACTIVE',
  EventStatus.canceled: 'CANCELED',
};

_CreateEventRequest _$CreateEventRequestFromJson(Map<String, dynamic> json) =>
    _CreateEventRequest(
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      startsAt: DateTime.parse(json['startsAt'] as String),
      endsAt: DateTime.parse(json['endsAt'] as String),
      capacity: (json['capacity'] as num).toInt(),
    );

Map<String, dynamic> _$CreateEventRequestToJson(_CreateEventRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'startsAt': instance.startsAt.toIso8601String(),
      'endsAt': instance.endsAt.toIso8601String(),
      'capacity': instance.capacity,
    };

_UpdateEventRequest _$UpdateEventRequestFromJson(Map<String, dynamic> json) =>
    _UpdateEventRequest(
      title: json['title'] as String?,
      description: json['description'] as String?,
      location: json['location'] as String?,
      startsAt: json['startsAt'] == null
          ? null
          : DateTime.parse(json['startsAt'] as String),
      endsAt: json['endsAt'] == null
          ? null
          : DateTime.parse(json['endsAt'] as String),
      capacity: (json['capacity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UpdateEventRequestToJson(_UpdateEventRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'startsAt': instance.startsAt?.toIso8601String(),
      'endsAt': instance.endsAt?.toIso8601String(),
      'capacity': instance.capacity,
    };
