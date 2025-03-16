import 'package:flutter/material.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/settings_screen.dart';
import '../presentation/screens/cached_image_screen.dart';
import '../presentation/screens/crashlytics_test_screen.dart';
import '../presentation/screens/secure_storage_screen.dart';
import '../presentation/screens/svg_demo_screen.dart';
import '../presentation/screens/intl_demo_screen.dart';

/// Route names used in the app
class AppRoutes {
  static const String home = '/';
  static const String users = '/users';
  static const String userDetails = '/user-details';
  static const String settings = '/settings';
  static const String login = '/login';
  static const String register = '/register';
  static const String cachedImages = '/cached-images';
  static const String crashlyticsTest = '/crashlytics-test';
  static const String secureStorage = '/secure-storage';
  static const String svgDemo = '/svg-demo';
  static const String intlDemo = '/intl-demo';

  // Prevent instantiation
  AppRoutes._();
}

/// App router for handling navigation
class AppRouter {
  /// Generate routes for the app
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case AppRoutes.settings:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );

      case AppRoutes.cachedImages:
        return MaterialPageRoute(
          builder: (_) => const CachedImageScreen(),
        );

      case AppRoutes.crashlyticsTest:
        return MaterialPageRoute(
          builder: (_) => const CrashlyticsTestScreen(),
        );

      case AppRoutes.secureStorage:
        return MaterialPageRoute(
          builder: (_) => const SecureStorageScreen(),
        );

      case AppRoutes.svgDemo:
        return MaterialPageRoute(
          builder: (_) => const SvgDemoScreen(),
        );

      case AppRoutes.intlDemo:
        return MaterialPageRoute(
          builder: (_) => const IntlDemoScreen(),
        );

      // TODO: Add more routes as screens are created
      // case AppRoutes.users:
      //   return MaterialPageRoute(
      //     builder: (_) => const UsersScreen(),
      //   );

      // case AppRoutes.userDetails:
      //   final userId = settings.arguments as String;
      //   return MaterialPageRoute(
      //     builder: (_) => UserDetailsScreen(userId: userId),
      //   );

      // case AppRoutes.login:
      //   return MaterialPageRoute(
      //     builder: (_) => const LoginScreen(),
      //   );

      // case AppRoutes.register:
      //   return MaterialPageRoute(
      //     builder: (_) => const RegisterScreen(),
      //   );

      default:
        // If the route is not found, show a 404 page
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: const Text('Page Not Found'),
            ),
            body: const Center(
              child: Text('The requested page was not found.'),
            ),
          ),
        );
    }
  }

  /// Navigate to a named route
  static Future<T?> navigateTo<T>(BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context).pushNamed(routeName, arguments: arguments);
  }

  /// Replace the current route with a new one
  static Future<T?> navigateToReplacement<T>(
      BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  /// Clear the navigation stack and navigate to a new route
  static Future<T?> navigateToAndClearStack<T>(
      BuildContext context, String routeName,
      {Object? arguments}) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Go back to the previous screen
  static void goBack<T>(BuildContext context, [T? result]) {
    Navigator.of(context).pop(result);
  }
}
