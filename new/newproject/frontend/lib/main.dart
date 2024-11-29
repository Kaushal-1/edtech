// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart'; // For authentication logic
import 'screens/home_screen.dart'; // Home screen after login
import 'screens/login_screen.dart'; // Login screen
import 'screens/register_screen.dart'; // Registration screen
import 'screens/notes_screen.dart'; // Notes screen
import 'screens/articles_screen.dart'; // Articles screen
import 'screens/analytics_screen.dart'; // Analytics screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: MaterialApp(
        title: 'AI-based EdTech Platform',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/home': (context) => HomeScreen(),
          '/notes': (context) => NotesScreen(),
          '/articles': (context) => ArticlesScreen(),
          '/analytics': (context) => AnalyticsScreen(),
        },
      ),
    );
  }
}