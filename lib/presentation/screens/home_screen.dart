import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/utils.dart';
import '../../core/services/notification_service.dart';
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
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
                    Utils.showSnackBar(
                        context, 'home.users_button_pressed'.tr());
                  },
                  child: Text('home.view_users'.tr()),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    NotificationService.instance.showNotification(
                      title: 'AA Frame',
                      body: 'This is a test notification!',
                    );
                  },
                  child: const Text('Show Notification'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    AppRouter.navigateTo(context, AppRoutes.cachedImages);
                  },
                  child: const Text('View Cached Images'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    AppRouter.navigateTo(context, AppRoutes.crashlyticsTest);
                  },
                  child: const Text('Test Crashlytics'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    AppRouter.navigateTo(context, AppRoutes.secureStorage);
                  },
                  child: const Text('Secure Storage'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    AppRouter.navigateTo(context, AppRoutes.svgDemo);
                  },
                  child: const Text('SVG Demo'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    AppRouter.navigateTo(context, AppRoutes.intlDemo);
                  },
                  child: const Text('Intl Features'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    AppRouter.navigateTo(context, AppRoutes.shimmerDemo);
                  },
                  child: const Text('Shimmer Demo'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    AppRouter.navigateTo(context, AppRoutes.sinirDegerler);
                  },
                  child: const Text('Sınır Değerler'),
                ),
              ],
            ),
          ),
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
