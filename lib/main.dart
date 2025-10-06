import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/services.dart';
import 'services/api_service.dart';

extension ColorCompat on Color {
  Color withValues({double? alpha, int? red, int? green, int? blue}) {
    if (alpha != null) {
      return withValues(alpha: alpha);
    }
    return this;
  }
}

void main() {
  runApp(const NSC1App());
}

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
      title: 'NSC1 Secure Door',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        fontFamily: 'Instrument Sans',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Instrument Sans',
        colorScheme: const ColorScheme.dark().copyWith(primary: Colors.blue),
      ),
      themeMode: _themeMode,
      home: const HomePage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/settings': (context) => SettingsPage(
          themeMode: _themeMode,
          onThemeModeChanged: _setThemeMode,
        ),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isDark
                  ? 'assets/images/misty-starry-night-sky-background.jpg'
                  : 'assets/images/skybox.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Place le titre plus haut
                const SizedBox(height: 16),

                // Settings button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: IconButton(
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                            onPressed: () =>
                                Navigator.pushNamed(context, '/settings'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Animated title with container
                FadeInAnimation(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.5),
                        width: 2.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withValues(alpha: 0.5),
                          blurRadius: 15,
                          spreadRadius: 1,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Text(
                      'NSC1 SECURE DOOR',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2.0,
                        fontFamily: 'Instrument Sans',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Forgot badge button
                _buildGlassButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  icon: Icons.key,
                  text: "J'ai oublié mon badge",
                  color: Colors.blue,
                ),

                const SizedBox(height: 20),

                // Register button
                _buildGlassButton(
                  onPressed: () => Navigator.pushNamed(context, '/register'),
                  icon: Icons.edit,
                  text: "Je veux m'inscrire",
                  color: Colors.green,
                ),

                const Spacer(),

                // Contact info
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'Bienvenue sur le système de sécurité NSC1',
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black,
                      fontFamily: 'Instrument Sans',
                    ),
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

  Widget _buildGlassButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.95),
            color.withValues(alpha: 0.75),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.45),
            blurRadius: 14,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(16),
              splashColor: Colors.white.withValues(alpha: 0.2),
              highlightColor: Colors.white.withValues(alpha: 0.1),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 24, color: Colors.white),
                    const SizedBox(width: 12),
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Instrument Sans',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Fade in animation for the title
class FadeInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const FadeInAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  @override
  _FadeInAnimationState createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    _offset = Tween<double>(
      begin: 20.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _offset.value),
          child: Opacity(opacity: _opacity.value, child: widget.child),
        );
      },
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isDark
                  ? 'assets/images/misty-starry-night-sky-background.jpg'
                  : 'assets/images/skybox.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Back button
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // Main login container
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Column(
                        children: [
                          // Door icon
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.door_front_door,
                              color: isDark ? Colors.white : Colors.black,
                              size: 30,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Title
                          Text(
                            'Connectez-vous avec vos\nidentifiants',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Instrument Sans',
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Déverrouiller la porte',
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white70 : Colors.black54,
                              fontFamily: 'Instrument Sans',
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Login form
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                _buildGlassTextField(
                                  controller: _usernameController,
                                  hintText: 'Votre identifiant...',
                                  icon: Icons.person,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez saisir votre identifiant';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 16),

                                _buildGlassTextField(
                                  controller: _passwordController,
                                  hintText: 'Votre mot de passe...',
                                  icon: Icons.lock,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez saisir votre mot de passe';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 24),

                                // Login button
                                Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.8),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: _loading
                                          ? null
                                          : () async {
                                              if (!_formKey.currentState!
                                                  .validate()) {
                                                return;
                                              }
                                              setState(() => _loading = true);
                                              try {
                                                final _ = await _api.login(
                                                  username: _usernameController
                                                      .text
                                                      .trim(),
                                                  password:
                                                      _passwordController.text,
                                                );
                                                if (!mounted) return;
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text('Connecté'),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                              } on ApiException catch (e) {
                                                if (!mounted) return;
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(e.message),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              } catch (_) {
                                                if (!mounted) return;
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Erreur de connexion',
                                                    ),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              } finally {
                                                if (mounted)
                                                  setState(
                                                    () => _loading = false,
                                                  );
                                              }
                                            },
                                      borderRadius: BorderRadius.circular(12),
                                      child: Center(
                                        child: Text(
                                          _loading ? 'Connexion...' : 'Ouvrir',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'Instrument Sans',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Emergency access button
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.red.withValues(alpha: 0.4),
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Demande d\'accès d\'urgence envoyée',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            children: [
                              Text(
                                'Accès d\'urgence - Appel à un agent',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: isDark ? Colors.white : Colors.black,
                                  fontFamily: 'Instrument Sans',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red.withValues(alpha: 0.8),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Demande d\'accès',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Instrument Sans',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Contact info
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    'Contactez-nous :',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white : Colors.black,
                      fontFamily: 'Instrument Sans',
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

  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Builder(
            builder: (context) {
              final isDark = Theme.of(context).brightness == Brightness.dark;
              return TextFormField(
                controller: controller,
                obscureText: obscureText,
                validator: validator,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontFamily: 'Instrument Sans',
                ),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: isDark
                        ? Colors.white70
                        : Colors.black.withValues(alpha: 0.7),
                    fontFamily: 'Instrument Sans',
                  ),
                  prefixIcon: Icon(
                    icon,
                    color: isDark
                        ? Colors.white70
                        : Colors.black.withValues(alpha: 0.7),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              );
            },
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
  String _selectedClasse = 'CIEL1';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isDark
                  ? 'assets/images/misty-starry-night-sky-background.jpg'
                  : 'assets/images/skybox.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // Back button
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Main registration container
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: .2),
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Column(
                        children: [
                          // Title
                          Text(
                            'Demande de Badge d\'Accès',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
                              fontFamily: 'Instrument Sans',
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Remplissez ce formulaire pour obtenir vos identifiants et accès au bâtiment',
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white70 : Colors.black54,
                              fontFamily: 'Instrument Sans',
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 32),

                          // Form
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                _buildGlassTextField(
                                  controller: _nameController,
                                  hintText: 'Nom complet',
                                  icon: Icons.person,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez saisir votre nom complet';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 16),

                                _buildGlassTextField(
                                  controller: _emailController,
                                  hintText: 'Email',
                                  icon: Icons.email,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez saisir votre email';
                                    }
                                    if (!value.contains('@')) {
                                      return 'Veuillez saisir un email valide';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 16),

                                _buildGlassTextField(
                                  controller: _phoneController,
                                  hintText: 'Téléphone',
                                  icon: Icons.phone,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez saisir votre numéro de téléphone';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 16),

                                _buildGlassTextField(
                                  controller: _companyController,
                                  hintText: 'Organisation',
                                  icon: Icons.business,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez saisir votre organisation';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 16),

                                _buildGlassTextField(
                                  controller: _motifController,
                                  hintText: 'Motif de la demande',
                                  icon: Icons.description,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez saisir le motif de votre demande';
                                    }
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 16),

                                _buildClasseDropdown(isDark),

                                const SizedBox(height: 24),

                                // Submit button
                                Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.green.withValues(alpha: 0.8),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: _loading
                                          ? null
                                          : () async {
                                              if (!_formKey.currentState!
                                                  .validate())
                                                return;

                                              // Split full name into prenom/nom (best-effort)
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
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Demande envoyée avec succès!',
                                                    ),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                              } on ApiException catch (e) {
                                                if (!mounted) return;
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(e.message),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              } catch (_) {
                                                if (!mounted) return;
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Erreur lors de l\'envoi de la demande',
                                                    ),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              } finally {
                                                if (mounted)
                                                  setState(
                                                    () => _loading = false,
                                                  );
                                              }
                                            },
                                      borderRadius: BorderRadius.circular(12),
                                      child: Center(
                                        child: Text(
                                          _loading
                                              ? 'Envoi...'
                                              : 'Envoyer la demande',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'Instrument Sans',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Important information section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.blue.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Informations importantes',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: isDark ? Colors.white : Colors.black,
                                  fontFamily: 'Instrument Sans',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '• Traitement sous 48h ouvrées',
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontFamily: 'Instrument Sans',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '• Badge personnel et non transmissible',
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontFamily: 'Instrument Sans',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '• Accès limité aux zones autorisées',
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontFamily: 'Instrument Sans',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '• Respect du règlement intérieur obligatoire',
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontFamily: 'Instrument Sans',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '• Restitution du badge en fin de mission',
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontFamily: 'Instrument Sans',
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Support technique : support@nsc1.com | Urgences : 01 23 45 67 89',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white70 : Colors.black54,
                              fontFamily: 'Instrument Sans',
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Builder(
            builder: (context) {
              final isDark = Theme.of(context).brightness == Brightness.dark;
              return TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                validator: validator,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontFamily: 'Instrument Sans',
                ),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: isDark
                        ? Colors.white70
                        : Colors.black.withValues(alpha: 0.7),
                    fontFamily: 'Instrument Sans',
                  ),
                  prefixIcon: Icon(
                    icon,
                    color: isDark
                        ? Colors.white70
                        : Colors.black.withValues(alpha: 0.7),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildClasseDropdown(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField<String>(
              value: _selectedClasse,
              decoration: InputDecoration(
                labelText: 'Classe',
                labelStyle: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black.withValues(alpha: 0.7),
                  fontFamily: 'Instrument Sans',
                ),
                prefixIcon: Icon(
                  Icons.school,
                  color: isDark ? Colors.white70 : Colors.black.withValues(alpha: 0.7),
                ),
                border: InputBorder.none,
              ),
              dropdownColor: isDark ? Colors.grey[850] : Colors.white,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
                fontFamily: 'Instrument Sans',
              ),
              items: ['CIEL1', 'CIEL2', 'SIO1', 'SIO2']
                  .map((classe) => DropdownMenuItem(
                        value: classe,
                        child: Text(classe),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedClasse = value);
                }
              },
            ),
          ),
        ),
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

class SettingsPage extends StatelessWidget {
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;

  const SettingsPage({
    super.key,
    required this.themeMode,
    required this.onThemeModeChanged,
  });

  void _quitApp(BuildContext context) {
    if (Platform.isAndroid || Platform.isIOS) {
      SystemNavigator.pop();
    } else {
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = themeMode == ThemeMode.dark;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isDark
                  ? 'assets/images/misty-starry-night-sky-background.jpg'
                  : 'assets/images/skybox.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.brightness_6,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Mode sombre',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Instrument Sans',
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                              Switch(
                                value: isDark,
                                onChanged: (value) => onThemeModeChanged(
                                  value ? ThemeMode.dark : ThemeMode.light,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.red.withValues(alpha: 0.95),
                                  Colors.red.withValues(alpha: 0.75),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withValues(alpha: 0.45),
                                  blurRadius: 14,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.5),
                                width: 1.5,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => _quitApp(context),
                                borderRadius: BorderRadius.circular(16),
                                child: const Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.power_settings_new,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        "Quitter l'app",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontFamily: 'Instrument Sans',
                                        ),
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
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
