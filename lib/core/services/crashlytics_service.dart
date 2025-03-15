import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashlyticsService {
  static final CrashlyticsService _instance = CrashlyticsService._();
  static CrashlyticsService get instance => _instance;

  late final FirebaseCrashlytics _crashlytics;

  CrashlyticsService._() {
    _crashlytics = FirebaseCrashlytics.instance;
  }

  /// Initialize Crashlytics service
  Future<void> initialize() async {
    // Pass all uncaught errors to Crashlytics
    FlutterError.onError = _crashlytics.recordFlutterFatalError;

    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      _crashlytics.recordError(error, stack, fatal: true);
      return true;
    };
  }

  /// Log error to Crashlytics
  Future<void> logError(dynamic error, StackTrace? stack,
      {bool fatal = false}) async {
    if (kDebugMode) {
      print('Error: $error');
      if (stack != null) print('Stack trace: $stack');
      return;
    }

    await _crashlytics.recordError(
      error,
      stack,
      fatal: fatal,
    );
  }

  /// Log message to Crashlytics
  Future<void> log(String message) async {
    if (kDebugMode) {
      print('Log: $message');
      return;
    }

    await _crashlytics.log(message);
  }

  /// Set custom key for better error tracking
  Future<void> setCustomKey(String key, dynamic value) async {
    await _crashlytics.setCustomKey(key, value);
  }

  /// Set user identifier
  Future<void> setUserIdentifier(String identifier) async {
    await _crashlytics.setUserIdentifier(identifier);
  }
}
