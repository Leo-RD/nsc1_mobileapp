import 'package:flutter/material.dart';
import 'utils/app_theme.dart';
import 'utils/app_constants.dart';
import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';
import 'screens/settings_page.dart';

void main() {
  runApp(const NSC1App());
}

/// Main application widget
class NSC1App extends StatefulWidget {
  const NSC1App({super.key});

  @override
  State<NSC1App> createState() => _NSC1AppState();
}

class _NSC1AppState extends State<NSC1App> {
  ThemeMode _themeMode = ThemeMode.light;

  void _setThemeMode(ThemeMode mode) => setState(() => _themeMode = mode);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: _themeMode,
      home: const HomePage(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/login':
            return _createRoute(const LoginPage());
          case '/register':
            return _createRoute(const RegisterPage());
          case '/settings':
            return _createRoute(SettingsPage(
              themeMode: _themeMode,
              onThemeModeChanged: _setThemeMode,
            ));
          default:
            return null;
        }
      },
    );
  }

  /// Creates a custom page route with slide and fade transitions
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeIn),
        );
        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: offsetAnimation,
            child: child,
          ),
        );
      },
      transitionDuration: AppConstants.mediumAnimationDuration,
    );
  }
}
