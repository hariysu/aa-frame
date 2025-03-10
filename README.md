# AA Frame - Flutter App Template

A well-structured Flutter application template that follows best practices for scalable and maintainable code.

## Project Structure

```
lib/
├── config/             # App configuration
│   └── app_config.dart # Environment-specific configuration
├── core/               # Core functionality
│   ├── constants.dart  # App-wide constants
│   ├── theme.dart      # App theme configuration
│   └── utils.dart      # Utility functions
├── data/               # Data layer
│   ├── models/         # Data models
│   │   └── user_model.dart
│   ├── repositories/   # Repositories for data access
│   │   └── user_repository.dart
│   └── services/       # Services for external APIs
│       └── api_service.dart
├── presentation/       # UI layer
│   ├── screens/        # App screens
│   │   └── home_screen.dart
│   └── widgets/        # Reusable widgets
│       └── custom_button.dart
├── routes/             # Navigation
│   └── app_router.dart # App routing configuration
└── main.dart           # Entry point
```

## Features

- **Organized Structure**: Clear separation of concerns with a well-defined folder structure
- **Theme Support**: Light and dark theme support
- **Routing**: Centralized routing system
- **Environment Configuration**: Support for different environments (development, staging, production)
- **API Integration**: Ready-to-use API service for network requests
- **Reusable Components**: Custom widgets for consistent UI

## Getting Started

1. Clone this repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the app

## Dependencies

- Flutter SDK: ^3.6.2
- http: ^1.3.0
- flutter_lints: ^5.0.0

## Best Practices

- Use named routes for navigation
- Follow the repository pattern for data access
- Keep UI and business logic separate
- Use constants for hardcoded values
- Document your code with comments
