// lib/services/note_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/note_model.dart';

class NoteService {
  final String apiUrl = 'http://localhost:5000/api/notes';

  // Fetch all notes
  Future<List<Note>> fetchNotes() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Note.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load notes');
    }
  }
}
