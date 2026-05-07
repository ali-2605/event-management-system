import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_models.freezed.dart';
part 'event_models.g.dart';

enum EventStatus {
  @JsonValue('ACTIVE')
  active,
  @JsonValue('CANCELED')
  canceled,
}

@freezed
abstract class EventResponse with _$EventResponse {
  const factory EventResponse({
    required String eventId,
    required String title,
    required String description,
    required String location,
    required DateTime startsAt,
    required DateTime endsAt,
    required int capacity,
    required String organizerId,
    required EventStatus status,
    required DateTime createdAt,
  }) = _EventResponse;

  factory EventResponse.fromJson(Map<String, dynamic> json) =>
      _$EventResponseFromJson(json);
}

@freezed
abstract class CreateEventRequest with _$CreateEventRequest {
  const factory CreateEventRequest({
    required String title,
    required String description,
    required String location,
    required DateTime startsAt,
    required DateTime endsAt,
    required int capacity,
  }) = _CreateEventRequest;

  factory CreateEventRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateEventRequestFromJson(json);
}

@freezed
abstract class UpdateEventRequest with _$UpdateEventRequest {
  const factory UpdateEventRequest({
    String? title,
    String? description,
    String? location,
    DateTime? startsAt,
    DateTime? endsAt,
    int? capacity,
  }) = _UpdateEventRequest;

  factory UpdateEventRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateEventRequestFromJson(json);
}
