import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

/// Provider for managing app language
class LanguageProvider extends ChangeNotifier {
  static const String _languagePreferenceKey = 'language_code';
  static const String _countryPreferenceKey = 'country_code';

  // Default language is English
  Locale _locale = const Locale('en');

  /// Get current locale
  Locale get locale => _locale;

  /// Constructor loads saved language
  LanguageProvider() {
    _loadLanguageFromPrefs();
  }

  /// Load language from shared preferences
  Future<void> _loadLanguageFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguageCode = prefs.getString(_languagePreferenceKey);
    final savedCountryCode = prefs.getString(_countryPreferenceKey);

    if (savedLanguageCode != null) {
      _locale = Locale(savedLanguageCode, savedCountryCode);
      notifyListeners();
    }
  }

  /// Save language to shared preferences
  Future<void> _saveLanguageToPrefs(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languagePreferenceKey, locale.languageCode);
    if (locale.countryCode != null) {
      await prefs.setString(_countryPreferenceKey, locale.countryCode!);
    } else {
      await prefs.remove(_countryPreferenceKey);
    }
  }

  /// Set language
  Future<void> setLocale(BuildContext context, Locale locale) async {
    if (_locale.languageCode == locale.languageCode) return;

    _locale = locale;

    // Update the app's locale
    await context.setLocale(locale);

    // Save the preference
    await _saveLanguageToPrefs(locale);

    // Notify listeners after everything is done
    notifyListeners();
  }

  /// Get language name from locale
  String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'tr':
        return 'Türkçe';
      case 'de':
        return 'Deutsch';
      default:
        return 'Unknown';
    }
  }

  /// Get supported locales
  List<Locale> get supportedLocales => const [
        Locale('en'),
        Locale('es'),
        Locale('tr'),
        Locale('de'),
      ];
}
