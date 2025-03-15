import 'package:flutter/material.dart';
import '../../core/services/crashlytics_service.dart';

class CrashlyticsTestScreen extends StatelessWidget {
  const CrashlyticsTestScreen({super.key});

  // Test methods for Crashlytics
  void _testNonFatalError() {
    try {
      throw Exception('This is a non-fatal test error');
    } catch (error, stackTrace) {
      CrashlyticsService.instance.logError(
        error,
        stackTrace,
        fatal: false,
      );
    }
  }

  void _testFatalError() {
    throw Exception('This is a fatal test error');
  }

  void _testCustomLog() {
    CrashlyticsService.instance.log('This is a test log message');
    CrashlyticsService.instance.setCustomKey('test_key', 'test_value');
    print('Test log and custom key have been sent to Crashlytics');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crashlytics Tests'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Test Firebase Crashlytics',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Use these buttons to test different types of error reporting in Firebase Crashlytics.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: _testNonFatalError,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Test Non-Fatal Error',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _testFatalError,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Test Fatal Error',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _testCustomLog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Test Custom Log',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
