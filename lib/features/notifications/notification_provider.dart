import 'package:event_management_system/core/network/dio_provider.dart';
import 'package:event_management_system/features/notifications/notification_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_provider.g.dart';

@riverpod
class Notifications extends _$Notifications {
  @override
  FutureOr<List<NotificationResponse>> build() async {
    return await fetchNotifications();
  }

  Future<List<NotificationResponse>> fetchNotifications({
    bool? seen,
    DateTime? from,
    DateTime? to,
    String? eventId,
    String? sort,
  }) async {
    final dio = ref.read(dioProvider);
    final response = await dio.get(
      '${ServiceUrls.notification}/api/notifications',
      queryParameters: {
        if (seen != null) 'seen': seen,
        if (from != null) 'from': from.toIso8601String(),
        if (to != null) 'to': to.toIso8601String(),
        if (eventId != null) 'eventId': eventId,
        if (sort != null) 'sort': sort,
      },
    );

    final List<dynamic> data = response.data;
    return data.map((e) => NotificationResponse.fromJson(e)).toList();
  }

  Future<void> toggleRead(String notificationId) async {
    final dio = ref.read(dioProvider);
    await dio.patch(
      '${ServiceUrls.notification}/api/notifications/$notificationId',
    );
    ref.invalidateSelf();
  }
}

@riverpod
int unreadNotificationsCount(Ref ref) {
  final notificationsAsync = ref.watch(notificationsProvider);
  return notificationsAsync.when(
    data: (notifications) => notifications.where((n) => !n.read).length,
    loading: () => 0,
    error: (_, __) => 0,
  );
}
