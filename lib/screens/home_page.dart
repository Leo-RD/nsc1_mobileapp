import 'package:flutter/material.dart';
import '../utils/app_constants.dart';
import '../utils/app_theme.dart';
import '../widgets/app_logo.dart';
import '../widgets/background_container.dart';
import '../widgets/fade_in_animation.dart';
import '../widgets/glass_button.dart';
import '../widgets/glass_container.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: BackgroundContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.largeSpacing),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: AppConstants.mediumSpacing),

                // Settings button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GlassContainer(
                      borderRadius: AppConstants.mediumRadius,
                      child: IconButton(
                        icon: const Icon(Icons.settings, color: Colors.white),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/settings'),
                        tooltip: 'Paramètres',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppConstants.largeSpacing),

                // Logo
                FadeInAnimation(
                  delay: const Duration(milliseconds: 100),
                  child: GlassContainer(
                    padding: const EdgeInsets.all(AppConstants.largeSpacing),
                    child: const AppLogo(
                      height: 120,
                      withGlow: true,
                    ),
                  ),
                ),

                const SizedBox(height: AppConstants.largeSpacing),

                // Animated title
                FadeInAnimation(
                  delay: const Duration(milliseconds: 200),
                  child: GlassContainer(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.largeSpacing,
                      vertical: AppConstants.mediumSpacing,
                    ),
                    child: Text(
                      AppConstants.appName,
                      style: AppTheme.titleStyle(isDark),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                const SizedBox(height: AppConstants.extraLargeSpacing),

                // Forgot badge button
                FadeInAnimation(
                  delay: const Duration(milliseconds: 300),
                  child: GlassButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    icon: Icons.key,
                    text: "J'ai oublié mon badge",
                    color: AppTheme.primaryBlue,
                  ),
                ),

                const SizedBox(height: AppConstants.largeSpacing),

                // Register button
                FadeInAnimation(
                  delay: const Duration(milliseconds: 500),
                  child: GlassButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    icon: Icons.edit,
                    text: "Je veux m'inscrire",
                    color: AppTheme.primaryGreen,
                  ),
                ),

                const Spacer(),

                // Contact info
                FadeInAnimation(
                  delay: const Duration(milliseconds: 700),
                  child: GlassContainer(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.largeSpacing,
                      vertical: AppConstants.mediumSpacing,
                    ),
                    child: Text(
                      'Bienvenue sur le système de sécurité NSC1',
                      style: AppTheme.bodyStyle(isDark),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
