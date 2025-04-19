// Add this import for Google Fonts
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

// --- Add Imports for your refactored screen content widgets ---
// Make sure the package name 'flutter_experiment' matches your pubspec.yaml
// And that these files now contain the '...ScreenContent' classes
import 'package:flutter_experiment/screens/products_screen.dart';
import 'package:flutter_experiment/screens/open_source_screen.dart';
import 'package:flutter_experiment/screens/solutions_screen.dart';
import 'package:flutter_experiment/screens/learn_screen.dart';
import 'package:flutter_experiment/screens/docs_screen.dart';
import 'package:flutter_experiment/screens/pricing_screen.dart';
import 'package:flutter_experiment/screens/sign_in_screen.dart';
import 'package:flutter_experiment/screens/downloads_screen.dart';
import 'package:flutter_experiment/screens/contact_us_screen.dart';
// --- End Screen Imports ---

// Import url_launcher if you want clickable links later
// import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

// --- Enum to represent the different content sections ---
enum ContentSection {
  home,
  products,
  openSource,
  solutions,
  learn,
  docs,
  pricing,
  signIn,
  downloads,
  contactUs,
}
// --- End Enum ---

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define our custom dark colors
    const Color darkGrey = Color(0xFF1A1A1A); // Very dark grey
    const Color darkGreen =
        Color.fromARGB(255, 102, 177, 102); // A standard dark green
    const Color accentYellow =
        Color.fromARGB(255, 231, 210, 94); // Gold/Yellow accent

    // Get the base dark text theme using a monospace font
    final baseTextTheme =
        GoogleFonts.sourceCodeProTextTheme(ThemeData.dark().textTheme);

    // Create a new text theme with slightly larger default sizes
    final largerTextTheme = baseTextTheme.copyWith(
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(fontSize: 16.0),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(fontSize: 15.0),
      labelLarge: baseTextTheme.labelLarge?.copyWith(fontSize: 16.0),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(fontSize: 26.0),
    );

    return MaterialApp(
      title: 'xtcp',
      theme: ThemeData(
        brightness: Brightness.dark,
        textTheme: largerTextTheme,
        colorScheme: const ColorScheme.dark(
          primary: darkGreen,
          secondary: accentYellow,
          background: darkGrey,
          surface: darkGrey,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.white,
          error: Colors.redAccent,
          onError: Colors.white,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: darkGreen,
          foregroundColor: Colors.white,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: largerTextTheme.labelLarge,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: accentYellow,
            foregroundColor: Colors.black,
            textStyle: largerTextTheme.labelLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: accentYellow,
          selectionColor: darkGreen.withOpacity(0.5),
          selectionHandleColor: accentYellow,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'xtcp'),
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
  // --- State variable to track the currently selected section ---
  ContentSection _currentSection = ContentSection.home;
  // --- End State variable ---

  // --- Custom Helper Function for Notifications ---
  void showNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
  // --- End Custom Helper Function ---

  // --- Updated Helper function to create standard menu items ---
  // Now updates the state instead of navigating
  Widget _buildMenuItem(String title, ContentSection section) {
    // Highlight the currently selected item (optional)
    final bool isSelected = _currentSection == section;
    final Color textColor =
        isSelected ? Theme.of(context).colorScheme.secondary : Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () {
          // Update the state to show the selected section
          setState(() {
            _currentSection = section;
          });
          // --- NO Navigator.push here ---
        },
        child: Text(
          title,
          style: TextStyle(
            color: textColor, // Apply highlight color
            fontWeight: isSelected
                ? FontWeight.bold
                : FontWeight.normal, // Bold if selected
          ),
        ),
      ),
    );
  }
  // --- End Updated Helper function ---

  // Helper function for footer links (no changes needed here)
  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: InkWell(
        onTap: () {
          print('$text link clicked');
          showNotification(
              context, '$text link clicked! Navigation not implemented.');
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            decoration: TextDecoration.underline,
            decorationColor:
                Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  // --- Function to get the content widget based on the current section ---
  Widget _getContentWidget() {
    switch (_currentSection) {
      // Ensure these are the '...ScreenContent' classes from your refactored files
      case ContentSection.products:
        return const ProductsScreenContent();
      case ContentSection.openSource:
        return const OpenSourceScreenContent();
      case ContentSection.solutions:
        return const SolutionsScreenContent();
      case ContentSection.learn:
        return const LearnScreenContent();
      case ContentSection.docs:
        return const DocsScreenContent();
      case ContentSection.pricing:
        return const PricingScreenContent();
      case ContentSection.signIn:
        return const SignInScreenContent();
      case ContentSection.downloads:
        return const DownloadsScreenContent();
      case ContentSection.contactUs:
        return const ContactUsScreenContent();
      case ContentSection.home:
      default:
        // Default home content
        return Center(
          child: Padding(
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
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    showNotification(context, 'Get Started Clicked!');
                  },
                  child: const Text('Get Started'),
                )
              ],
            ),
          ),
        );
    }
  }
  // --- End Content Widget Function ---

  @override
  Widget build(BuildContext context) {
    final int currentYear = DateTime.now().year;

    return Scaffold(
      appBar: AppBar(
        // --- Add a Home button/Logo to return to home ---
        leading: IconButton(
          icon: const Icon(Icons.home), // Or use an Image.asset for a logo
          tooltip: 'Home',
          onPressed: () {
            setState(() {
              _currentSection = ContentSection.home;
            });
          },
        ),
        // --- End Home button ---
        title: Text(widget.title),
        actions: <Widget>[
          // --- Update calls to _buildMenuItem with ContentSection enum values ---
          _buildMenuItem('Products', ContentSection.products),
          _buildMenuItem('Open Source', ContentSection.openSource),
          _buildMenuItem('Solutions', ContentSection.solutions),
          _buildMenuItem('Learn', ContentSection.learn),
          _buildMenuItem('Docs', ContentSection.docs),
          _buildMenuItem('Pricing', ContentSection.pricing),
          // --- End Updated calls ---

          // --- Update Highlighted Sign In Button ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                // Update state to show Sign In content
                setState(() {
                  _currentSection = ContentSection.signIn;
                });
                // --- NO Navigator.push here ---
              },
              // Optional: Style differently if Sign In is selected
              style: ElevatedButton.styleFrom(
                backgroundColor: _currentSection == ContentSection.signIn
                    ? Theme.of(context)
                        .colorScheme
                        .primary // Use primary if selected
                    : Theme.of(context)
                        .colorScheme
                        .secondary, // Use accent otherwise
                foregroundColor: _currentSection == ContentSection.signIn
                    ? Colors.white
                    : Colors.black,
              ),
              child: const Text('Sign In'),
            ),
          ),
          // --- End Update Highlighted Sign In Button ---

          // --- Update remaining calls to _buildMenuItem ---
          _buildMenuItem('Downloads', ContentSection.downloads),
          _buildMenuItem('Contact Us', ContentSection.contactUs),
          // --- End Updated calls ---
          const SizedBox(width: 16),
        ],
      ),
      // Testing body
      // body: Column(
      //   children: [
      //     // Main content area - takes up available space
      //     Expanded(
      //       // --- TEMPORARY TEST ---
      //       // Replace _getContentWidget() with a simple Text widget
      //       child: Center(
      //         child: Text(
      //           'Current Section: $_currentSection',
      //           style: Theme.of(context).textTheme.headlineMedium,
      //         ),
      //       ),
      //       // child: _getContentWidget(), // Original line
      //       // --- END TEMPORARY TEST ---
      //     ),
      //     // Footer section (remains the same)
      //     // ... (footer code) ...
      //   ],
      // ),

      // --- Body now uses the _getContentWidget function ---
      body: Column(
        children: [
          // Main content area - takes up available space
          Expanded(
            child: _getContentWidget(), // Dynamically display content here
          ),
          // Footer section (remains the same)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8.0,
                  runSpacing: 4.0,
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
                        .onSurface
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

// --- Placeholder Content Widgets ---
// IMPORTANT: These should ideally live in their respective screen files
// and those files should import 'package:flutter/material.dart'.

class ProductsScreenContent extends StatelessWidget {
  const ProductsScreenContent({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Products Content Area'));
  }
}

class OpenSourceScreenContent extends StatelessWidget {
  const OpenSourceScreenContent({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Open Source Content Area'));
  }
}

class SolutionsScreenContent extends StatelessWidget {
  const SolutionsScreenContent({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Solutions Content Area'));
  }
}

class LearnScreenContent extends StatelessWidget {
  const LearnScreenContent({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Learn Content Area'));
  }
}

class DocsScreenContent extends StatelessWidget {
  const DocsScreenContent({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Docs Content Area'));
  }
}

class PricingScreenContent extends StatelessWidget {
  const PricingScreenContent({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Pricing Content Area'));
  }
}

class SignInScreenContent extends StatelessWidget {
  const SignInScreenContent({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Sign In Content Area'));
  }
}

class DownloadsScreenContent extends StatelessWidget {
  const DownloadsScreenContent({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Downloads Content Area'));
  }
}

class ContactUsScreenContent extends StatelessWidget {
  const ContactUsScreenContent({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Content for Contact Us goes here.'));
  }
}
// --- End Placeholder Content Widgets ---
