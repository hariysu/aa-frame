import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/providers/theme_provider.dart';
import '../../core/providers/language_provider.dart';
import '../../core/utils.dart';

/// Settings screen for the application
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('settings.title'.tr()),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme section
          _SectionHeader(title: 'settings.appearance'.tr()),

          // Theme mode selection
          _ThemeModeSelector(
            currentThemeMode: themeProvider.themeMode,
            onThemeModeChanged: (ThemeMode mode) {
              themeProvider.setThemeMode(mode);

              // Get the translated theme name
              final themeName = mode == ThemeMode.light
                  ? 'settings.theme.light'.tr()
                  : mode == ThemeMode.dark
                      ? 'settings.theme.dark'.tr()
                      : 'settings.theme.system'.tr();

              Utils.showSnackBar(
                context,
                'settings.theme.changed'.tr(namedArgs: {'theme': themeName}),
              );
            },
          ),

          const Divider(),

          // Language section
          _SectionHeader(title: 'settings.language.title'.tr()),

          // Language selection
          _LanguageSelector(
            currentLocale: context.locale,
            supportedLocales: languageProvider.supportedLocales,
            onLocaleChanged: (Locale locale) async {
              await languageProvider.setLocale(context, locale);

              // Get the language name based on locale
              String languageName;
              switch (locale.languageCode) {
                case 'en':
                  languageName = 'settings.language.english'.tr();
                  break;
                case 'es':
                  languageName = 'settings.language.spanish'.tr();
                  break;
                case 'tr':
                  languageName = 'settings.language.turkish'.tr();
                  break;
                case 'de':
                  languageName = 'settings.language.german'.tr();
                  break;
                case 'fr':
                  languageName = 'settings.language.french'.tr();
                  break;
                case 'ja':
                  languageName = 'settings.language.japanese'.tr();
                  break;
                case 'ar':
                  languageName = 'settings.language.arabic'.tr();
                  break;
                default:
                  languageName = locale.languageCode;
              }

              Utils.showSnackBar(
                context,
                'settings.language.changed'
                    .tr(namedArgs: {'language': languageName}),
              );
            },
          ),

          const Divider(),

          // App info section
          _SectionHeader(title: 'settings.about.title'.tr()),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text('settings.about.title'.tr()),
            subtitle: Text('settings.about.subtitle'.tr()),
            onTap: () {
              // TODO: Navigate to about screen
              Utils.showSnackBar(context, 'settings.about.button_pressed'.tr());
            },
          ),
        ],
      ),
    );
  }
}

/// Section header widget
class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

/// Theme mode selector widget
class _ThemeModeSelector extends StatelessWidget {
  final ThemeMode currentThemeMode;
  final Function(ThemeMode) onThemeModeChanged;

  const _ThemeModeSelector({
    required this.currentThemeMode,
    required this.onThemeModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<ThemeMode>(
          title: Text('settings.theme.light'.tr()),
          value: ThemeMode.light,
          groupValue: currentThemeMode,
          onChanged: (ThemeMode? value) {
            if (value != null) onThemeModeChanged(value);
          },
        ),
        RadioListTile<ThemeMode>(
          title: Text('settings.theme.dark'.tr()),
          value: ThemeMode.dark,
          groupValue: currentThemeMode,
          onChanged: (ThemeMode? value) {
            if (value != null) onThemeModeChanged(value);
          },
        ),
        RadioListTile<ThemeMode>(
          title: Text('settings.theme.system'.tr()),
          value: ThemeMode.system,
          groupValue: currentThemeMode,
          onChanged: (ThemeMode? value) {
            if (value != null) onThemeModeChanged(value);
          },
        ),
      ],
    );
  }
}

/// Language selector widget
class _LanguageSelector extends StatelessWidget {
  final Locale currentLocale;
  final List<Locale> supportedLocales;
  final Function(Locale) onLocaleChanged;

  const _LanguageSelector({
    required this.currentLocale,
    required this.supportedLocales,
    required this.onLocaleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: supportedLocales.map((locale) {
        final languageName = _getLanguageName(locale);

        return RadioListTile<String>(
          title: Text(languageName),
          value: locale.languageCode,
          groupValue: currentLocale.languageCode,
          onChanged: (String? value) {
            if (value != null) {
              // Use a slight delay to ensure the UI updates properly
              Future.delayed(Duration.zero, () {
                onLocaleChanged(Locale(value));
              });
            }
          },
        );
      }).toList(),
    );
  }

  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'settings.language.english'.tr();
      case 'es':
        return 'settings.language.spanish'.tr();
      case 'tr':
        return 'settings.language.turkish'.tr();
      case 'de':
        return 'settings.language.german'.tr();
      case 'fr':
        return 'settings.language.french'.tr();
      case 'ja':
        return 'settings.language.japanese'.tr();
      case 'ar':
        return 'settings.language.arabic'.tr();
      default:
        return locale.languageCode;
    }
  }
}
