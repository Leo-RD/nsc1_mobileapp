# 🚀 Quick Start - NSC1 Mobile App

## Installation rapide

```bash
# 1. Installer les dépendances
flutter pub get

# 2. Lancer l'application
flutter run
```

## 📁 Structure du projet

```
lib/
├── main.dart                    # Point d'entrée (75 lignes)
├── screens/                     # 4 pages
├── widgets/                     # 7 composants réutilisables
├── utils/                       # 3 fichiers utilitaires
├── services/                    # API service
└── examples/                    # Exemples de code
```

## 🎨 Widgets disponibles

### 1. AppLogo
Logo de l'application avec options de personnalisation.

```dart
AppLogo(
  height: 100,
  withGlow: true,  // Ajoute un effet de lueur
)
```

### 2. GlassButton
Bouton avec effet glass, animations et état de chargement.

```dart
GlassButton(
  onPressed: () => print('Clicked'),
  icon: Icons.check,
  text: 'Valider',
  color: AppTheme.primaryGreen,
  isLoading: false,
)
```

### 3. GlassTextField
Champ de texte avec validation en temps réel.

```dart
GlassTextField(
  controller: _controller,
  hintText: 'Email',
  icon: Icons.email,
  validator: Validators.email,
)
```

### 3. CustomSnackbar
Notifications élégantes avec 4 types.

```dart
CustomSnackbar.show(
  context,
  message: 'Succès!',
  type: SnackbarType.success,
)
```

### 4. FadeInAnimation
Animation de fondu avec délai.

```dart
FadeInAnimation(
  delay: Duration(milliseconds: 300),
  child: YourWidget(),
)
```

### 5. GlassContainer
Container avec effet glass morphism.

```dart
GlassContainer(
  padding: EdgeInsets.all(16),
  child: YourContent(),
)
```

### 6. BackgroundContainer
Background avec image selon le thème.

```dart
BackgroundContainer(
  child: YourPage(),
)
```

### 7. LoadingOverlay
Overlay de chargement avec blur.

```dart
LoadingOverlay(
  isLoading: _loading,
  message: 'Chargement...',
  child: YourContent(),
)
```

## 🎯 Validateurs

```dart
Validators.email(value)        // Validation email
Validators.phone(value)        // Téléphone français
Validators.password(value)     // Min 6 caractères
Validators.fullName(value)     // Prénom + nom
Validators.username(value)     // Min 3 caractères
Validators.required(value)     // Champ obligatoire
```

## 🎨 Thème

```dart
// Styles de texte
AppTheme.titleStyle(isDark)
AppTheme.headingStyle(isDark)
AppTheme.bodyStyle(isDark)
AppTheme.captionStyle(isDark)

// Couleurs
AppTheme.primaryBlue
AppTheme.primaryGreen
AppTheme.primaryRed
AppTheme.warningOrange

// Décorations
AppTheme.glassDecoration(isDark)
AppTheme.buttonGradient(color)
AppTheme.buttonShadow(color)
```

## 📏 Constantes

```dart
// Espacements
AppConstants.smallSpacing      // 8px
AppConstants.mediumSpacing     // 16px
AppConstants.largeSpacing      // 24px
AppConstants.extraLargeSpacing // 32px

// Rayons
AppConstants.smallRadius       // 8px
AppConstants.mediumRadius      // 12px
AppConstants.largeRadius       // 16px

// Animations
AppConstants.shortAnimationDuration   // 200ms
AppConstants.mediumAnimationDuration  // 400ms
AppConstants.longAnimationDuration    // 1000ms

// Blur
AppConstants.lightBlur         // 10.0
AppConstants.mediumBlur        // 15.0
AppConstants.heavyBlur         // 20.0
```

## 🔧 Configuration API

Modifiez `lib/services/api_service.dart`:

```dart
static ApiService defaultInstance({
  String baseUrl = 'https://votre-api.com',
}) {
  return ApiService(
    baseUrl: baseUrl,
    basicAuthUser: 'YOUR_USER',
    basicAuthPass: 'YOUR_PASS',
  );
}
```

## 📱 Pages disponibles

- **HomePage** - Page d'accueil avec 2 boutons
- **LoginPage** - Connexion avec validation
- **RegisterPage** - Inscription complète
- **SettingsPage** - Paramètres et thème

## 🎭 Navigation

```dart
Navigator.pushNamed(context, '/login')
Navigator.pushNamed(context, '/register')
Navigator.pushNamed(context, '/settings')
```

## 🧪 Commandes utiles

```bash
# Analyser le code
flutter analyze

# Formater le code
flutter format lib/

# Lancer les tests
flutter test

# Build pour production
flutter build apk          # Android
flutter build ios          # iOS
flutter build web          # Web
```

## 📚 Documentation complète

- **README.md** - Documentation principale
- **IMPROVEMENTS.md** - Détails des améliorations
- **MIGRATION_GUIDE.md** - Guide de migration
- **lib/examples/widget_examples.dart** - Exemples de code

## 🎓 Exemple complet

```dart
import 'package:flutter/material.dart';
import 'utils/app_theme.dart';
import 'utils/app_constants.dart';
import 'utils/validators.dart';
import 'widgets/background_container.dart';
import 'widgets/glass_button.dart';
import 'widgets/glass_text_field.dart';
import 'widgets/custom_snackbar.dart';

class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final _emailController = TextEditingController();
  bool _loading = false;

  void _handleSubmit() {
    setState(() => _loading = true);
    
    // Votre logique ici
    
    CustomSnackbar.show(
      context,
      message: 'Envoyé!',
      type: SnackbarType.success,
    );
    
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: BackgroundContainer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppConstants.largeSpacing),
            child: Column(
              children: [
                Text('Titre', style: AppTheme.titleStyle(isDark)),
                SizedBox(height: AppConstants.largeSpacing),
                GlassTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  icon: Icons.email,
                  validator: Validators.email,
                ),
                SizedBox(height: AppConstants.largeSpacing),
                GlassButton(
                  onPressed: _handleSubmit,
                  icon: Icons.send,
                  text: 'Envoyer',
                  color: AppTheme.primaryBlue,
                  isLoading: _loading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

## ✅ Checklist avant production

- [ ] Configurer l'URL de l'API
- [ ] Sécuriser les credentials (variables d'environnement)
- [ ] Tester sur plusieurs appareils
- [ ] Vérifier l'accessibilité
- [ ] Optimiser les images
- [ ] Activer HTTPS
- [ ] Configurer les icônes d'application
- [ ] Tester le mode hors ligne
- [ ] Vérifier les permissions
- [ ] Préparer les stores (Google Play, App Store)

## 🆘 Problèmes courants

**Import non trouvé**
```dart
import 'package:nsc1_mobileapp/utils/app_theme.dart';
```

**Widget non défini**
```bash
flutter clean
flutter pub get
```

**Erreur de build**
```bash
flutter clean
flutter pub get
flutter run
```

---

**Besoin d'aide ?** Consultez la documentation complète dans les fichiers MD à la racine du projet.
