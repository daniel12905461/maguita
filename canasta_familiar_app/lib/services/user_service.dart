import 'package:dio/dio.dart';

import '../models/user.dart';
import 'api_client.dart';

class UserService {
  Future<(List<User>, Map<String, dynamic>)> getUsers({
    int page = 1,
  }) async {
    try {
      final response = await ApiClient.dio.get(
        '/users',
        queryParameters: {'page': page},
      );

      final data = response.data as Map<String, dynamic>;
      final users = (data['data'] as List<dynamic>)
          .map((u) => User.fromJson(u as Map<String, dynamic>))
          .toList();
      final pagination = data['pagination'] as Map<String, dynamic>;

      return (users, pagination);
    } on DioException catch (e) {
      throw _parseError(e);
    }
  }

  Future<User> getUser(int id) async {
    try {
      final response = await ApiClient.dio.get('/users/$id');
      final data = response.data as Map<String, dynamic>;
      return User.fromJson(data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _parseError(e);
    }
  }

  Future<User> updateUser({
    required int id,
    String? name,
    String? email,
    String? password,
  }) async {
    try {
      final body = <String, dynamic>{};
      if (name != null) body['name'] = name;
      if (email != null) body['email'] = email;
      if (password != null) {
        body['password'] = password;
        body['password_confirmation'] = password;
      }

      final response = await ApiClient.dio.put(
        '/users/$id',
        data: body,
      );

      final data = response.data as Map<String, dynamic>;
      return User.fromJson(data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _parseError(e);
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      await ApiClient.dio.delete('/users/$id');
    } on DioException catch (e) {
      throw _parseError(e);
    }
  }

  Future<User> assignRole({
    required int userId,
    required List<int> roleIds,
  }) async {
    try {
      final response = await ApiClient.dio.put(
        '/users/$userId/role',
        data: {'roles': roleIds},
      );

      final data = response.data as Map<String, dynamic>;
      return User.fromJson(data['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _parseError(e);
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