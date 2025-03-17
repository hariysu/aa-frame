import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

class ShimmerDemoScreen extends StatefulWidget {
  const ShimmerDemoScreen({super.key});

  @override
  State<ShimmerDemoScreen> createState() => _ShimmerDemoScreenState();
}

class _ShimmerDemoScreenState extends State<ShimmerDemoScreen> {
  bool _isLoading = true;
  final List<_DemoItem> _items = [];

  @override
  void initState() {
    super.initState();
    // Simulate loading data
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _loadItems();
        });
      }
    });
  }

  void _loadItems() {
    final now = DateTime.now();
    final formatter = NumberFormat.currency(
      locale: context.locale.toString(),
      symbol: 'intl_demo.currency_symbol'.tr(),
    );

    for (int i = 1; i <= 20; i++) {
      _items.add(
        _DemoItem(
          id: i,
          title:
              'shimmer_demo.item_title'.tr(namedArgs: {'number': i.toString()}),
          subtitle: DateFormat.yMMMd(context.locale.toString())
              .format(now.subtract(Duration(days: i))),
          price: formatter.format(10.0 * i),
        ),
      );
    }
  }

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('shimmer_demo.title'.tr()),
        actions: [
          IconButton(
            icon: Icon(_isLoading ? Icons.visibility : Icons.visibility_off),
            onPressed: _toggleLoading,
            tooltip: _isLoading
                ? 'shimmer_demo.show_content'.tr()
                : 'shimmer_demo.show_shimmer'.tr(),
          ),
        ],
      ),
      body: _isLoading ? _buildShimmerList() : _buildContentList(),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 10,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildShimmerItem(),
        );
      },
    );
  }

  Widget _buildShimmerItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 100,
                    height: 12,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 80,
                    height: 12,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentList() {
    return ListView.builder(
      itemCount: _items.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final item = _items[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildContentItem(item),
        );
      },
    );
  }

  Widget _buildContentItem(_DemoItem item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.primaries[item.id % Colors.primaries.length],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '${item.id}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.price,
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoItem {
  final int id;
  final String title;
  final String subtitle;
  final String price;

  _DemoItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
  });
}
