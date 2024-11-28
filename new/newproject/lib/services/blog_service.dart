// lib/services/blog_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/blog_model.dart';

class BlogService {
  final String apiUrl = 'http://localhost:5000/api/blogs';

  // Fetch all blogs
  Future<List<Blog>> fetchBlogs() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Blog.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load blogs');
    }
  }
}
