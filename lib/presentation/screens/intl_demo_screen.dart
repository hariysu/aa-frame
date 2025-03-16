import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';

class IntlDemoScreen extends StatelessWidget {
  const IntlDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current locale from context
    final currentLocale = Localizations.localeOf(context).toString();

    // Current date and time
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text('intl_demo.title'.tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(
              title: 'intl_demo.current_locale.title'.tr(),
              content: currentLocale,
              description: 'intl_demo.current_locale.description'.tr(),
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'intl_demo.date_formatting.title'.tr(),
              content: DateFormat.yMMMMd(currentLocale).format(now),
              description: 'intl_demo.date_formatting.description'.tr(),
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'intl_demo.time_formatting.title'.tr(),
              content: DateFormat.jms(currentLocale).format(now),
              description: 'intl_demo.time_formatting.description'.tr(),
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'intl_demo.number_formatting.title'.tr(),
              content: NumberFormat.currency(
                locale: currentLocale,
                symbol: 'intl_demo.currency_symbol'.tr(),
              ).format(1234.56),
              description: 'intl_demo.number_formatting.description'.tr(),
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'intl_demo.compact_number.title'.tr(),
              content:
                  NumberFormat.compact(locale: currentLocale).format(1234567),
              description: 'intl_demo.compact_number.description'.tr(),
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'intl_demo.percentage.title'.tr(),
              content:
                  NumberFormat.percentPattern(currentLocale).format(0.1756),
              description: 'intl_demo.percentage.description'.tr(),
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'intl_demo.relative_time.title'.tr(),
              content: _getRelativeTime(
                  now.subtract(const Duration(minutes: 30)), currentLocale),
              description: 'intl_demo.relative_time.description'.tr(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String content,
    required String description,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                content,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getRelativeTime(DateTime dateTime, String locale) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return DateFormat.yMMMd(locale).format(dateTime);
    } else if (difference.inHours > 0) {
      final hours = difference.inHours;
      final hoursText = hours == 1
          ? 'intl_demo.time_units.hour_singular'.tr()
          : 'intl_demo.time_units.hour_plural'.tr();

      // Handle different word order for different languages
      if (locale.startsWith('ar') || locale.startsWith('tr')) {
        return '$hours $hoursText ${'intl_demo.time_units.ago'.tr()}';
      } else if (locale.startsWith('fr')) {
        return '${'intl_demo.time_units.ago'.tr()} $hours $hoursText';
      } else if (locale.startsWith('de')) {
        return '${'intl_demo.time_units.ago'.tr()} $hours $hoursText';
      } else {
        return '$hours $hoursText ${'intl_demo.time_units.ago'.tr()}';
      }
    } else if (difference.inMinutes > 0) {
      final minutes = difference.inMinutes;
      final minutesText = minutes == 1
          ? 'intl_demo.time_units.minute_singular'.tr()
          : 'intl_demo.time_units.minute_plural'.tr();

      // Handle different word order for different languages
      if (locale.startsWith('ar') || locale.startsWith('tr')) {
        return '$minutes $minutesText ${'intl_demo.time_units.ago'.tr()}';
      } else if (locale.startsWith('fr')) {
        return '${'intl_demo.time_units.ago'.tr()} $minutes $minutesText';
      } else if (locale.startsWith('de')) {
        return '${'intl_demo.time_units.ago'.tr()} $minutes $minutesText';
      } else {
        return '$minutes $minutesText ${'intl_demo.time_units.ago'.tr()}';
      }
    } else {
      return 'intl_demo.time_units.just_now'.tr();
    }
  }
}
