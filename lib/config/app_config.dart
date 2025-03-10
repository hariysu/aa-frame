import 'package:flutter/foundation.dart';

/// Environment types for the application
enum Environment {
  development,
  staging,
  production,
}

/// Configuration for the application
class AppConfig {
  final Environment environment;
  final String apiBaseUrl;
  final bool enableLogging;
  final bool enableCrashReporting;
  final String appName;

  /// Singleton instance
  static late AppConfig _instance;

  /// Private constructor
  AppConfig._({
    required this.environment,
    required this.apiBaseUrl,
    required this.enableLogging,
    required this.enableCrashReporting,
    required this.appName,
  });

  /// Initialize the app configuration
  static void initialize({required Environment environment}) {
    switch (environment) {
      case Environment.development:
        _instance = AppConfig._development();
        break;
      case Environment.staging:
        _instance = AppConfig._staging();
        break;
      case Environment.production:
        _instance = AppConfig._production();
        break;
    }
  }

  /// Get the current instance
  static AppConfig get instance {
    // The late keyword ensures _instance is initialized before access
    return _instance;
  }

  /// Development environment configuration
  factory AppConfig._development() {
    return AppConfig._(
      environment: Environment.development,
      apiBaseUrl: 'https://dev-api.example.com',
      enableLogging: true,
      enableCrashReporting: false,
      appName: 'AA Frame Dev',
    );
  }

  /// Staging environment configuration
  factory AppConfig._staging() {
    return AppConfig._(
      environment: Environment.staging,
      apiBaseUrl: 'https://staging-api.example.com',
      enableLogging: true,
      enableCrashReporting: true,
      appName: 'AA Frame Staging',
    );
  }

  /// Production environment configuration
  factory AppConfig._production() {
    return AppConfig._(
      environment: Environment.production,
      apiBaseUrl: 'https://api.example.com',
      enableLogging: false,
      enableCrashReporting: true,
      appName: 'AA Frame',
    );
  }

  /// Check if the app is running in debug mode
  bool get isDebug => kDebugMode;

  /// Check if the app is running in development environment
  bool get isDevelopment => environment == Environment.development;

  /// Check if the app is running in staging environment
  bool get isStaging => environment == Environment.staging;

  /// Check if the app is running in production environment
  bool get isProduction => environment == Environment.production;
}
