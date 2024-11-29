// services/article_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ArticleService {
  final storage = FlutterSecureStorage();

  Future<List<dynamic>> getArticles() async {
    final token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('http://localhost:5000/api/articles'),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": token ?? '',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load articles');
    }
  }

  Future<void> createArticle(Map<String, dynamic> article) async {
    final token = await storage.read(key: 'token');
    await http.post(
      Uri.parse('http://localhost:5000/api/articles'),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": token ?? '',
      },
      body: jsonEncode(article),
    );
  }

  Future<void> deleteArticle(String id) async {
    final token = await storage.read(key: 'token');
    await http.delete(
      Uri.parse('http://localhost:5000/api/articles/$id'),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": token ?? '',
      },
    );
  }
}