import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  List<User> _users = [];
  Map<String, dynamic> _pagination = {};
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;

  List<User> get users => _users;
  Map<String, dynamic> get pagination => _pagination;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get currentPage => _currentPage;
  int get totalPages => _pagination['last_page'] ?? 1;
  bool get hasNextPage => _currentPage < totalPages;

  void clearError() => _error = null;

  Future<void> loadUsers({int page = 1}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final (users, pagination) = await _userService.getUsers(page: page);
      _users = users;
      _pagination = pagination;
      _currentPage = page;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMore() async {
    if (!hasNextPage || _isLoading) return;
    await loadUsers(page: _currentPage + 1);
  }

  Future<bool> updateUser({
    required int id,
    String? name,
    String? email,
    String? password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _userService.updateUser(id: id, name: name, email: email, password: password);
      await loadUsers(page: _currentPage);
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteUser(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _userService.deleteUser(id);
      await loadUsers(page: _currentPage);
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> assignRole({
    required int userId,
    required List<int> roleIds,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _userService.assignRole(userId: userId, roleIds: roleIds);
      await loadUsers(page: _currentPage);
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}