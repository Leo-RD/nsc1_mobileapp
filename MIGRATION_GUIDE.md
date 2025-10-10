# Guide de Migration - NSC1 Mobile App

## 🔄 Migration de l'ancienne vers la nouvelle structure

Ce guide vous aide à comprendre les changements et à migrer votre code si nécessaire.

## 📁 Nouvelle structure des fichiers

### Avant
```
lib/
├── main.dart (1593 lignes)
└── services/
    └── api_service.dart
```

### Après
```
lib/
├── main.dart (75 lignes)
├── screens/
│   ├── home_page.dart
│   ├── login_page.dart
│   ├── register_page.dart
│   └── settings_page.dart
├── widgets/
│   ├── background_container.dart
│   ├── fade_in_animation.dart
│   ├── glass_button.dart
│   ├── glass_container.dart
│   ├── glass_text_field.dart
│   ├── loading_overlay.dart
│   └── custom_snackbar.dart
├── utils/
│   ├── app_constants.dart
│   ├── app_theme.dart
│   └── validators.dart
└── services/
    └── api_service.dart
```

## 🔧 Changements principaux

### 1. Imports

#### Avant
```dart
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'services/api_service.dart';
```

#### Après
```dart
import 'package:flutter/material.dart';
import 'utils/app_theme.dart';
import 'utils/app_constants.dart';
import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';
import 'screens/settings_page.dart';
```

### 2. Thème

#### Avant
```dart
ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  textTheme: GoogleFonts.titilliumWebTextTheme(ThemeData.light().textTheme),
  // ...
)
```

#### Après
```dart
AppTheme.lightTheme()  // ou AppTheme.darkTheme()
```

### 3. Styles de texte

#### Avant
```dart
GoogleFonts.titilliumWeb(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.white,
  letterSpacing: 2.0,
)
```

#### Après
```dart
AppTheme.titleStyle(isDark)
// Ou autres: headingStyle, subheadingStyle, bodyStyle, captionStyle
```

### 4. Constantes

#### Avant
```dart
const Duration(milliseconds: 400)
const EdgeInsets.all(24.0)
BorderRadius.circular(12)
```

#### Après
```dart
AppConstants.mediumAnimationDuration
const EdgeInsets.all(AppConstants.largeSpacing)
BorderRadius.circular(AppConstants.mediumRadius)
```

### 5. Boutons

#### Avant
```dart
Container(
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
    // ... beaucoup de code
  ),
  child: ClipRRect(
    // ... encore plus de code
  ),
)
```

#### Après
```dart
GlassButton(
  onPressed: () => doSomething(),
  icon: Icons.check,
  text: 'Valider',
  color: AppTheme.primaryGreen,
  isLoading: _loading,
)
```

### 6. Champs de texte

#### Avant
```dart
Container(
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
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        // ... beaucoup de configuration
      ),
    ),
  ),
)
```

#### Après
```dart
GlassTextField(
  controller: _emailController,
  hintText: 'Email',
  icon: Icons.email,
  keyboardType: TextInputType.emailAddress,
  validator: Validators.email,
)
```

### 7. Validation

#### Avant
```dart
validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Veuillez saisir votre email';
  }
  if (!value.contains('@')) {
    return 'Veuillez saisir un email valide';
  }
  return null;
}
```

#### Après
```dart
validator: Validators.email
// Ou: Validators.phone, Validators.password, etc.
```

### 8. Snackbars

#### Avant
```dart
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text('Connecté'),
    backgroundColor: Colors.green,
  ),
);
```

#### Après
```dart
CustomSnackbar.show(
  context,
  message: 'Connecté',
  type: SnackbarType.success,
);
```

### 9. Background

#### Avant
```dart
Container(
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
  child: child,
)
```

#### Après
```dart
BackgroundContainer(
  child: child,
)
```

### 10. Animations

#### Avant
```dart
class FadeInAnimation extends StatefulWidget {
  // ... 50+ lignes de code
}
```

#### Après
```dart
FadeInAnimation(
  delay: Duration(milliseconds: 300),
  child: YourWidget(),
)
```

## 🎯 Exemples de migration complets

### Exemple 1: Page simple

#### Avant
```dart
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isDark ? 'assets/images/dark.jpg' : 'assets/images/light.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'Titre',
                  style: GoogleFonts.titilliumWeb(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
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
```

#### Après
```dart
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: BackgroundContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.largeSpacing),
            child: Column(
              children: [
                Text(
                  'Titre',
                  style: AppTheme.titleStyle(isDark),
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

### Exemple 2: Formulaire avec validation

#### Avant
```dart
TextFormField(
  controller: _emailController,
  keyboardType: TextInputType.emailAddress,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir votre email';
    }
    if (!value.contains('@')) {
      return 'Email invalide';
    }
    return null;
  },
  decoration: InputDecoration(
    hintText: 'Email',
    prefixIcon: Icon(Icons.email),
  ),
)
```

#### Après
```dart
GlassTextField(
  controller: _emailController,
  hintText: 'Email',
  icon: Icons.email,
  keyboardType: TextInputType.emailAddress,
  validator: Validators.email,
)
```

### Exemple 3: Bouton avec chargement

#### Avant
```dart
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
      onTap: _loading ? null : _handleSubmit,
      child: Center(
        child: _loading
            ? CircularProgressIndicator(color: Colors.white)
            : Text('Envoyer', style: TextStyle(color: Colors.white)),
      ),
    ),
  ),
)
```

#### Après
```dart
GlassButton(
  onPressed: _handleSubmit,
  icon: Icons.send,
  text: 'Envoyer',
  color: AppTheme.primaryGreen,
  isLoading: _loading,
)
```

## 📝 Checklist de migration

- [ ] Remplacer les imports par les nouveaux
- [ ] Utiliser `AppTheme` pour les styles
- [ ] Remplacer les constantes en dur par `AppConstants`
- [ ] Utiliser `GlassButton` au lieu de containers personnalisés
- [ ] Utiliser `GlassTextField` pour les champs de formulaire
- [ ] Remplacer les validateurs inline par `Validators`
- [ ] Utiliser `CustomSnackbar` pour les notifications
- [ ] Utiliser `BackgroundContainer` pour les backgrounds
- [ ] Ajouter `FadeInAnimation` pour les animations d'entrée
- [ ] Utiliser `GlassContainer` pour les containers glass morphism

## 🚀 Commandes utiles

### Vérifier les erreurs
```bash
flutter analyze
```

### Formater le code
```bash
flutter format lib/
```

### Lancer l'application
```bash
flutter run
```

### Nettoyer et reconstruire
```bash
flutter clean
flutter pub get
flutter run
```

## ⚠️ Points d'attention

1. **Imports** : Assurez-vous d'importer les bons fichiers
2. **Constantes** : Utilisez `AppConstants` partout
3. **Thème** : Utilisez `AppTheme` pour la cohérence
4. **Validation** : Utilisez les validateurs prédéfinis
5. **État de chargement** : Gérez avec `isLoading` dans `GlassButton`

## 🐛 Problèmes courants

### Problème 1: Import non trouvé
```
Error: 'package:nsc1_mobileapp/utils/app_theme.dart' doesn't exist
```
**Solution** : Vérifiez que tous les fichiers sont créés et que les imports sont corrects.

### Problème 2: Constante non définie
```
Error: Undefined name 'AppConstants'
```
**Solution** : Ajoutez l'import `import 'package:nsc1_mobileapp/utils/app_constants.dart';`

### Problème 3: Widget non trouvé
```
Error: Undefined class 'GlassButton'
```
**Solution** : Ajoutez l'import `import 'package:nsc1_mobileapp/widgets/glass_button.dart';`

## 📚 Ressources

- `IMPROVEMENTS.md` - Documentation complète des améliorations
- `lib/utils/app_constants.dart` - Liste de toutes les constantes
- `lib/utils/app_theme.dart` - Styles et thèmes disponibles
- `lib/utils/validators.dart` - Tous les validateurs disponibles

## 💡 Conseils

1. **Migrez progressivement** : Commencez par une page à la fois
2. **Testez fréquemment** : Lancez l'app après chaque changement
3. **Réutilisez les widgets** : Ne réinventez pas la roue
4. **Suivez les conventions** : Utilisez les constantes et thèmes
5. **Documentez** : Ajoutez des commentaires si nécessaire

---

**Version** : 1.0.0  
**Date** : 2025-10-10
