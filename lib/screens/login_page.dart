import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/app_constants.dart';
import '../utils/app_theme.dart';
import '../utils/validators.dart';
import '../widgets/background_container.dart';
import '../widgets/fade_in_animation.dart';
import '../widgets/glass_button.dart';
import '../widgets/glass_container.dart';
import '../widgets/glass_text_field.dart';
import '../widgets/custom_snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiService _api = ApiService.defaultInstance();
  bool _loading = false;

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _loading = true);

    try {
      await _api.login(
        username: _usernameController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      CustomSnackbar.show(
        context,
        message: 'Connexion réussie! Porte déverrouillée.',
        type: SnackbarType.success,
      );

      // Navigate back or to dashboard
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pop(context);
        }
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      CustomSnackbar.show(
        context,
        message: e.message,
        type: SnackbarType.error,
      );
    } catch (e) {
      if (!mounted) return;
      CustomSnackbar.show(
        context,
        message: 'Erreur de connexion. Veuillez réessayer.',
        type: SnackbarType.error,
      );
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  void _handleEmergencyAccess() {
    CustomSnackbar.show(
      context,
      message: 'Demande d\'accès d\'urgence envoyée à l\'agent de sécurité',
      type: SnackbarType.warning,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: BackgroundContainer(
        child: SafeArea(
          child: SingleChildScrollView(
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

                const SizedBox(height: 60),

                // Main login container
                FadeInAnimation(
                  delay: const Duration(milliseconds: 200),
                  child: GlassContainer(
                    padding: const EdgeInsets.all(AppConstants.extraLargeSpacing),
                    child: Column(
                      children: [
                        // Door icon
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(AppConstants.mediumOpacity),
                            borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
                          ),
                          child: Icon(
                            Icons.door_front_door,
                            color: isDark ? Colors.white : Colors.black,
                            size: 30,
                          ),
                        ),

                        const SizedBox(height: AppConstants.largeSpacing),

                        // Title
                        Text(
                          'Connectez-vous avec vos\nidentifiants',
                          style: AppTheme.subheadingStyle(isDark),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: AppConstants.smallSpacing),

                        Text(
                          'Déverrouiller la porte',
                          style: AppTheme.captionStyle(isDark),
                        ),

                        const SizedBox(height: AppConstants.extraLargeSpacing),

                        // Login form
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              GlassTextField(
                                controller: _usernameController,
                                hintText: 'Votre identifiant...',
                                icon: Icons.person,
                                validator: Validators.username,
                              ),

                              const SizedBox(height: AppConstants.mediumSpacing),

                              GlassTextField(
                                controller: _passwordController,
                                hintText: 'Votre mot de passe...',
                                icon: Icons.lock,
                                obscureText: true,
                                validator: Validators.password,
                              ),

                              const SizedBox(height: AppConstants.largeSpacing),

                              // Login button
                              GlassButton(
                                onPressed: _handleLogin,
                                icon: Icons.lock_open,
                                text: 'Ouvrir',
                                color: AppTheme.primaryBlue,
                                isLoading: _loading,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppConstants.largeSpacing),

                // Emergency access button
                FadeInAnimation(
                  delay: const Duration(milliseconds: 400),
                  child: GlassContainer(
                    padding: const EdgeInsets.all(AppConstants.mediumSpacing),
                    color: AppTheme.primaryRed.withOpacity(AppConstants.mediumOpacity),
                    borderColor: AppTheme.primaryRed.withOpacity(0.4),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _handleEmergencyAccess,
                        borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
                        child: Column(
                          children: [
                            Text(
                              'Accès d\'urgence - Appel à un agent',
                              style: AppTheme.bodyStyle(isDark).copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppConstants.smallSpacing),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: AppConstants.mediumSpacing,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryRed.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(AppConstants.smallRadius),
                              ),
                              child: Text(
                                'Demande d\'accès',
                                style: AppTheme.buttonTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppConstants.largeSpacing),

                // Contact info
                FadeInAnimation(
                  delay: const Duration(milliseconds: 600),
                  child: GlassContainer(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.largeSpacing,
                      vertical: AppConstants.mediumSpacing,
                    ),
                    child: Text(
                      'Support: ${AppConstants.supportEmail}\nUrgences: ${AppConstants.emergencyPhone}',
                      style: AppTheme.captionStyle(isDark),
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

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
