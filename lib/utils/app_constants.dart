/// Application-wide constants
class AppConstants {
  // App Info
  static const String appName = 'NSC1 Secure Door';
  static const String appVersion = '1.0.1';
  static const String logoPath = 'assets/images/logonsc1.png';

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 400);
  static const Duration longAnimationDuration = Duration(milliseconds: 1000);

  // Blur Effects
  static const double lightBlur = 10.0;
  static const double mediumBlur = 15.0;
  static const double heavyBlur = 20.0;

  // Border Radius
  static const double smallRadius = 8.0;
  static const double mediumRadius = 12.0;
  static const double largeRadius = 16.0;

  // Spacing
  static const double smallSpacing = 8.0;
  static const double mediumSpacing = 16.0;
  static const double largeSpacing = 24.0;
  static const double extraLargeSpacing = 32.0;

  // Button Heights
  static const double buttonHeight = 56.0;
  static const double smallButtonHeight = 50.0;

  // Opacity Values
  static const double lowOpacity = 0.1;
  static const double mediumOpacity = 0.2;
  static const double highOpacity = 0.3;

  // Contact Info
  static const String supportEmail = 'support@nsc1.com';
  static const String emergencyPhone = '01 23 45 67 89';

  // Classes disponibles
  static const List<String> availableClasses = [
    'CIEL1',
    'CIEL2',
    'SIO1',
    'SIO2',
  ];

  // Validation Patterns
  static final RegExp emailPattern = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp phonePattern = RegExp(
    r'^(?:(?:\+|00)33|0)\s*[1-9](?:[\s.-]*\d{2}){4}$',
  );

  // Private constructor to prevent instantiation
  AppConstants._();
}
