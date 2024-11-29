// screens/notes_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/note_service.dart'; // Service for managing notes
import '../widgets/custom_button.dart'; // Custom button widget

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  List notes = [];

  @override
  void initState() {
    super.initState();
    _fetchNotes(); // Load notes when the screen is initialized
  }

  Future<void> _fetchNotes() async {
    final noteService = Provider.of<NoteService>(context, listen: false);
    notes = await noteService.getNotes(); // Fetch notes from the service
    setState(() {}); // Update UI after fetching notes
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(notes[index]['title']),
                    subtitle: Text(notes[index]['content']),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        await Provider.of<NoteService>(context, listen: false)
                            .deleteNote(notes[index]['_id']);
                        _fetchNotes(); // Refresh notes list
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _contentController,
                    decoration: InputDecoration(labelText: 'Content'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter content';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'Add Note',
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await Provider.of<NoteService>(context, listen: false)
                            .createNote({
                          'title': _titleController.text,
                          'content': _contentController.text,
                        });
                        _titleController.clear();
                        _contentController.clear();
                        _fetchNotes(); // Refresh notes list
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}