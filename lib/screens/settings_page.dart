import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_constants.dart';
import '../utils/app_theme.dart';
import '../widgets/background_container.dart';
import '../widgets/fade_in_animation.dart';
import '../widgets/glass_container.dart';

class SettingsPage extends StatelessWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const SettingsPage({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  void _quitApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quitter l\'application'),
        content: const Text('Êtes-vous sûr de vouloir quitter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              if (Platform.isAndroid || Platform.isIOS) {
                SystemNavigator.pop();
              } else {
                exit(0);
              }
            },
            child: const Text('Quitter'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      body: BackgroundContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.largeSpacing),
            child: Column(
              children: [
                // Back button
                Row(
                  children: [
                    GlassContainer(
                      borderRadius: AppConstants.mediumRadius,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                        tooltip: 'Retour',
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // Settings container
                FadeInAnimation(
                  delay: const Duration(milliseconds: 200),
                  child: GlassContainer(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppConstants.largeSpacing),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Title
                        Text(
                          'Paramètres',
                          style: AppTheme.headingStyle(isDark),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: AppConstants.extraLargeSpacing),

                        // Dark mode toggle
                        Semantics(
                          label: 'Mode sombre',
                          toggled: isDark,
                          child: Row(
                            children: [
                              Icon(
                                Icons.brightness_6,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                              const SizedBox(width: AppConstants.mediumSpacing),
                              Expanded(
                                child: Text(
                                  'Mode sombre',
                                  style: AppTheme.bodyStyle(isDark).copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Switch(
                                value: isDark,
                                onChanged: (value) => onThemeModeChanged(
                                  value ? ThemeMode.dark : ThemeMode.light,
                                ),
                                activeColor: AppTheme.primaryBlue,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: AppConstants.largeSpacing),

                        // App version
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            const SizedBox(width: AppConstants.mediumSpacing),
                            Expanded(
                              child: Text(
                                'Version',
                                style: AppTheme.bodyStyle(isDark).copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              AppConstants.appVersion,
                              style: AppTheme.captionStyle(isDark),
                            ),
                          ],
                        ),

                        const SizedBox(height: AppConstants.largeSpacing),

                        // Quit button
                        Container(
                          width: double.infinity,
                          height: AppConstants.buttonHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppConstants.largeRadius),
                            gradient: AppTheme.buttonGradient(AppTheme.primaryRed),
                            boxShadow: AppTheme.buttonShadow(AppTheme.primaryRed),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.5),
                              width: 1.5,
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _quitApp(context),
                              borderRadius: BorderRadius.circular(AppConstants.largeRadius),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.power_settings_new,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: AppConstants.mediumSpacing),
                                    Text(
                                      "Quitter l'app",
                                      style: AppTheme.buttonTextStyle(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                // Footer info
                FadeInAnimation(
                  delay: const Duration(milliseconds: 400),
                  child: Text(
                    '© 2025 NSC1 Secure Door\nTous droits réservés',
                    style: AppTheme.captionStyle(isDark).copyWith(fontSize: 12),
                    textAlign: TextAlign.center,
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
