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
        if (status != null) 'status': status.name.toUpperCase(),
        if (from != null) 'from': from.toUtc().toIso8601String(),
        if (to != null) 'to': to.toUtc().toIso8601String(),
        if (sort != null) 'sort': sort,
      },
    );

    final List<dynamic> data = response.data;
    return data.map((e) => EventResponse.fromJson(e)).toList();
  }

  Future<void> createEvent(CreateEventRequest request) async {
    final dio = ref.read(dioProvider);
    final json = request.toJson();
    json['startsAt'] = request.startsAt.toUtc().toIso8601String();
    json['endsAt'] = request.endsAt.toUtc().toIso8601String();

    await dio.post('${ServiceUrls.event}/api/events', data: json);
    ref.invalidateSelf();
  }

  Future<void> updateEvent(String eventId, UpdateEventRequest request) async {
    final dio = ref.read(dioProvider);
    final json = request.toJson();
    if (request.startsAt != null) {
      json['startsAt'] = request.startsAt!.toUtc().toIso8601String();
    }
    if (request.endsAt != null) {
      json['endsAt'] = request.endsAt!.toUtc().toIso8601String();
    }

    await dio.put('${ServiceUrls.event}/api/events/$eventId', data: json);
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

@riverpod
class MyEvents extends _$MyEvents {
  @override
  FutureOr<List<EventResponse>> build() async {
    return ref.watch(eventsProvider.notifier).fetchEvents(mine: true);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(eventsProvider.notifier).fetchEvents(mine: true),
    );
  }
}
