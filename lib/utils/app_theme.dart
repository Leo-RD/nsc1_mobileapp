import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_constants.dart';

/// Centralized theme configuration
class AppTheme {
  // Colors
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color primaryGreen = Color(0xFF4CAF50);
  static const Color primaryRed = Color(0xFFE53935);
  static const Color warningOrange = Color(0xFFFF9800);

  // Background Images
  static const String lightBackgroundImage = 'assets/images/skybox.jpg';
  static const String darkBackgroundImage =
      'assets/images/misty-starry-night-sky-background.jpg';

  // Glass Effect Colors
  static Color glassBackground(bool isDark) => isDark
      ? Colors.white.withOpacity(AppConstants.lowOpacity)
      : Colors.white.withOpacity(AppConstants.lowOpacity);

  static Color glassBorder(bool isDark) => isDark
      ? Colors.white.withOpacity(AppConstants.mediumOpacity)
      : Colors.white.withOpacity(AppConstants.mediumOpacity);

  // Text Styles
  static TextStyle titleStyle(bool isDark) => GoogleFonts.titilliumWeb(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : Colors.black,
        letterSpacing: 2.0,
      );

  static TextStyle headingStyle(bool isDark) => GoogleFonts.titilliumWeb(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : Colors.black,
      );

  static TextStyle subheadingStyle(bool isDark) => GoogleFonts.titilliumWeb(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : Colors.black,
      );

  static TextStyle bodyStyle(bool isDark) => GoogleFonts.titilliumWeb(
        fontSize: 16,
        color: isDark ? Colors.white : Colors.black,
      );

  static TextStyle captionStyle(bool isDark) => GoogleFonts.titilliumWeb(
        fontSize: 14,
        color: isDark ? Colors.white70 : Colors.black54,
      );

  static TextStyle buttonTextStyle() => GoogleFonts.titilliumWeb(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  static TextStyle hintStyle(bool isDark) => GoogleFonts.titilliumWeb(
        color: isDark ? Colors.white70 : Colors.black.withOpacity(0.7),
        fontStyle: FontStyle.italic,
      );

  // Light Theme
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: Colors.white,
      textTheme: GoogleFonts.titilliumWebTextTheme(ThemeData.light().textTheme),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.mediumSpacing,
          vertical: AppConstants.mediumSpacing,
        ),
      ),
    );
  }

  // Dark Theme
  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: Colors.black,
      colorScheme: const ColorScheme.dark().copyWith(primary: primaryBlue),
      textTheme: GoogleFonts.titilliumWebTextTheme(ThemeData.dark().textTheme),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppConstants.mediumSpacing,
          vertical: AppConstants.mediumSpacing,
        ),
      ),
    );
  }

  // Glass Container Decoration
  static BoxDecoration glassDecoration(bool isDark) {
    return BoxDecoration(
      color: glassBackground(isDark),
      borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
      border: Border.all(
        color: glassBorder(isDark),
        width: 1,
      ),
    );
  }

  // Button Gradient
  static LinearGradient buttonGradient(Color color) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        color.withOpacity(0.95),
        color.withOpacity(0.75),
      ],
    );
  }

  // Button Shadow
  static List<BoxShadow> buttonShadow(Color color) {
    return [
      BoxShadow(
        color: color.withOpacity(0.45),
        blurRadius: 14,
        spreadRadius: 1,
        offset: const Offset(0, 6),
      ),
    ];
  }

  // Private constructor
  AppTheme._();
}
