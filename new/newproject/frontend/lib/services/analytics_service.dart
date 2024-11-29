// services/analytics_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AnalyticsService {
  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> getAnalytics() async {
    final token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('http://localhost:5000/api/analytics/progress'),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": token ?? '',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load analytics');
    }
  }
}