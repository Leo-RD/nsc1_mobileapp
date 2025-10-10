# 📂 Structure du projet NSC1 Mobile App

## 🌳 Arborescence complète

```
nsc1_mobileapp/
│
├── 📱 lib/                                  # Code source principal
│   │
│   ├── 🏠 main.dart                         # Point d'entrée (75 lignes)
│   │
│   ├── 📄 screens/                          # Pages de l'application
│   │   ├── home_page.dart                   # Page d'accueil
│   │   ├── login_page.dart                  # Page de connexion
│   │   ├── register_page.dart               # Page d'inscription
│   │   └── settings_page.dart               # Page des paramètres
│   │
│   ├── 🧩 widgets/                          # Composants réutilisables
│   │   ├── background_container.dart        # Background thématique
│   │   ├── custom_snackbar.dart             # Notifications élégantes
│   │   ├── fade_in_animation.dart           # Animation de fondu
│   │   ├── glass_button.dart                # Bouton glass morphism
│   │   ├── glass_container.dart             # Container glass
│   │   ├── glass_text_field.dart            # Champ de texte validé
│   │   └── loading_overlay.dart             # Overlay de chargement
│   │
│   ├── 🛠️ utils/                            # Utilitaires
│   │   ├── app_constants.dart               # Constantes de l'app
│   │   ├── app_theme.dart                   # Système de thème
│   │   └── validators.dart                  # Validateurs de formulaire
│   │
│   ├── 🌐 services/                         # Services API
│   │   └── api_service.dart                 # Client API REST
│   │
│   └── 📚 examples/                         # Exemples de code
│       └── widget_examples.dart             # Démo des widgets
│
├── 📖 Documentation/
│   ├── README.md                            # Documentation principale
│   ├── IMPROVEMENTS.md                      # Détails des améliorations
│   ├── MIGRATION_GUIDE.md                   # Guide de migration
│   ├── QUICK_START.md                       # Démarrage rapide
│   ├── SUMMARY.md                           # Résumé exécutif
│   ├── CHANGELOG.md                         # Historique des versions
│   └── PROJECT_STRUCTURE.md                 # Ce fichier
│
├── 🎨 assets/
│   └── images/                              # Images de l'app
│       ├── skybox.jpg                       # Background mode clair
│       └── misty-starry-night-sky-background.jpg  # Background mode sombre
│
├── 🔤 fonts/                                # Polices personnalisées
│   └── InstrumentSans_Condensed-*.ttf      # Police Instrument Sans
│
├── ⚙️ Configuration/
│   ├── pubspec.yaml                         # Dépendances Flutter
│   ├── analysis_options.yaml               # Règles de lint
│   └── .gitignore                          # Fichiers ignorés par Git
│
├── 🤖 android/                              # Configuration Android
├── 🍎 ios/                                  # Configuration iOS
├── 🪟 windows/                              # Configuration Windows
├── 🍏 macos/                                # Configuration macOS
├── 🐧 linux/                                # Configuration Linux
└── 🌐 web/                                  # Configuration Web
```

## 📊 Statistiques par dossier

### lib/ (Code source)
```
Total: 16 fichiers Dart
├── Screens: 4 fichiers (33,400 bytes)
├── Widgets: 7 fichiers (22,019 bytes)
├── Utils: 3 fichiers (9,342 bytes)
├── Services: 1 fichier (7,500 bytes)
├── Examples: 1 fichier (8,500 bytes)
└── Main: 1 fichier (2,342 bytes)

Total lignes de code: ~3,000 lignes
```

### Documentation
```
Total: 7 fichiers Markdown
├── README.md: 237 lignes
├── IMPROVEMENTS.md: 300+ lignes
├── MIGRATION_GUIDE.md: 400+ lignes
├── QUICK_START.md: 200+ lignes
├── SUMMARY.md: 250+ lignes
├── CHANGELOG.md: 200+ lignes
└── PROJECT_STRUCTURE.md: Ce fichier

Total documentation: ~1,800 lignes
```

## 🎯 Organisation par fonctionnalité

### 🔐 Authentification
```
screens/login_page.dart
widgets/glass_text_field.dart
utils/validators.dart
services/api_service.dart
```

### 📝 Inscription
```
screens/register_page.dart
widgets/glass_text_field.dart
widgets/glass_button.dart
utils/validators.dart
services/api_service.dart
```

### ⚙️ Paramètres
```
screens/settings_page.dart
widgets/glass_container.dart
utils/app_theme.dart
```

### 🏠 Navigation
```
main.dart
screens/home_page.dart
widgets/background_container.dart
widgets/fade_in_animation.dart
```

### 🎨 Design System
```
utils/app_theme.dart
utils/app_constants.dart
widgets/glass_container.dart
widgets/glass_button.dart
```

## 📦 Dépendances par fichier

### main.dart
```dart
import 'package:flutter/material.dart';
import 'utils/app_theme.dart';
import 'utils/app_constants.dart';
import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';
import 'screens/settings_page.dart';
```

### Screens
```dart
// Toutes les pages importent:
import 'package:flutter/material.dart';
import '../utils/app_constants.dart';
import '../utils/app_theme.dart';
import '../widgets/background_container.dart';
import '../widgets/fade_in_animation.dart';
import '../widgets/glass_button.dart';
import '../widgets/glass_container.dart';
import '../widgets/glass_text_field.dart';
import '../widgets/custom_snackbar.dart';
```

### Widgets
```dart
// Widgets de base importent:
import 'package:flutter/material.dart';
import '../utils/app_constants.dart';
import '../utils/app_theme.dart';
```

## 🔄 Flux de données

```
User Input
    ↓
GlassTextField (validation)
    ↓
Validators.validate()
    ↓
Form State
    ↓
GlassButton (loading)
    ↓
ApiService.call()
    ↓
CustomSnackbar (feedback)
    ↓
Navigation
```

## 🎨 Hiérarchie des widgets

```
MaterialApp (main.dart)
    ↓
├── HomePage
│   ├── BackgroundContainer
│   │   └── SafeArea
│   │       └── Column
│   │           ├── GlassContainer (settings button)
│   │           ├── FadeInAnimation (title)
│   │           ├── GlassButton (login)
│   │           └── GlassButton (register)
│   
├── LoginPage
│   ├── BackgroundContainer
│   │   └── SafeArea
│   │       └── SingleChildScrollView
│   │           └── Column
│   │               ├── GlassContainer (back button)
│   │               ├── FadeInAnimation
│   │               │   └── GlassContainer (form)
│   │               │       └── Form
│   │               │           ├── GlassTextField (username)
│   │               │           ├── GlassTextField (password)
│   │               │           └── GlassButton (submit)
│   │               └── GlassContainer (emergency)
│   
├── RegisterPage
│   └── [Structure similaire à LoginPage]
│   
└── SettingsPage
    └── [Structure similaire avec Switch et boutons]
```

## 📈 Complexité par fichier

| Fichier | Lignes | Complexité | Maintenabilité |
|---------|--------|------------|----------------|
| main.dart | 75 | ⭐ Faible | ⭐⭐⭐⭐⭐ Excellente |
| home_page.dart | 95 | ⭐ Faible | ⭐⭐⭐⭐⭐ Excellente |
| login_page.dart | 240 | ⭐⭐ Moyenne | ⭐⭐⭐⭐ Très bonne |
| register_page.dart | 300 | ⭐⭐ Moyenne | ⭐⭐⭐⭐ Très bonne |
| settings_page.dart | 195 | ⭐ Faible | ⭐⭐⭐⭐⭐ Excellente |
| glass_button.dart | 140 | ⭐⭐ Moyenne | ⭐⭐⭐⭐ Très bonne |
| glass_text_field.dart | 180 | ⭐⭐⭐ Élevée | ⭐⭐⭐ Bonne |
| glass_container.dart | 45 | ⭐ Faible | ⭐⭐⭐⭐⭐ Excellente |
| fade_in_animation.dart | 65 | ⭐⭐ Moyenne | ⭐⭐⭐⭐ Très bonne |
| background_container.dart | 25 | ⭐ Faible | ⭐⭐⭐⭐⭐ Excellente |
| loading_overlay.dart | 55 | ⭐ Faible | ⭐⭐⭐⭐⭐ Excellente |
| custom_snackbar.dart | 70 | ⭐ Faible | ⭐⭐⭐⭐⭐ Excellente |
| app_constants.dart | 60 | ⭐ Faible | ⭐⭐⭐⭐⭐ Excellente |
| app_theme.dart | 155 | ⭐⭐ Moyenne | ⭐⭐⭐⭐ Très bonne |
| validators.dart | 90 | ⭐ Faible | ⭐⭐⭐⭐⭐ Excellente |

## 🔍 Points d'entrée de l'application

### 1. Démarrage
```
main() → NSC1App → MaterialApp → HomePage
```

### 2. Navigation
```
HomePage → /login → LoginPage
HomePage → /register → RegisterPage
Any Page → /settings → SettingsPage
```

### 3. API Calls
```
LoginPage → ApiService.login()
RegisterPage → ApiService.submitRegistrationStudent()
```

## 🎯 Fichiers les plus importants

### Pour comprendre l'architecture
1. **main.dart** - Point d'entrée et navigation
2. **app_theme.dart** - Design system
3. **app_constants.dart** - Configuration

### Pour créer de nouvelles pages
1. **home_page.dart** - Template de page simple
2. **login_page.dart** - Template avec formulaire
3. **widget_examples.dart** - Exemples d'utilisation

### Pour créer de nouveaux widgets
1. **glass_button.dart** - Widget avec état et animations
2. **glass_text_field.dart** - Widget avec validation
3. **glass_container.dart** - Widget simple

## 📝 Conventions de nommage

### Fichiers
- **Pages** : `*_page.dart` (ex: `home_page.dart`)
- **Widgets** : `*.dart` (ex: `glass_button.dart`)
- **Utils** : `app_*.dart` (ex: `app_theme.dart`)
- **Services** : `*_service.dart` (ex: `api_service.dart`)

### Classes
- **Pages** : `*Page` (ex: `HomePage`)
- **Widgets** : Descriptif (ex: `GlassButton`)
- **States** : `_*State` (ex: `_HomePageState`)
- **Utils** : `App*` (ex: `AppTheme`)

### Constantes
- **Classes** : PascalCase (ex: `AppConstants`)
- **Propriétés** : camelCase (ex: `largeSpacing`)
- **Static** : camelCase (ex: `primaryBlue`)

## 🚀 Pour démarrer

1. **Lire** : `README.md` pour la vue d'ensemble
2. **Consulter** : `QUICK_START.md` pour démarrer rapidement
3. **Explorer** : `widget_examples.dart` pour voir les exemples
4. **Développer** : Créer de nouvelles pages avec les widgets existants

---

**Dernière mise à jour** : 2025-10-10  
**Version** : 1.0.0
