import 'package:flutter/material.dart';

// Renamed class to reflect it's just the content part
class LearnScreenContent extends StatelessWidget {
  const LearnScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Removed the Scaffold and AppBar
    // Return only the widget that represents the body content for this section
    return const Center(
      child: Text('Content for Learn goes here.'), // Updated text
    );
  }
}
