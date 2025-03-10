import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/theme_provider.dart';
import '../../core/utils.dart';

/// Settings screen for the application
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme section
          const _SectionHeader(title: 'Appearance'),

          // Theme mode selection
          _ThemeModeSelector(
            currentThemeMode: themeProvider.themeMode,
            onThemeModeChanged: (ThemeMode mode) {
              themeProvider.setThemeMode(mode);
              Utils.showSnackBar(
                context,
                'Theme changed to ${_getThemeModeName(mode)}',
              );
            },
          ),

          const Divider(),

          // App info section
          const _SectionHeader(title: 'App Information'),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            subtitle: const Text('App version, licenses, and more'),
            onTap: () {
              // TODO: Navigate to about screen
              Utils.showSnackBar(context, 'About pressed');
            },
          ),
        ],
      ),
    );
  }

  /// Get readable name for theme mode
  String _getThemeModeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
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
          title: const Text('Light Theme'),
          value: ThemeMode.light,
          groupValue: currentThemeMode,
          onChanged: (ThemeMode? value) {
            if (value != null) onThemeModeChanged(value);
          },
        ),
        RadioListTile<ThemeMode>(
          title: const Text('Dark Theme'),
          value: ThemeMode.dark,
          groupValue: currentThemeMode,
          onChanged: (ThemeMode? value) {
            if (value != null) onThemeModeChanged(value);
          },
        ),
        RadioListTile<ThemeMode>(
          title: const Text('System Theme'),
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
