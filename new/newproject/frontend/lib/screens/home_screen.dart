// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              authService.logout(); // Call logout method
              Navigator.pushReplacementNamed(context, '/'); // Go back to login
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the AI-based EdTech Platform!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/notes'); // Navigate to notes screen
              },
              child: Text('My Notes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/articles'); // Navigate to articles screen
              },
              child: Text('My Articles'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/analytics'); // Navigate to analytics screen
              },
              child: Text('View Analytics'),
            ),
          ],
        ),
      ),
    );
  }
}