// services/note_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NoteService {
  final storage = FlutterSecureStorage();
  
  Future<List<dynamic>> getNotes() async {
    final token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('http://localhost:5000/api/notes'),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": token ?? '',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load notes');
    }
  }

  Future<void> createNote(Map<String, dynamic> note) async {
    final token = await storage.read(key: 'token');
    await http.post(
      Uri.parse('http://localhost:5000/api/notes'),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": token ?? '',
      },
      body: jsonEncode(note),
    );
  }

  Future<void> deleteNote(String id) async {
    final token = await storage.read(key: 'token');
    await http.delete(
      Uri.parse('http://localhost:5000/api/notes/$id'),
      headers: {
        "Content-Type": "application/json",
        "x-auth-token": token ?? '',
      },
    );
  }
}