import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SaaS Company Demo', // Updated app title
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blueAccent), // Changed seed color
        useMaterial3: true,
        // Optional: Define styles for TextButtons if needed
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor:
                Colors.white, // Set text color for buttons in AppBar
          ),
        ),
      ),
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Our Awesome SaaS'), // Updated page title
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // No counter state needed anymore
  // int _counter = 0;
  // void _incrementCounter() { ... }

  // Helper function to create menu items for clarity
  Widget _buildMenuItem(String title) {
    return Padding(
      // Add some padding around each menu item
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () {
          // Placeholder action - in a real app, this would navigate
          print('$title clicked');
          // You could use Navigator.pushNamed(context, '/$title'); if using routes
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('$title clicked! Navigation not implemented.')),
          );
        },
        child: Text(title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context)
            .colorScheme
            .primary, // Use primary color for AppBar
        title: Text(
          widget.title,
          style: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .onPrimary), // Ensure title text is visible
        ),
        // Use 'actions' for menu items on the right side of the AppBar
        actions: <Widget>[
          _buildMenuItem('Products'),
          _buildMenuItem('Open Source'),
          _buildMenuItem('Solutions'),
          _buildMenuItem('Learn'),
          _buildMenuItem('Docs'),
          _buildMenuItem('Pricing'),
          _buildMenuItem('Sign In'),
          _buildMenuItem('Downloads'),
          _buildMenuItem('Contact Us'),
          const SizedBox(width: 16), // Add some spacing at the end
        ],
      ),
      body: Center(
        // Replace the counter display with placeholder content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to ${widget.title}!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20), // Add some space
            const Text(
              'This is the main content area of your SaaS website.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Get Started Clicked!')),
                );
              },
              child: const Text('Get Started'),
            )
          ],
        ),
      ),
      // Removed the FloatingActionButton
      // floatingActionButton: FloatingActionButton(...)
    );
  }
}
