// providers/auth_provider.dart
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  AuthProvider() {
    checkAuthentication();
  }

  Future<void> checkAuthentication() async {
    _isAuthenticated = await AuthService().isLoggedIn();
    notifyListeners();
  }

  Future<void> login(String username, String password) async {
    await AuthService().login(username, password);
    _isAuthenticated = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await AuthService().logout();
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<void> register(
      String username, String email, String phone, String password) async {
    await AuthService().register(username, email, phone, password);
  }
}
