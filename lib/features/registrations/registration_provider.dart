import 'package:event_management_system/core/network/dio_provider.dart';
import 'package:event_management_system/features/registrations/registration_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'registration_provider.g.dart';

@riverpod
class Registrations extends _$Registrations {
  @override
  FutureOr<List<RegistrationResponse>> build() async {
    return await fetchMyRegistrations();
  }

  Future<List<RegistrationResponse>> fetchMyRegistrations() async {
    final dio = ref.read(dioProvider);
    final response = await dio.get(
      '${ServiceUrls.registration}/api/registrations/me',
    );
    final List<dynamic> data = response.data;
    return data.map((e) => RegistrationResponse.fromJson(e)).toList();
  }

  Future<void> registerForEvent(String eventId) async {
    final dio = ref.read(dioProvider);
    await dio.post(
      '${ServiceUrls.registration}/api/registrations',
      data: CreateRegistrationRequest(eventId: eventId).toJson(),
    );
    ref.invalidateSelf();
  }

  Future<void> cancelRegistration(String registrationId) async {
    final dio = ref.read(dioProvider);
    await dio.delete(
      '${ServiceUrls.registration}/api/registrations/$registrationId',
    );
    ref.invalidateSelf();
  }
}
