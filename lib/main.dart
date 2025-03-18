import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'config/app_config.dart';
import 'core/theme.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/language_provider.dart';
import 'core/services/notification_service.dart';
import 'core/services/crashlytics_service.dart';
import 'routes/app_router.dart';
import 'firebase_options.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Keep the splash screen visible until initialization is complete
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize Crashlytics
    await CrashlyticsService.instance.initialize();

    // Initialize EasyLocalization
    await EasyLocalization.ensureInitialized();

    // Initialize notification service
    await NotificationService.instance.initialize();

    // Initialize app configuration
    AppConfig.initialize(environment: Environment.development);

    // Remove the splash screen once initialization is complete
    FlutterNativeSplash.remove();

    // Run the app
    runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
          Locale('tr'),
          Locale('de'),
          Locale('fr'),
          Locale('ja'),
          Locale('ar')
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        useOnlyLangCode: true,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => LanguageProvider()),
          ],
          child: const MyApp(),
        ),
      ),
    );
  } catch (error, stackTrace) {
    // Log any initialization errors to Crashlytics
    await CrashlyticsService.instance.logError(
      error,
      stackTrace,
      fatal: true,
    );
    rethrow;
  }
}

/// The main app widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current theme from the provider
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Access the locale to ensure the widget rebuilds when it changes
    final currentLocale = context.locale;

    return MaterialApp(
      title: AppConfig.instance.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRouter.onGenerateRoute,
      debugShowCheckedModeBanner: false,

      // Localization settings
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: currentLocale,
    );
  }
}
