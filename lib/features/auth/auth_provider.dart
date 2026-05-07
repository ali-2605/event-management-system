import 'package:event_management_system/core/network/dio_provider.dart';
import 'package:event_management_system/features/auth/auth_models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  final _storage = const FlutterSecureStorage();

  @override
  FutureOr<String?> build() async {
    return await _storage.read(key: 'jwt_token');
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final dio = ref.read(dioProvider);
      final response = await dio.post(
        '${ServiceUrls.auth}/api/auth/login',
        data: LoginRequest(email: email, password: password).toJson(),
      );

      final authResponse = AuthResponse.fromJson(response.data);
      await _storage.write(key: 'jwt_token', value: authResponse.token);
      state = AsyncValue.data(authResponse.token);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> register(
    String name,
    String email,
    String password,
    UserRole role,
  ) async {
    state = const AsyncValue.loading();
    try {
      final dio = ref.read(dioProvider);
      final response = await dio.post(
        '${ServiceUrls.auth}/api/auth/register',
        data: RegisterRequest(
          name: name,
          email: email,
          password: password,
          role: role,
        ).toJson(),
      );

      final authResponse = AuthResponse.fromJson(response.data);
      await _storage.write(key: 'jwt_token', value: authResponse.token);
      state = AsyncValue.data(authResponse.token);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
    state = const AsyncValue.data(null);
  }
}
