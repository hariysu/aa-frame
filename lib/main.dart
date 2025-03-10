import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'config/app_config.dart';
import 'core/theme.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/language_provider.dart';
import 'routes/app_router.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize EasyLocalization
  await EasyLocalization.ensureInitialized();

  // Initialize app configuration
  AppConfig.initialize(environment: Environment.development);

  // Run the app
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('tr'),
        Locale('de')
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
