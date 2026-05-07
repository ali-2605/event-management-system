import 'package:event_management_system/core/network/dio_provider.dart';
import 'package:event_management_system/features/events/event_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_provider.g.dart';

@riverpod
class Events extends _$Events {
  @override
  FutureOr<List<EventResponse>> build() async {
    return await fetchEvents();
  }

  Future<List<EventResponse>> fetchEvents({
    bool? mine,
    EventStatus? status,
    DateTime? from,
    DateTime? to,
    String? sort,
  }) async {
    final dio = ref.read(dioProvider);
    final response = await dio.get(
      '${ServiceUrls.event}/api/events',
      queryParameters: {
        if (mine != null) 'mine': mine,
        if (status != null) 'status': status.name,
        if (from != null) 'from': from.toIso8601String(),
        if (to != null) 'to': to.toIso8601String(),
        if (sort != null) 'sort': sort,
      },
    );

    final List<dynamic> data = response.data;
    return data.map((e) => EventResponse.fromJson(e)).toList();
  }

  Future<void> createEvent(CreateEventRequest request) async {
    final dio = ref.read(dioProvider);
    await dio.post('${ServiceUrls.event}/api/events', data: request.toJson());
    ref.invalidateSelf();
  }

  Future<void> updateEvent(String eventId, UpdateEventRequest request) async {
    final dio = ref.read(dioProvider);
    await dio.put(
      '${ServiceUrls.event}/api/events/$eventId',
      data: request.toJson(),
    );
    ref.invalidateSelf();
  }

  Future<void> cancelEvent(String eventId) async {
    final dio = ref.read(dioProvider);
    await dio.delete('${ServiceUrls.event}/api/events/$eventId');
    ref.invalidateSelf();
  }
}

@riverpod
Future<EventResponse> eventDetails(Ref ref, String eventId) async {
  final dio = ref.read(dioProvider);
  final response = await dio.get('${ServiceUrls.event}/api/events/$eventId');
  return EventResponse.fromJson(response.data);
}
