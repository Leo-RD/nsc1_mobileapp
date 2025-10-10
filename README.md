# NSC1 Secure Door - Mobile App

Application mobile Flutter pour le système de contrôle d'accès sécurisé NSC1.

## 📱 Description

Application de gestion d'accès permettant aux utilisateurs de :
- Se connecter pour déverrouiller les portes
- Demander un badge d'accès
- Gérer leurs paramètres
- Accéder à un système d'urgence

## ✨ Fonctionnalités

- 🔐 **Authentification sécurisée** avec JWT
- 📝 **Inscription en ligne** avec validation complète
- 🎨 **Interface moderne** avec glass morphism
- 🌓 **Mode sombre/clair** 
- ✅ **Validation en temps réel** des formulaires
- 🎭 **Animations fluides** et micro-interactions
- ♿ **Accessible** avec support lecteurs d'écran
- 📱 **Responsive** pour tous les écrans

## 🏗️ Architecture

```
lib/
├── main.dart                    # Point d'entrée
├── screens/                     # Pages de l'application
│   ├── home_page.dart
│   ├── login_page.dart
│   ├── register_page.dart
│   └── settings_page.dart
├── widgets/                     # Composants réutilisables
│   ├── app_logo.dart
│   ├── background_container.dart
│   ├── fade_in_animation.dart
│   ├── glass_button.dart
│   ├── glass_container.dart
│   ├── glass_text_field.dart
│   ├── loading_overlay.dart
│   └── custom_snackbar.dart
├── utils/                       # Utilitaires
│   ├── app_constants.dart
│   ├── app_theme.dart
│   └── validators.dart
├── services/
│   └── api_service.dart
└── examples/
    └── widget_examples.dart
```

## 🚀 Installation

### Prérequis

- Flutter SDK 3.9.2 ou supérieur
- Dart SDK 3.0+
- Android Studio / VS Code
- Un émulateur ou appareil physique

### Étapes

1. **Cloner le projet**
```bash
git clone <repository-url>
cd nsc1_mobileapp
```

2. **Installer les dépendances**
```bash
flutter pub get
```

3. **Lancer l'application**
```bash
flutter run
```

## 📦 Dépendances

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  http: ^1.5.0
  google_fonts: ^6.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

## 🎨 Design System

### Couleurs
- **Primary Blue**: #2196F3
- **Primary Green**: #4CAF50
- **Primary Red**: #E53935
- **Warning Orange**: #FF9800

### Espacements
- **Small**: 8px
- **Medium**: 16px
- **Large**: 24px
- **Extra Large**: 32px

### Typographie
- **Police**: Titillium Web (Google Fonts)
- **Styles**: Title, Heading, Subheading, Body, Caption

## 🔧 Configuration

### API Backend

Modifiez l'URL de l'API dans `lib/services/api_service.dart`:

```dart
static ApiService defaultInstance({
  String baseUrl = 'https://votre-api.com',
}) {
  // ...
}
```

⚠️ **Important**: Ne commitez jamais vos credentials. Utilisez des variables d'environnement.

## 📚 Documentation

- **[IMPROVEMENTS.md](IMPROVEMENTS.md)** - Documentation complète des améliorations UI/UX
- **[MIGRATION_GUIDE.md](MIGRATION_GUIDE.md)** - Guide de migration de l'ancienne structure
- **[lib/examples/widget_examples.dart](lib/examples/widget_examples.dart)** - Exemples d'utilisation des widgets

## 💡 Utilisation des widgets

### Bouton
```dart
GlassButton(
  onPressed: () => doSomething(),
  icon: Icons.check,
  text: 'Valider',
  color: AppTheme.primaryGreen,
  isLoading: false,
)
```

### Champ de texte
```dart
GlassTextField(
  controller: _emailController,
  hintText: 'Email',
  icon: Icons.email,
  validator: Validators.email,
)
```

### Notification
```dart
CustomSnackbar.show(
  context,
  message: 'Opération réussie!',
  type: SnackbarType.success,
)
```

## 🧪 Tests

```bash
# Lancer les tests
flutter test

# Analyser le code
flutter analyze

# Formater le code
flutter format lib/
```

## 📱 Plateformes supportées

- ✅ Android
- ✅ iOS
- ✅ Windows
- ✅ macOS
- ✅ Linux
- ✅ Web

## 🤝 Contribution

1. Fork le projet
2. Créer une branche (`git checkout -b feature/AmazingFeature`)
3. Commit les changements (`git commit -m 'Add AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

## 📝 Changelog

### Version 1.0.0 (2025-10-10)
- ✨ Refonte complète de l'architecture
- 🎨 Nouveau design system avec glass morphism
- ✅ Validation en temps réel des formulaires
- 🌓 Support mode sombre/clair
- ♿ Amélioration de l'accessibilité
- 📚 Documentation complète

## 🔐 Sécurité

- Authentification JWT
- Validation côté client et serveur
- HTTPS requis pour la production
- Pas de credentials en dur (à implémenter)

## 📄 Licence

Ce projet est sous licence privée. Tous droits réservés.

## 👥 Auteurs

- **Équipe NSC1** - Développement initial

## 🙏 Remerciements

- Flutter team pour le framework
- Google Fonts pour Titillium Web
- Communauté Flutter pour les packages

## 📞 Support

- **Email**: support@nsc1.com
- **Urgences**: 01 23 45 67 89

---

**Version**: 1.0.0  
**Dernière mise à jour**: 2025-10-10
