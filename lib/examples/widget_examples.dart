import 'package:flutter/material.dart';
import '../utils/app_constants.dart';
import '../utils/app_theme.dart';
import '../utils/validators.dart';
import '../widgets/app_logo.dart';
import '../widgets/background_container.dart';
import '../widgets/fade_in_animation.dart';
import '../widgets/glass_button.dart';
import '../widgets/glass_container.dart';
import '../widgets/glass_text_field.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/loading_overlay.dart';

/// Exemples d'utilisation des widgets personnalisés
/// Ce fichier sert de référence pour les développeurs
class WidgetExamplesPage extends StatefulWidget {
  const WidgetExamplesPage({super.key});

  @override
  State<WidgetExamplesPage> createState() => _WidgetExamplesPageState();
}

class _WidgetExamplesPageState extends State<WidgetExamplesPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemples de Widgets'),
      ),
      body: LoadingOverlay(
        isLoading: _loading,
        message: 'Chargement en cours...',
        child: BackgroundContainer(
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.largeSpacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Section 0: Logo
                  _buildSection(
                    'Logo',
                    isDark,
                    [
                      const Center(
                        child: AppLogo(
                          height: 100,
                          withGlow: true,
                        ),
                      ),
                      const SizedBox(height: AppConstants.mediumSpacing),
                      const Center(
                        child: AppLogo(
                          height: 60,
                          withGlow: false,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppConstants.extraLargeSpacing),

                  // Section 1: Boutons
                  _buildSection(
                    'Boutons',
                    isDark,
                    [
                      GlassButton(
                        onPressed: () => _showSnackbar(SnackbarType.success),
                        icon: Icons.check,
                        text: 'Bouton Success',
                        color: AppTheme.primaryGreen,
                      ),
                      const SizedBox(height: AppConstants.mediumSpacing),
                      GlassButton(
                        onPressed: () => _showSnackbar(SnackbarType.error),
                        icon: Icons.error,
                        text: 'Bouton Error',
                        color: AppTheme.primaryRed,
                      ),
                      const SizedBox(height: AppConstants.mediumSpacing),
                      GlassButton(
                        onPressed: () => _toggleLoading(),
                        icon: Icons.refresh,
                        text: 'Bouton avec Loading',
                        color: AppTheme.primaryBlue,
                        isLoading: _loading,
                      ),
                    ],
                  ),

                  const SizedBox(height: AppConstants.extraLargeSpacing),

                  // Section 2: Champs de texte
                  _buildSection(
                    'Champs de texte',
                    isDark,
                    [
                      GlassTextField(
                        controller: _emailController,
                        hintText: 'Email avec validation',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.email,
                      ),
                      const SizedBox(height: AppConstants.mediumSpacing),
                      GlassTextField(
                        controller: _passwordController,
                        hintText: 'Mot de passe',
                        icon: Icons.lock,
                        obscureText: true,
                        validator: Validators.password,
                      ),
                    ],
                  ),

                  const SizedBox(height: AppConstants.extraLargeSpacing),

                  // Section 3: Containers
                  _buildSection(
                    'Containers Glass',
                    isDark,
                    [
                      GlassContainer(
                        padding: const EdgeInsets.all(AppConstants.largeSpacing),
                        child: Column(
                          children: [
                            Icon(
                              Icons.info,
                              size: 48,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            const SizedBox(height: AppConstants.mediumSpacing),
                            Text(
                              'Container avec effet glass',
                              style: AppTheme.bodyStyle(isDark),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppConstants.extraLargeSpacing),

                  // Section 4: Animations
                  _buildSection(
                    'Animations',
                    isDark,
                    [
                      FadeInAnimation(
                        delay: Duration.zero,
                        child: GlassContainer(
                          padding: const EdgeInsets.all(AppConstants.mediumSpacing),
                          child: Text(
                            'Animation immédiate',
                            style: AppTheme.bodyStyle(isDark),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppConstants.mediumSpacing),
                      FadeInAnimation(
                        delay: const Duration(milliseconds: 300),
                        child: GlassContainer(
                          padding: const EdgeInsets.all(AppConstants.mediumSpacing),
                          child: Text(
                            'Animation avec délai 300ms',
                            style: AppTheme.bodyStyle(isDark),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppConstants.extraLargeSpacing),

                  // Section 5: Snackbars
                  _buildSection(
                    'Notifications',
                    isDark,
                    [
                      Row(
                        children: [
                          Expanded(
                            child: GlassButton(
                              onPressed: () => _showSnackbar(SnackbarType.success),
                              icon: Icons.check_circle,
                              text: 'Success',
                              color: AppTheme.primaryGreen,
                              height: AppConstants.smallButtonHeight,
                            ),
                          ),
                          const SizedBox(width: AppConstants.mediumSpacing),
                          Expanded(
                            child: GlassButton(
                              onPressed: () => _showSnackbar(SnackbarType.error),
                              icon: Icons.error,
                              text: 'Error',
                              color: AppTheme.primaryRed,
                              height: AppConstants.smallButtonHeight,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppConstants.mediumSpacing),
                      Row(
                        children: [
                          Expanded(
                            child: GlassButton(
                              onPressed: () => _showSnackbar(SnackbarType.warning),
                              icon: Icons.warning,
                              text: 'Warning',
                              color: AppTheme.warningOrange,
                              height: AppConstants.smallButtonHeight,
                            ),
                          ),
                          const SizedBox(width: AppConstants.mediumSpacing),
                          Expanded(
                            child: GlassButton(
                              onPressed: () => _showSnackbar(SnackbarType.info),
                              icon: Icons.info,
                              text: 'Info',
                              color: AppTheme.primaryBlue,
                              height: AppConstants.smallButtonHeight,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: AppConstants.extraLargeSpacing),

                  // Section 6: Styles de texte
                  _buildSection(
                    'Styles de texte',
                    isDark,
                    [
                      Text('Title Style', style: AppTheme.titleStyle(isDark)),
                      const SizedBox(height: AppConstants.smallSpacing),
                      Text('Heading Style', style: AppTheme.headingStyle(isDark)),
                      const SizedBox(height: AppConstants.smallSpacing),
                      Text('Subheading Style', style: AppTheme.subheadingStyle(isDark)),
                      const SizedBox(height: AppConstants.smallSpacing),
                      Text('Body Style', style: AppTheme.bodyStyle(isDark)),
                      const SizedBox(height: AppConstants.smallSpacing),
                      Text('Caption Style', style: AppTheme.captionStyle(isDark)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, bool isDark, List<Widget> children) {
    return FadeInAnimation(
      child: GlassContainer(
        padding: const EdgeInsets.all(AppConstants.largeSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: AppTheme.headingStyle(isDark),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.largeSpacing),
            ...children,
          ],
        ),
      ),
    );
  }

  void _showSnackbar(SnackbarType type) {
    final messages = {
      SnackbarType.success: 'Opération réussie!',
      SnackbarType.error: 'Une erreur est survenue',
      SnackbarType.warning: 'Attention, vérifiez vos données',
      SnackbarType.info: 'Information importante',
    };

    CustomSnackbar.show(
      context,
      message: messages[type]!,
      type: type,
    );
  }

  void _toggleLoading() {
    setState(() => _loading = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _loading = false);
        CustomSnackbar.show(
          context,
          message: 'Chargement terminé!',
          type: SnackbarType.success,
        );
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
