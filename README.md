# AA Frame - Flutter App Template

A well-structured Flutter application template that follows best practices for scalable and maintainable code.

## Features

- **Organized Structure**: Clear separation of concerns with a well-defined folder structure
- **Theme Support**: Light and dark theme support with dynamic theme switching
- **Localization**: Multi-language support with easy_localization
  - English
  - Spanish
  - Turkish
  - German
- **Local Notifications**: Push notification support using flutter_local_notifications
- **Image Caching**: Efficient image loading and caching with cached_network_image
- **Error Tracking**: Firebase Crashlytics integration for error reporting and monitoring
- **Routing**: Centralized routing system
- **Environment Configuration**: Support for different environments (development, staging, production)
- **API Integration**: Ready-to-use API service for network requests
- **Reusable Components**: Custom widgets for consistent UI

## Project Structure

```
lib/
├── config/             # App configuration
│   └── app_config.dart # Environment-specific configuration
├── core/               # Core functionality
│   ├── constants.dart  # App-wide constants
│   ├── theme.dart      # App theme configuration
│   ├── utils.dart      # Utility functions
│   ├── providers/      # State management providers
│   │   ├── theme_provider.dart
│   │   └── language_provider.dart
│   └── services/       # Core services
│       ├── notification_service.dart
│       └── crashlytics_service.dart
├── data/               # Data layer
│   ├── models/         # Data models
│   │   └── user_model.dart
│   ├── repositories/   # Repositories for data access
│   │   └── user_repository.dart
│   └── services/       # Services for external APIs
│       └── api_service.dart
├── presentation/       # UI layer
│   ├── screens/        # App screens
│   │   ├── home_screen.dart
│   │   ├── settings_screen.dart
│   │   ├── cached_image_screen.dart
│   │   └── crashlytics_test_screen.dart
│   └── widgets/        # Reusable widgets
│       └── custom_button.dart
├── routes/             # Navigation
│   └── app_router.dart # App routing configuration
└── main.dart           # Entry point
```

## Getting Started

1. Clone this repository
2. Run `flutter pub get` to install dependencies
3. Configure Firebase:
   - Create a new Firebase project
   - Add your app to the project
   - Download and add configuration files:
     - `google-services.json` for Android
     - `GoogleService-Info.plist` for iOS
4. Run `flutter run` to start the app

## Dependencies

- Flutter SDK: ^3.6.2
- provider: ^6.1.1
- shared_preferences: ^2.2.2
- easy_localization: ^3.0.3
- flutter_local_notifications: ^18.0.1
- cached_network_image: ^3.4.1
- firebase_core: ^2.27.1
- firebase_crashlytics: ^3.4.19
- http: ^1.1.0

## Features Guide

### Theme Management
- Dynamic theme switching (Light/Dark/System)
- Persistent theme preferences
- Material 3 design support

### Localization
- Support for multiple languages
- Easy addition of new languages
- Persistent language preferences
- Automatic locale detection

### Local Notifications
- Push notification support
- Customizable notification content
- Support for both Android and iOS

### Image Caching
- Efficient image loading
- Automatic caching
- Placeholder support
- Error handling

### Error Tracking
- Firebase Crashlytics integration
- Automatic crash reporting
- Custom error logging
- Non-fatal error tracking
- Custom keys and logs

## Best Practices

- Use named routes for navigation
- Follow the repository pattern for data access
- Keep UI and business logic separate
- Use constants for hardcoded values
- Document your code with comments
- Handle errors appropriately using Crashlytics
- Cache network resources when possible

## Contributing

Feel free to submit issues and enhancement requests.
