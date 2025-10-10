import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/app_constants.dart';
import '../utils/app_theme.dart';

/// Glass morphism button with gradient and animations
class GlassButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String text;
  final Color color;
  final bool isLoading;
  final double? width;
  final double height;

  const GlassButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    required this.color,
    this.isLoading = false,
    this.width,
    this.height = AppConstants.buttonHeight,
  });

  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppConstants.shortAnimationDuration,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Semantics(
        button: true,
        enabled: !widget.isLoading,
        label: widget.text,
        child: Container(
          width: widget.width ?? double.infinity,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.largeRadius),
            gradient: AppTheme.buttonGradient(widget.color),
            boxShadow: AppTheme.buttonShadow(widget.color),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.5),
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.largeRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: AppConstants.lightBlur,
                sigmaY: AppConstants.lightBlur,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTapDown: widget.isLoading ? null : _onTapDown,
                  onTapUp: widget.isLoading ? null : _onTapUp,
                  onTapCancel: widget.isLoading ? null : _onTapCancel,
                  borderRadius: BorderRadius.circular(AppConstants.largeRadius),
                  splashColor: Colors.white.withValues(alpha: 0.2),
                  highlightColor: Colors.white.withValues(alpha: 0.1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.largeSpacing,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.isLoading)
                          const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        else
                          Icon(widget.icon, size: 24, color: Colors.white),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Text(
                            widget.text,
                            style: AppTheme.buttonTextStyle(),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
