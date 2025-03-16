import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgDemoScreen extends StatelessWidget {
  const SvgDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SVG Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Local SVG',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: SvgPicture.asset(
                        'assets/svg/flutter_logo.svg',
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'This SVG is loaded from local assets. It demonstrates how to load and display SVG files bundled with your app.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Network SVG',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: SvgPicture.network(
                        'https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg',
                        height: 100,
                        placeholderBuilder: (context) => const SizedBox(
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'This SVG is loaded from the network. It demonstrates how to load SVGs from URLs and show a loading indicator while the SVG is being downloaded.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Colorized SVG',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: SvgPicture.asset(
                        'assets/svg/flutter_logo.svg',
                        height: 100,
                        colorFilter: const ColorFilter.mode(
                          Colors.purple,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'This demonstrates how to colorize an SVG using ColorFilter. The same SVG is displayed with a different color.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
