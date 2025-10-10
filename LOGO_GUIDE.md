# 🎨 Guide d'utilisation du logo NSC1

## 📍 Emplacement du logo

Le logo est situé dans : `assets/images/logonsc1.png`

## 🧩 Widget AppLogo

Le widget `AppLogo` est un composant réutilisable qui facilite l'affichage du logo dans toute l'application.

### Fichier
```
lib/widgets/app_logo.dart
```

### Propriétés

| Propriété | Type | Défaut | Description |
|-----------|------|--------|-------------|
| `height` | `double?` | `null` | Hauteur du logo |
| `width` | `double?` | `null` | Largeur du logo |
| `fit` | `BoxFit` | `BoxFit.contain` | Mode d'ajustement de l'image |
| `withGlow` | `bool` | `false` | Ajoute un effet de lueur blanche |

## 💡 Exemples d'utilisation

### 1. Logo simple
```dart
AppLogo(
  height: 100,
)
```

### 2. Logo avec effet de lueur
```dart
AppLogo(
  height: 120,
  withGlow: true,  // Ajoute un halo lumineux
)
```

### 3. Logo avec largeur fixe
```dart
AppLogo(
  width: 200,
  fit: BoxFit.cover,
)
```

### 4. Logo dans un container
```dart
GlassContainer(
  padding: const EdgeInsets.all(20),
  child: const AppLogo(
    height: 80,
  ),
)
```

## 📱 Utilisation dans les pages

### Page d'accueil (HomePage)
```dart
FadeInAnimation(
  delay: const Duration(milliseconds: 100),
  child: GlassContainer(
    padding: const EdgeInsets.all(AppConstants.largeSpacing),
    child: const AppLogo(
      height: 120,
      withGlow: true,  // Effet de lueur pour attirer l'attention
    ),
  ),
),
```

**Taille recommandée** : 120px  
**Effet** : Avec lueur pour mise en valeur

### Page de connexion (LoginPage)
```dart
const AppLogo(
  height: 80,
),
```

**Taille recommandée** : 80px  
**Effet** : Sans lueur pour rester sobre

### Page d'inscription (RegisterPage)
```dart
const AppLogo(
  height: 70,
),
```

**Taille recommandée** : 70px  
**Effet** : Sans lueur pour ne pas distraire du formulaire

## 🎨 Recommandations de design

### Tailles recommandées par contexte

| Contexte | Taille | Effet de lueur | Justification |
|----------|--------|----------------|---------------|
| **Page d'accueil** | 100-120px | ✅ Oui | Élément principal, doit attirer l'attention |
| **En-têtes de formulaire** | 70-80px | ❌ Non | Présence discrète, focus sur le contenu |
| **Splash screen** | 150-200px | ✅ Oui | Grande visibilité au démarrage |
| **Barre d'app** | 40-50px | ❌ Non | Petit espace, doit rester compact |
| **Footer** | 50-60px | ❌ Non | Élément secondaire |

### Espacement

Toujours ajouter un espacement autour du logo :

```dart
// Avant le logo
const SizedBox(height: AppConstants.largeSpacing),

// Logo
const AppLogo(height: 100),

// Après le logo
const SizedBox(height: AppConstants.largeSpacing),
```

### Couleurs de fond

Le logo fonctionne bien sur :
- ✅ Backgrounds sombres (mode sombre)
- ✅ Backgrounds clairs (mode clair)
- ✅ Containers glass avec blur
- ✅ Gradients

## 🔧 Personnalisation avancée

### Ajouter une ombre personnalisée
```dart
Container(
  decoration: BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: AppTheme.primaryBlue.withValues(alpha: 0.3),
        blurRadius: 20,
        spreadRadius: 5,
      ),
    ],
  ),
  child: const AppLogo(height: 100),
)
```

### Logo cliquable
```dart
GestureDetector(
  onTap: () => Navigator.pushNamed(context, '/home'),
  child: const AppLogo(height: 80),
)
```

### Logo avec animation
```dart
FadeInAnimation(
  delay: const Duration(milliseconds: 200),
  child: const AppLogo(
    height: 100,
    withGlow: true,
  ),
)
```

## 📐 Proportions

Le logo doit toujours conserver ses proportions originales :
- Utilisez `BoxFit.contain` (par défaut)
- Évitez `BoxFit.fill` qui déforme l'image
- Préférez définir uniquement `height` ou `width`, pas les deux

## ♿ Accessibilité

Le widget `AppLogo` est automatiquement accessible :
- L'image est déclarative (pas d'action requise)
- Pas besoin de label sémantique pour un logo décoratif
- Si le logo est cliquable, ajoutez un `Semantics` :

```dart
Semantics(
  label: 'Logo NSC1, retour à l\'accueil',
  button: true,
  child: GestureDetector(
    onTap: () => Navigator.pushNamed(context, '/home'),
    child: const AppLogo(height: 80),
  ),
)
```

## 🎯 Bonnes pratiques

### ✅ À faire
- Utiliser le widget `AppLogo` au lieu de `Image.asset` directement
- Définir une taille explicite (`height` ou `width`)
- Ajouter des espacements appropriés
- Utiliser l'effet de lueur avec parcimonie (page d'accueil uniquement)
- Conserver les proportions du logo

### ❌ À éviter
- Ne pas utiliser `Image.asset(AppConstants.logoPath)` directement
- Ne pas déformer le logo avec `BoxFit.fill`
- Ne pas utiliser l'effet de lueur partout (perd son impact)
- Ne pas mettre le logo trop petit (< 40px) ou trop grand (> 200px)
- Ne pas oublier les espacements

## 📝 Checklist d'intégration

Lors de l'ajout du logo sur une nouvelle page :

- [ ] Importer le widget : `import '../widgets/app_logo.dart';`
- [ ] Définir la taille appropriée selon le contexte
- [ ] Ajouter des espacements (avant et après)
- [ ] Décider si l'effet de lueur est nécessaire
- [ ] Tester en mode clair et sombre
- [ ] Vérifier sur différentes tailles d'écran
- [ ] Tester l'accessibilité si le logo est cliquable

## 🔄 Mise à jour du logo

Pour remplacer le logo :

1. Remplacer le fichier `assets/images/logonsc1.png`
2. Garder le même nom de fichier
3. Recommandé : Format PNG avec transparence
4. Recommandé : Résolution minimale 512x512px
5. Exécuter `flutter clean` puis `flutter pub get`

Aucune modification de code n'est nécessaire !

## 📚 Ressources

- **Fichier du widget** : `lib/widgets/app_logo.dart`
- **Constante du chemin** : `AppConstants.logoPath`
- **Exemples** : `lib/examples/widget_examples.dart`
- **Documentation** : `QUICK_START.md`

---

**Version** : 1.0.1  
**Dernière mise à jour** : 2025-10-10
