// services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/auth/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      return data;
    } else {
      throw Exception(
          'Failed to login: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  // Future<Map<String, dynamic>> login(String username, String password) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/auth/login'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: json.encode({
  //       'username': username,
  //       'password': password,
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('token', data['token']);
  //     return data;
  //   } else {
  //     throw Exception('Failed to login');
  //   }
  // }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  Future<Map<String, dynamic>> register(
      String username, String email, String phone, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username,
        'email': email,
        'phone': phone,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to register');
    }
  }
}
