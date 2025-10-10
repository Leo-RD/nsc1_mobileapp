import 'app_constants.dart';

/// Form validation utilities
class Validators {
  /// Validates email format
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir votre email';
    }
    if (!AppConstants.emailPattern.hasMatch(value)) {
      return 'Veuillez saisir un email valide';
    }
    return null;
  }

  /// Validates phone number (French format)
  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir votre numéro de téléphone';
    }
    if (!AppConstants.phonePattern.hasMatch(value)) {
      return 'Veuillez saisir un numéro de téléphone valide';
    }
    return null;
  }

  /// Validates required field
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return 'Veuillez saisir ${fieldName ?? 'ce champ'}';
    }
    return null;
  }

  /// Validates minimum length
  static String? minLength(String? value, int minLength, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir ${fieldName ?? 'ce champ'}';
    }
    if (value.length < minLength) {
      return '${fieldName ?? 'Ce champ'} doit contenir au moins $minLength caractères';
    }
    return null;
  }

  /// Validates password strength
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir votre mot de passe';
    }
    if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères';
    }
    return null;
  }

  /// Validates full name (at least first and last name)
  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Veuillez saisir votre nom complet';
    }
    final parts = value.trim().split(RegExp(r'\s+'));
    if (parts.length < 2) {
      return 'Veuillez saisir votre prénom et nom';
    }
    return null;
  }

  /// Validates username
  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez saisir votre identifiant';
    }
    if (value.length < 3) {
      return 'L\'identifiant doit contenir au moins 3 caractères';
    }
    return null;
  }

  /// Combines multiple validators
  static String? Function(String?) combine(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) {
          return result;
        }
      }
      return null;
    };
  }

  // Private constructor
  Validators._();
}
