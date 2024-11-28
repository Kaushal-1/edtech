// frontend/lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _authService = AuthService();
  bool _isLoading = true;
  Map<String, dynamic> _profileData = {};

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  void _loadProfileData() async {
    final response = await _authService.fetchUserProfile();
    setState(() {
      _isLoading = false;
      if (response['success']) {
        _profileData = response['data'];
      } else {
        _profileData = {};
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Name: ${_profileData['name']}'),
                  Text('Email: ${_profileData['email']}'),
                  // Add more fields here if needed
                ],
              ),
            ),
    );
  }
}
