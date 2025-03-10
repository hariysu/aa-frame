import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/utils.dart';
import '../../routes/app_router.dart';

/// Home screen of the application
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This ensures the widget rebuilds when the locale changes
    context.locale;

    return Scaffold(
      appBar: AppBar(
        title: Text('home.title'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings screen
              AppRouter.navigateTo(context, AppRoutes.settings);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'home.welcome'.tr(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to users screen
                Utils.showSnackBar(context, 'home.users_button_pressed'.tr());
              },
              child: Text('home.view_users'.tr()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add new item
          Utils.showSnackBar(context, 'home.add_button_pressed'.tr());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
