import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/app_constants.dart';
import '../utils/app_theme.dart';
import '../utils/validators.dart';
import '../widgets/app_logo.dart';
import '../widgets/background_container.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/fade_in_animation.dart';
import '../widgets/glass_button.dart';
import '../widgets/glass_container.dart';
import '../widgets/glass_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();
  final _motifController = TextEditingController();
  final ApiService _api = ApiService.defaultInstance();
  bool _loading = false;
  String _selectedClasse = AppConstants.availableClasses.first;

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Split full name into prenom/nom
    final fullName = _nameController.text.trim();
    final parts = fullName.split(RegExp(r'\s+'));
    final prenom = parts.isNotEmpty ? parts.first : '';
    final nom = parts.length > 1 ? parts.sublist(1).join(' ') : '';

    setState(() => _loading = true);

    try {
      await _api.submitRegistrationStudent(
        prenom: prenom,
        nom: nom,
        email: _emailController.text.trim(),
        telephone: _phoneController.text.trim(),
        organisation: _companyController.text.trim(),
        motifDemande: _motifController.text.trim(),
        classe: _selectedClasse,
      );

      if (!mounted) return;

      CustomSnackbar.show(
        context,
        message:
            'Demande envoyée avec succès! Vous recevrez une réponse sous 48h.',
        type: SnackbarType.success,
        duration: const Duration(seconds: 4),
      );

      // Clear form and navigate back
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
        message: 'Erreur lors de l\'envoi de la demande. Veuillez réessayer.',
        type: SnackbarType.error,
      );
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
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

                const SizedBox(height: 40),

                // Main registration container
                FadeInAnimation(
                  delay: const Duration(milliseconds: 200),
                  child: GlassContainer(
                    padding: const EdgeInsets.all(
                      AppConstants.extraLargeSpacing,
                    ),
                    child: Column(
                      children: [
                        // Logo
                        const AppLogo(
                          height: 70,
                        ),

                        const SizedBox(height: AppConstants.largeSpacing),

                        // Title
                        Text(
                          'Demande de Badge d\'Accès',
                          style: AppTheme.headingStyle(isDark),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: AppConstants.smallSpacing),

                        Text(
                          'Remplissez ce formulaire pour obtenir vos identifiants et accès au bâtiment',
                          style: AppTheme.captionStyle(isDark),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: AppConstants.extraLargeSpacing),

                        // Form
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              GlassTextField(
                                controller: _nameController,
                                hintText: 'Nom complet',
                                icon: Icons.person,
                                validator: Validators.fullName,
                              ),

                              const SizedBox(
                                height: AppConstants.mediumSpacing,
                              ),

                              GlassTextField(
                                controller: _emailController,
                                hintText: 'Email',
                                icon: Icons.email,
                                keyboardType: TextInputType.emailAddress,
                                validator: Validators.email,
                              ),

                              const SizedBox(
                                height: AppConstants.mediumSpacing,
                              ),

                              GlassTextField(
                                controller: _phoneController,
                                hintText: 'Téléphone',
                                icon: Icons.phone,
                                keyboardType: TextInputType.phone,
                                validator: Validators.phone,
                              ),

                              const SizedBox(
                                height: AppConstants.mediumSpacing,
                              ),

                              GlassTextField(
                                controller: _companyController,
                                hintText: 'Organisation',
                                icon: Icons.business,
                                validator: (value) => Validators.required(
                                  value,
                                  fieldName: 'votre organisation',
                                ),
                              ),

                              const SizedBox(
                                height: AppConstants.mediumSpacing,
                              ),

                              GlassTextField(
                                controller: _motifController,
                                hintText: 'Motif de la demande',
                                icon: Icons.description,
                                maxLines: 3,
                                validator: (value) => Validators.required(
                                  value,
                                  fieldName: 'le motif de votre demande',
                                ),
                              ),

                              const SizedBox(
                                height: AppConstants.mediumSpacing,
                              ),

                              _buildClasseDropdown(isDark),

                              const SizedBox(height: AppConstants.largeSpacing),

                              // Submit button
                              GlassButton(
                                onPressed: _handleSubmit,
                                icon: Icons.send,
                                text: 'Envoyer la demande',
                                color: AppTheme.primaryGreen,
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

                // Important information section
                FadeInAnimation(
                  delay: const Duration(milliseconds: 400),
                  child: GlassContainer(
                    padding: const EdgeInsets.all(AppConstants.largeSpacing),
                    color: AppTheme.primaryBlue.withValues(
                      alpha: AppConstants.mediumOpacity,
                    ),
                    borderColor: AppTheme.primaryBlue.withValues(alpha: 0.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            const SizedBox(width: AppConstants.smallSpacing),
                            Text(
                              'Informations importantes',
                              style: AppTheme.bodyStyle(
                                isDark,
                              ).copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppConstants.mediumSpacing),
                        _buildInfoItem('Traitement sous 48h ouvrées', isDark),
                        _buildInfoItem(
                          'Badge personnel et non transmissible',
                          isDark,
                        ),
                        _buildInfoItem(
                          'Accès limité aux zones autorisées',
                          isDark,
                        ),
                        _buildInfoItem(
                          'Respect du règlement intérieur obligatoire',
                          isDark,
                        ),
                        _buildInfoItem(
                          'Restitution du badge en fin de mission',
                          isDark,
                        ),
                        const SizedBox(height: AppConstants.mediumSpacing),
                        Text(
                          'Support: ${AppConstants.supportEmail}\nUrgences: ${AppConstants.emergencyPhone}',
                          style: AppTheme.captionStyle(
                            isDark,
                          ).copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String text, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: AppTheme.bodyStyle(isDark)),
          Expanded(child: Text(text, style: AppTheme.bodyStyle(isDark))),
        ],
      ),
    );
  }

  Widget _buildClasseDropdown(bool isDark) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.mediumSpacing,
      ),
      child: DropdownButtonFormField<String>(
        initialValue: _selectedClasse,
        decoration: InputDecoration(
          labelText: 'Classe',
          labelStyle: AppTheme.hintStyle(isDark),
          prefixIcon: Icon(
            Icons.school,
            color: isDark
                ? Colors.white70
                : Colors.black.withValues(alpha: 0.7),
          ),
          border: InputBorder.none,
        ),
        dropdownColor: isDark ? Colors.grey[850] : Colors.white,
        style: AppTheme.bodyStyle(isDark),
        items: AppConstants.availableClasses
            .map(
              (classe) => DropdownMenuItem(value: classe, child: Text(classe)),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() => _selectedClasse = value);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    _motifController.dispose();
    super.dispose();
  }
}
