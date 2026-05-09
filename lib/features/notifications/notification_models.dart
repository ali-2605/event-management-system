import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_models.freezed.dart';
part 'notification_models.g.dart';

enum NotificationType {
  @JsonValue('UPDATED')
  updated,
  @JsonValue('CANCELED')
  canceled,
}

@freezed
abstract class NotificationResponse with _$NotificationResponse {
  const factory NotificationResponse({
    required String notificationId,
    required String attendeeId,
    required String eventId,
    required String message,
    required NotificationType type,
    required bool read,
    required DateTime createdAt,
  }) = _NotificationResponse;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);
}
