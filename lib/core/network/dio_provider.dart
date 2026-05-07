import 'package:dio/dio.dart';
import 'package:event_management_system/features/auth/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'dio_provider.g.dart';

class ServiceUrls {
  static const String host = '192.168.100.106';

  static const String auth = 'http://$host:8081';
  static const String event = 'http://$host:8082';
  static const String registration = 'http://$host:8083';
  static const String notification = 'http://$host:8084';
}

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      // Increased timeouts to 30 seconds
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

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
        if (e.response?.statusCode == 401) {
          ref.read(authProvider.notifier).logout();
        }
        return handler.next(e);
      },
    ),
  );

  return dio;
}