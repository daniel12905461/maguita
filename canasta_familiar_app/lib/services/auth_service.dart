import 'package:dio/dio.dart';

import '../models/user.dart';
import 'api_client.dart';

class AuthService {
  Future<(User, String)> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await ApiClient.dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final data = response.data as Map<String, dynamic>;
      final user = User.fromJson(data['user'] as Map<String, dynamic>);
      final token = data['token'] as String;

      await ApiClient.saveToken(token);
      return (user, token);
    } on DioException catch (e) {
      throw _parseError(e);
    }
  }

  Future<(User, String)> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await ApiClient.dio.post(
        '/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      final data = response.data as Map<String, dynamic>;
      final user = User.fromJson(data['user'] as Map<String, dynamic>);
      final token = data['token'] as String;

      await ApiClient.saveToken(token);
      return (user, token);
    } on DioException catch (e) {
      throw _parseError(e);
    }
  }

  Future<User> me() async {
    try {
      final response = await ApiClient.dio.get('/me');
      final data = response.data as Map<String, dynamic>;
      return User.fromJson(data['user'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _parseError(e);
    }
  }

  Future<void> logout() async {
    try {
      await ApiClient.dio.post('/logout');
    } on DioException catch (e) {
      throw _parseError(e);
    } finally {
      await ApiClient.clearToken();
    }
  }

  Exception _parseError(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      final errors = data['errors'];
      if (errors is Map<String, dynamic>) {
        final firstValue = errors.values.firstWhere(
          (v) => v is List && v.isNotEmpty,
          orElse: () => null,
        );
        if (firstValue is List && firstValue.isNotEmpty) {
          return Exception(firstValue.first as String);
        }
      }
      if (data['message'] != null) {
        return Exception(data['message'] as String);
      }
    }
    return Exception('Error de conexión con el servidor.');
  }
}