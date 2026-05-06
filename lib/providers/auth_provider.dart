import 'package:flutter/material.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  bool _isLoggedIn = false;

  // Dummy users for demo
  final List<User> _users = [
    User(
      id: '1',
      name: 'John User',
      email: 'user@emergency.com',
      password: 'user123',
      role: 'user',
      createdAt: DateTime.now(),
    ),
    User(
      id: '2',
      name: 'Admin Officer',
      email: 'admin@emergency.com',
      password: 'admin123',
      role: 'admin',
      createdAt: DateTime.now(),
    ),
  ];

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  String? get userRole => _currentUser?.role;

  Future<bool> login(String email, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      final user = _users.firstWhere(
        (u) => u.email == email && u.password == password,
        orElse: () => throw Exception('Invalid credentials'),
      );

      _currentUser = user;
      _isLoggedIn = true;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoggedIn = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signup(String name, String email, String password,
      String confirmPassword, String role) async {
    try {
      if (password != confirmPassword) {
        throw Exception('Passwords do not match');
      }

      if (_users.any((u) => u.email == email)) {
        throw Exception('Email already exists');
      }

      await Future.delayed(const Duration(seconds: 1));

      final newUser = User(
        id: DateTime.now().toString(),
        name: name,
        email: email,
        password: password,
        role: role,
        createdAt: DateTime.now(),
      );

      _users.add(newUser);
      _currentUser = newUser;
      _isLoggedIn = true;
      notifyListeners();
      return true;
    } catch (e) {
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}
