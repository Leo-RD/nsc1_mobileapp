import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/app_constants.dart';
import '../utils/app_theme.dart';

/// Reusable glass morphism container
class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Color? color;
  final Color? borderColor;
  final double borderRadius;
  final double blurStrength;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.color,
    this.borderColor,
    this.borderRadius = AppConstants.mediumRadius,
    this.blurStrength = AppConstants.mediumBlur,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? AppTheme.glassBackground(isDark),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? AppTheme.glassBorder(isDark),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
          child: child,
        ),
      ),
    );
  }
}
