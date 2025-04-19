#!/usr/bin/env bash

# Exit on error, treat unset variables as errors, propagate pipeline errors
set -eu -o pipefail

# --- Configuration ---
SCREEN_DIR="lib/screens"
MAIN_DART_FILE="lib/main.dart" # Or your primary screen file like lib/screens/home_screen.dart
PUBSPEC_FILE="pubspec.yaml"
# --- End Configuration ---

# --- Helper Functions ---
# Convert PascalCase or "Title Case" to snake_case
to_snake_case() {
  echo "$1" | tr -d "'" '"' | tr '[:upper:]' '[:lower:]' | tr ' ' '_'
}

# Convert PascalCase or "Title Case" to PascalCase for class names
to_pascal_case() {
  echo "$1" | tr -d "'" '"' | sed -r 's/(^| )([a-z])/\U\2/g' | tr -d ' '
}

# Convert PascalCase or "Title Case" to Title Case for display
to_title_case() {
  echo "$1" | tr -d "'" '"' | sed -r 's/(^| )([a-z])/\U\2/g'
}
# --- End Helper Functions ---

# Ensure the target directory exists
mkdir -p "$SCREEN_DIR"

# Check if any arguments were provided
if [ $# -eq 0 ]; then
  echo "Usage: $0 ScreenName1 [\"Screen Name 2\" ...]" >&2 # Error messages to stderr
  echo "Example: $0 Dashboard Settings \"User Profile\"" >&2
  exit 1
fi

# Attempt to get package name from pubspec.yaml
if [ ! -f "$PUBSPEC_FILE" ]; then
    echo "Error: Cannot find $PUBSPEC_FILE in the current directory." >&2
    echo "Please run this script from the root of your Flutter project." >&2
    exit 1
fi
PACKAGE_NAME=$(grep '^name:' "$PUBSPEC_FILE" | awk '{print $2}')
if [ -z "$PACKAGE_NAME" ]; then
  echo "Error: Could not determine package name from $PUBSPEC_FILE." >&2
  echo "Please ensure the 'name:' field is present in pubspec.yaml." >&2
  exit 1
fi
echo "Detected package name: $PACKAGE_NAME"
echo "----------------------------------------"

# Arrays to store generated info
declare -a screen_file_paths
declare -a class_names
declare -a screen_titles

# Loop through all arguments (screen names)
for screen_name_input in "$@"; do

  if [ -z "$screen_name_input" ]; then
    echo "Warning: Skipping empty screen name argument."
    continue
  fi

  # Generate names based on input
  screen_name_pascal=$(to_pascal_case "$screen_name_input")
  file_name=$(to_snake_case "$screen_name_input")_screen.dart
  file_path="$SCREEN_DIR/$file_name"
  class_name="${screen_name_pascal}Screen"
  screen_title=$(to_title_case "$screen_name_input") # Use pretty title case

  # Store info for later output
  screen_file_paths+=("$file_path")
  class_names+=("$class_name")
  screen_titles+=("$screen_title") # Store the pretty title

  # Check if file already exists
  if [ -e "$file_path" ]; then
    # Use printf for consistent output, even for info messages
    printf "Skipping generation: File already exists at %s\n" "$file_path"
    continue # Skip generation but keep info in arrays
  fi

  printf "Generating %s...\n" "$file_path"
  # Create the Dart file content using printf for the variable parts
  cat << EOF > "$file_path"
import 'package:flutter/material.dart';

class $class_name extends StatelessWidget {
  const $class_name({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('$screen_title'), // Use title case for AppBar
      ),
      body: Center(
        child: Text('Content for $screen_title goes here.'),
      ),
    );
  }
}
EOF

done

echo "----------------------------------------"
echo "Screen generation complete."
echo ""
echo "==> TODO: Manually update your main app file (e.g., $MAIN_DART_FILE or your home screen widget):"
echo ""
echo "1. Add the following import statements at the top:"
echo ""
echo "'''dart" # Use triple single quotes for Dart code block
# Generate import statements - Iterate over values
# Check if array is populated before looping
if [ ${#screen_file_paths[@]} -gt 0 ]; then
  for file_path_in_loop in "${screen_file_paths[@]}"; do
    if [ -z "$file_path_in_loop" ]; then continue; fi # Safety check
    # Construct package import path
    import_path="package:$PACKAGE_NAME/${file_path_in_loop#lib/}" # Remove 'lib/' prefix
    printf "import '%s';\n" "$import_path" # Use printf
  done
fi
echo "'''"
echo ""
echo "2. Add navigation logic. Here's a sample Drawer you can add to a Scaffold:"
echo ""
echo "'''dart" # Use triple single quotes for Dart code block
cat << 'EOF' # Use 'EOF' to prevent variable expansion in this static block
Scaffold(
  appBar: AppBar(
    title: const Text('xtcp'), // Or your app title
  ),
  drawer: Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue, // Or your theme color
          ),
          child: Text(
            'Menu',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
EOF
# Generate Drawer ListTiles - Iterate over indices (needed to sync titles and classes)
# Check if arrays are populated before looping
if [ ${#class_names[@]} -gt 0 ]; then
  for i in "${!class_names[@]}"; do
    # Ensure index exists for both arrays
    if [[ -v "class_names[$i]" && -v "screen_titles[$i]" ]]; then
      current_class_name="${class_names[$i]}"
      current_screen_title="${screen_titles[$i]}"
      # Use printf for generating the ListTile code
      printf "        ListTile(\n"
      printf "          leading: const Icon(Icons.chevron_right), // Replace with appropriate icons\n"
      printf "          title: const Text('%s'),\n" "$current_screen_title" # Quote the title safely
      printf "          onTap: () {\n"
      printf "            Navigator.pop(context); // Close the drawer\n"
      printf "            Navigator.push(\n"
      printf "              context,\n"
      printf "              MaterialPageRoute(builder: (context) => const %s()),\n" "$current_class_name"
      printf "            );\n"
      printf "          },\n"
      printf "        ),\n"
    else
        echo "Warning: Mismatch in array indices at index $i. Skipping ListTile generation for this item." >&2
    fi
  done
fi
cat << 'EOF' # Use 'EOF' to prevent variable expansion in this static block
      ],
    ),
  ),
  body: Center(
    child: Text('Your main content here'),
  ),
);
EOF
echo "'''"
echo ""
echo "Remember to adapt the sample code to fit your existing app structure!"
echo "----------------------------------------"

