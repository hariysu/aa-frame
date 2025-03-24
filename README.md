# AA Frame - Flutter App Template

A well-structured Flutter application template that follows best practices for scalable and maintainable code.

## Features

- **Organized Structure**: Clean architecture with clear separation of concerns
- **Theme Support**: Light and dark theme support with dynamic theme switching
- **Localization**: Multi-language support with easy_localization
  - English (en)
  - Spanish (es)
  - Turkish (tr)
  - German (de)
  - French (fr)
  - Japanese (ja)
  - Arabic (ar)
- **Firebase Integration**:
  - Authentication (Email/Password, Google, Apple)
  - Cloud Firestore for database
  - Firebase Storage for file storage
  - Crashlytics for error tracking
- **Local Notifications**: Push notification support using flutter_local_notifications
- **Image Handling**:
  - Efficient image loading and caching with cached_network_image
  - Image picking functionality
  - SVG support
- **State Management**: Provider-based state management
- **Security**: Secure storage for sensitive data
- **Routing**: Centralized routing system
- **Environment Configuration**: Support for different environments (development, staging, production)
- **API Integration**: Ready-to-use API service for network requests
- **Reusable Components**: Custom widgets for consistent UI
- **Code Generation**: JSON serialization with freezed

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
│   ├── repositories/   # Repositories for data access
│   └── services/       # Services for external APIs
├── presentation/       # UI layer
│   ├── screens/        # App screens
│   └── widgets/        # Reusable widgets
├── routes/             # Navigation
│   └── app_router.dart # App routing configuration
├── main.dart           # Entry point
└── firebase_options.dart # Firebase configuration
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
   - Enable required Firebase services:
     - Authentication (Email/Password, Google, Apple)
     - Cloud Firestore
     - Firebase Storage
     - Crashlytics
4. Run `flutter run` to start the app

## Dependencies

### Core Dependencies
- Flutter SDK: ^3.6.2
- provider: ^6.1.1 (State Management)
- http: ^1.1.0 (Networking)

### Storage & Security
- shared_preferences: ^2.2.2
- flutter_secure_storage: ^9.2.4
- path: ^1.9.0
- path_provider: ^2.1.2

### UI & Effects
- easy_localization: ^3.0.3
- intl: ^0.19.0
- shimmer: ^3.0.0
- cached_network_image: ^3.4.1
- flutter_svg: ^2.0.17

### Firebase
- firebase_core: ^3.12.1
- firebase_crashlytics: ^4.3.4
- firebase_auth: ^5.5.1
- cloud_firestore: ^5.6.5
- firebase_storage: ^12.4.4
- google_sign_in: ^6.3.0
- sign_in_with_apple: ^6.1.4

### Notifications & Media
- flutter_local_notifications: ^18.0.1
- image_picker: ^1.1.2

### Code Generation
- json_annotation: ^4.9.0
- freezed_annotation: ^2.4.1

### Development
- flutter_test
- flutter_lints: ^5.0.0
- build_runner: ^2.4.15
- flutter_launcher_icons: ^0.13.1
- flutter_native_splash: ^2.3.11
- json_serializable: ^6.9.4
- freezed: ^2.4.5

## Features Guide

### Theme Management
- Dynamic theme switching (Light/Dark/System)
- Persistent theme preferences
- Material 3 design support

### Localization
- Support for 7 languages
- Easy addition of new languages
- Persistent language preferences
- Automatic locale detection

### Firebase Integration
- Complete authentication flow
- Cloud Firestore database integration
- Firebase Storage for file management
- Crashlytics for error tracking
- Social sign-in (Google and Apple)

### Local Notifications
- Push notification support
- Customizable notification content
- Support for both Android and iOS

### Image Handling
- Efficient image loading and caching
- Image picking from gallery/camera
- SVG support
- Placeholder support
- Error handling

### Error Tracking
- Firebase Crashlytics integration
- Automatic crash reporting
- Custom error logging
- Non-fatal error tracking
- Custom keys and logs

## Best Practices

- Follow clean architecture principles
- Use named routes for navigation
- Implement repository pattern for data access
- Keep UI and business logic separate
- Use constants for hardcoded values
- Document your code with comments
- Handle errors appropriately using Crashlytics
- Cache network resources when possible
- Use code generation for data models
- Implement proper state management

## Contributing

Feel free to submit issues and enhancement requests.
