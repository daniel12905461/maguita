import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../config/api_config.dart';

class ApiClient {
  ApiClient._();

  static final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Accept': 'application/json'},
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.read(key: ApiConfig.tokenKey);
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );

  static Future<void> saveToken(String token) async {
    await _storage.write(key: ApiConfig.tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return _storage.read(key: ApiConfig.tokenKey);
  }

  static Future<void> clearToken() async {
    await _storage.delete(key: ApiConfig.tokenKey);
  }
}