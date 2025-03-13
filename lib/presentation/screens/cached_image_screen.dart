import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';

class CachedImageScreen extends StatelessWidget {
  const CachedImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample image URLs for demonstration
    const List<String> imageUrls = [
      'https://picsum.photos/800/400',
      'https://picsum.photos/800/401',
      'https://picsum.photos/800/402',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cached Images'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageUrls[index],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Image ${index + 1}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This image is cached and will load instantly on subsequent views.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
