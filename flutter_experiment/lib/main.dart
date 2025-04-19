// Add this import for Google Fonts
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
// Import url_launcher if you want clickable links later
// import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define our custom dark colors
    const Color darkGrey = Color(0xFF1A1A1A); // Very dark grey
    // Changed from darkRed to darkGreen
    const Color darkGreen =
        Color.fromARGB(255, 102, 177, 102); // A standard dark green
    const Color accentYellow =
        Color.fromARGB(255, 231, 210, 94); // Gold/Yellow accent

    // Get the base dark text theme using a monospace font
    final baseTextTheme =
        GoogleFonts.sourceCodeProTextTheme(ThemeData.dark().textTheme);

    // Create a new text theme with slightly larger default sizes
    final largerTextTheme = baseTextTheme.copyWith(
      bodyLarge: baseTextTheme.bodyLarge
          ?.copyWith(fontSize: 16.0), // Increase default body text
      bodyMedium: baseTextTheme.bodyMedium
          ?.copyWith(fontSize: 15.0), // Increase default body text
      labelLarge: baseTextTheme.labelLarge
          ?.copyWith(fontSize: 16.0), // Increase button text size
      headlineMedium: baseTextTheme.headlineMedium
          ?.copyWith(fontSize: 26.0), // Adjust headline size if needed
      // You can adjust other styles (headlineSmall, titleLarge, etc.) here too
    );

    return MaterialApp(
      title: 'SaaS Company Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        // Apply the custom text theme globally
        textTheme: largerTextTheme,
        colorScheme: const ColorScheme.dark(
          // Use dark green as the primary accent
          primary: darkGreen,
          secondary: accentYellow,
          background: darkGrey,
          surface: darkGrey,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onBackground: Colors.white,
          onSurface: Colors.white,
          error: Colors.redAccent,
          onError: Colors.white,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          // Make AppBar use the primary dark green
          backgroundColor: darkGreen,
          foregroundColor: Colors.white,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            // Ensure menu text is white and uses the themed font size
            foregroundColor: Colors.white,
            textStyle: largerTextTheme.labelLarge, // Use themed button style
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentYellow,
            foregroundColor: Colors.black,
            // Ensure button text uses the themed font size
            textStyle: largerTextTheme.labelLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        // Style for footer links
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: accentYellow, // Optional: change cursor color
          selectionColor: darkGreen.withOpacity(0.5),
          selectionHandleColor: accentYellow,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Our Awesome SaaS'),
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
  // Helper function to create standard menu items
  Widget _buildMenuItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () {
          print('$title clicked');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('$title clicked! Navigation not implemented.')),
          );
        },
        child: Text(title), // Text style now comes from theme
      ),
    );
  }

  // Helper function for footer links
  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell(
        // Use InkWell for tap effect, TextButton also works
        onTap: () {
          print('$text link clicked');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('$text link clicked! Navigation not implemented.')),
          );
          // Example for actual navigation (requires url_launcher package):
          // final Uri url = Uri.parse('https://yourcompany.com/$text'); // Adjust URL
          // if (!await launchUrl(url)) {
          //   print('Could not launch $url');
          // }
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13, // Slightly smaller for footer
            color: Theme.of(context)
                .colorScheme
                .onBackground
                .withOpacity(0.7), // Slightly dimmer text
            decoration: TextDecoration.underline, // Optional: underline links
            decorationColor:
                Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int currentYear =
        DateTime.now().year; // Get current year for copyright

    // Define accentYellow here or access from theme if preferred
    // Using the same definition as in MyApp for consistency
    const Color accentYellow = Color.fromARGB(255, 231, 210, 94);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          _buildMenuItem('Products'),
          _buildMenuItem('Open Source'),
          _buildMenuItem('Solutions'),
          _buildMenuItem('Learn'),
          _buildMenuItem('Docs'),
          _buildMenuItem('Pricing'),

          // --- Highlighted Sign In Button ---
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0), // Add vertical padding to align better
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    accentYellow, // Use the accent color for background
                foregroundColor: Colors.black, // Text color on yellow
                // Optional: Adjust padding if needed to match TextButton height
                // padding: EdgeInsets.symmetric(horizontal: 16.0),
                // Optional: Ensure text style matches theme if needed (usually automatic)
                // textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  // Optional: make it less rounded if desired
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                print('Sign In clicked');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('Sign In clicked! Navigation not implemented.')),
                );
              },
              child: const Text('Sign In'),
            ),
          ),
          // --- End Highlighted Sign In Button ---

          _buildMenuItem('Downloads'),
          _buildMenuItem('Contact Us'),
          const SizedBox(width: 16),
        ],
      ),
      // Use a Column to arrange main content and footer
      body: Column(
        children: [
          // Main content area - takes up available space
          Expanded(
            child: Center(
              child: Padding(
                // Add padding around the central content
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Welcome to ${widget.title}!',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'This is the main content area of your SaaS website.',
                      textAlign: TextAlign.center,
                      // Font size now comes from theme
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      // This button uses the default ElevatedButton theme (yellow bg)
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
            ),
          ),
          // Footer section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Wrap(
                  // Use Wrap for better responsiveness on small screens
                  alignment: WrapAlignment.center, // Center the links
                  spacing: 8.0, // Horizontal space between links
                  runSpacing: 4.0, // Vertical space if links wrap
                  children: [
                    _buildFooterLink('Legal'),
                    _buildFooterLink('Terms of Service'),
                    _buildFooterLink('Privacy Policy'),
                    _buildFooterLink('Trademark'),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Copyright © $currentYear ${widget.title}. All Rights Reserved.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
