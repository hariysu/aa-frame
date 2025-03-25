import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  DateTime? _screenOpenTime;

  @override
  void initState() {
    super.initState();
    _screenOpenTime = DateTime.now();
    _logScreenOpen();
  }

  @override
  void dispose() {
    _logScreenClose();
    super.dispose();
  }

  Future<void> _logScreenOpen() async {
    await _analytics.logScreenView(
      screenName: 'analytics_screen',
      screenClass: 'AnalyticsScreen',
    );
  }

  Future<void> _logScreenClose() async {
    if (_screenOpenTime != null) {
      final duration = DateTime.now().difference(_screenOpenTime!);
      await _analytics.logEvent(
        name: 'screen_time',
        parameters: {
          'screen_name': 'analytics_screen',
          'duration_seconds': duration.inSeconds,
          'duration_milliseconds': duration.inMilliseconds,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics Screen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'This screen tracks time between open and close',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'Opened at: ${_screenOpenTime?.toString() ?? 'N/A'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
