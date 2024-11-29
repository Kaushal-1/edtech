// screens/analytics_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/analytics_service.dart'; // Service for fetching analytics

class AnalyticsScreen extends StatefulWidget {
  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  Map<String, dynamic> analyticsData = {};

  @override
  void initState() {
    super.initState();
    _fetchAnalytics(); // Load analytics data when the screen is initialized
  }

  Future<void> _fetchAnalytics() async {
    final analyticsService = Provider.of<AnalyticsService>(context, listen: false);
    analyticsData = await analyticsService.getAnalytics(); // Fetch analytics data
    setState(() {}); // Update UI after fetching analytics
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Your Progress', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('Total Notes: ${analyticsData['totalNotes'] ?? 0}'),
            Text('Total Articles: ${analyticsData['totalArticles'] ?? 0}'),
            Text('Points: ${analyticsData['points'] ?? 0}'),
            Text('Badges: ${analyticsData['badges']?.join(', ') ?? 'None'}'),
          ],
        ),
      ),
    );
  }
}