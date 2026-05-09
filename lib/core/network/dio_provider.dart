import 'package:dio/dio.dart';
import 'package:event_management_system/features/auth/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'dio_provider.g.dart';

class ServiceUrls {
  static const String host = '192.168.100.106';

  static const String auth = 'http://$host:8080';
  static const String event = 'http://$host:8080';
  static const String registration = 'http://$host:8080';
  static const String notification = 'http://$host:8080';
}

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  final authNotifier = ref.read(authProvider.notifier);

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        const storage = FlutterSecureStorage();
        final token = await storage.read(key: 'jwt_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (e, handler) async {
        final path = e.requestOptions.path;
        final isAuthEndpoint =
            path.contains('/api/auth/login') ||
            path.contains('/api/auth/register');

        // Only auto-logout on 401s from protected endpoints,
        // never from login/register where 401 just means wrong credentials
        if (e.response?.statusCode == 401 && !isAuthEndpoint) {
          await authNotifier.logout();
        }

        return handler.next(e);
      },
    ),
  );

  ref.onDispose(dio.close);

  return dio;
}
