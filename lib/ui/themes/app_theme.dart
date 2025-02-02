import 'package:flutter/material.dart';

import '../../theme/styles.dart';

class AppTheme {
  static ThemeData getAppTheme() {
    return ThemeData(
      useMaterial3: true, // Enables Material 3 design

      // Primary color scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: Styles.lightGreen, // Green seed color
        primary: Styles.lightGreen, // Green primary color
        secondary: Styles.obscureGreen, // Green secondary color
        brightness: Brightness.light, // For light theme
      ),

      // AppBar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Styles.lightGreen, // Green background for AppBar
        foregroundColor: Colors.white, // White text/icons for AppBar
        elevation: 0, // Flat AppBar
      ),

      // Text styles
      textTheme: const TextTheme(
        bodyMedium:
            TextStyle(fontSize: 16, color: Colors.black), // Default body text
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black, // Headline text color
        ),
      ),

      // Button styling
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Styles.lightGreen, // Green button background
          foregroundColor: Colors.white, // White text on buttons
          textStyle: const TextStyle(fontSize: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
        ),
      ),

      // Icon theme
      iconTheme: const IconThemeData(color: Styles.lightGreen),
    );
  }
}
