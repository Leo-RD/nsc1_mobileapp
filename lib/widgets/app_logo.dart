import 'package:flutter/material.dart';
import '../utils/app_constants.dart';

/// Widget réutilisable pour afficher le logo de l'application
class AppLogo extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxFit fit;
  final bool withGlow;

  const AppLogo({
    super.key,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.withGlow = false,
  });

  @override
  Widget build(BuildContext context) {
    final logo = Image.asset(
      AppConstants.logoPath,
      height: height,
      width: width,
      fit: fit,
    );

    if (withGlow) {
      return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: logo,
      );
    }

    return logo;
  }
}
