// services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  final storage = FlutterSecureStorage();
  String _token = '';

  String get token => _token;

  // Register User
  Future<bool> register(String name, String email, String password) async {
    print('Attempting to register user: $email'); // Debug line
    
    final response = await http.post(
      Uri.parse('http://localhost:5000/api/users'), // Ensure this endpoint is correct
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    print('Response status: ${response.statusCode}'); // Debug line

    if (response.statusCode == 201) {
      // Registration successful
      return true;
    } else {
      // Registration failed
      print('Registration failed: ${response.body}'); // Debug line
      return false;
    }
  }

  // Login User
  Future<bool> login(String email, String password) async {
    print('Attempting to log in user: $email'); // Debug line
    
    final response = await http.post(
      Uri.parse('http://localhost:5000/api/users/login'), // Ensure this endpoint is correct
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'email': email, 'password': password}),
    );

    print('Login response status: ${response.statusCode}'); // Debug line

    if (response.statusCode == 200) {
      // Login successful, save token
      _token = jsonDecode(response.body)['token'];
      await storage.write(key: 'token', value: _token);
      notifyListeners();
      return true;
    } else {
      // Login failed
      print('Login failed: ${response.body}'); // Debug line
      return false;
    }
  }

  // Logout User
  Future<void> logout() async {
    _token = '';
    await storage.delete(key: 'token');
    notifyListeners();
  }
}