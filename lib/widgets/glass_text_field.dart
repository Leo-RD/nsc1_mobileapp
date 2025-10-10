import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/app_constants.dart';
import '../utils/app_theme.dart';

/// Glass morphism text field with real-time validation
class GlassTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLines;
  final int? maxLength;

  const GlassTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.maxLength,
  });

  @override
  State<GlassTextField> createState() => _GlassTextFieldState();
}

class _GlassTextFieldState extends State<GlassTextField> {
  bool _obscureText = false;
  String? _errorText;
  bool _hasInteracted = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    if (_hasInteracted && widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(widget.controller.text);
      });
    }
    widget.onChanged?.call(widget.controller.text);
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Semantics(
      textField: true,
      label: widget.hintText,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppTheme.glassBackground(isDark),
              borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
              border: Border.all(
                color: _errorText != null
                    ? AppTheme.primaryRed.withValues(alpha: 0.5)
                    : AppTheme.glassBorder(isDark),
                width: _errorText != null ? 2 : 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: AppConstants.lightBlur,
                  sigmaY: AppConstants.lightBlur,
                ),
                child: TextFormField(
                  controller: widget.controller,
                  obscureText: _obscureText,
                  keyboardType: widget.keyboardType,
                  maxLines: widget.obscureText ? 1 : widget.maxLines,
                  maxLength: widget.maxLength,
                  style: AppTheme.bodyStyle(isDark),
                  onChanged: (value) {
                    if (!_hasInteracted) {
                      setState(() {
                        _hasInteracted = true;
                      });
                    }
                  },
                  validator: widget.validator,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: AppTheme.hintStyle(isDark),
                    prefixIcon: Icon(
                      widget.icon,
                      color: isDark
                          ? Colors.white70
                          : Colors.black.withValues(alpha: 0.7),
                    ),
                    suffixIcon: widget.obscureText
                        ? IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: isDark
                                  ? Colors.white70
                                  : Colors.black.withValues(alpha: 0.7),
                            ),
                            onPressed: _toggleObscureText,
                          )
                        : _errorText == null && _hasInteracted
                            ? Icon(
                                Icons.check_circle,
                                color: AppTheme.primaryGreen,
                              )
                            : null,
                    border: InputBorder.none,
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.mediumSpacing,
                      vertical: AppConstants.mediumSpacing,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (_errorText != null && _hasInteracted)
            Padding(
              padding: const EdgeInsets.only(
                left: AppConstants.mediumSpacing,
                top: AppConstants.smallSpacing,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 16,
                    color: AppTheme.primaryRed,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      _errorText!,
                      style: TextStyle(
                        color: AppTheme.primaryRed,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
