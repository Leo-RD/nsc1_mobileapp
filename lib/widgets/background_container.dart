import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

/// Background container with image based on theme
class BackgroundContainer extends StatelessWidget {
  final Widget child;

  const BackgroundContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            isDark
                ? AppTheme.darkBackgroundImage
                : AppTheme.lightBackgroundImage,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
