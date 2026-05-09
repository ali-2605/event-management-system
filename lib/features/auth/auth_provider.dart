import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:event_management_system/core/network/dio_provider.dart';
import 'package:event_management_system/features/auth/auth_models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  final _storage = const FlutterSecureStorage();

  @override
  FutureOr<AuthResponse?> build() async {
    final data = await _storage.read(key: 'auth_data');
    if (data != null) {
      try {
        return AuthResponse.fromJson(jsonDecode(data));
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    // Capture dio BEFORE setting state, so ref is never accessed after a rebuild
    final dio = ref.read(dioProvider);

    state = const AsyncValue.loading();

    try {
      final response = await dio.post(
        '${ServiceUrls.auth}/api/auth/login',
        data: LoginRequest(email: email, password: password).toJson(),
      );

      // Guard: if provider was disposed/rebuilt while awaiting, bail out
      if (!ref.mounted) return;

      final authResponse = AuthResponse.fromJson(response.data);
      await _storage.write(key: 'jwt_token', value: authResponse.token);
      await _storage.write(
        key: 'auth_data',
        value: jsonEncode(authResponse.toJson()),
      );

      if (!ref.mounted) return;
      state = AsyncValue.data(authResponse);
    } on DioException catch (e, stack) {
      if (!ref.mounted) return;
      final message = e.response?.statusCode == 401
          ? 'Invalid email or password.'
          : 'An error occurred. Please try again.';
      state = AsyncValue.error(message, stack);
    } catch (e, stack) {
      if (!ref.mounted) return;
      state = AsyncValue.error('An unexpected error occurred.', stack);
    }
  }

  Future<void> register(
    String name,
    String email,
    String password,
    UserRole role,
  ) async {
    // Capture dio BEFORE setting state
    final dio = ref.read(dioProvider);

    state = const AsyncValue.loading();

    try {
      final response = await dio.post(
        '${ServiceUrls.auth}/api/auth/register',
        data: RegisterRequest(
          name: name,
          email: email,
          password: password,
          role: role,
        ).toJson(),
      );

      if (!ref.mounted) return;

      final authResponse = AuthResponse.fromJson(response.data);
      await _storage.write(key: 'jwt_token', value: authResponse.token);
      await _storage.write(
        key: 'auth_data',
        value: jsonEncode(authResponse.toJson()),
      );

      if (!ref.mounted) return;
      state = AsyncValue.data(authResponse);
    } on DioException catch (e, stack) {
      if (!ref.mounted) return;
      final message = e.response?.statusCode == 409
          ? 'This email is already registered.'
          : 'Failed to register. Please check your connection.';
      state = AsyncValue.error(message, stack);
    } catch (e, stack) {
      if (!ref.mounted) return;
      state = AsyncValue.error('An unexpected error occurred.', stack);
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'jwt_token');
    await _storage.delete(key: 'auth_data');
    if (!ref.mounted) return;
    state = const AsyncValue.data(null);
  }
}
