import 'package:dio/dio.dart';

/// Extracts error message from DioException
/// Returns backend error message if available, otherwise returns generic error
String extractErrorMessage(DioException error) {
  final data = error.response?.data;
  if (data is Map<String, dynamic> && data['error'] is String) {
    return data['error'];
  }
  return error.message ?? 'An error occurred.';
}
