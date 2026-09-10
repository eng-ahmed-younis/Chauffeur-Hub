import 'package:chauffeur_hub/core/utils/extentions/theme_context_extention.dart';
import 'package:flutter/material.dart';

class CoreTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final Color? hintColor;
  final Color? fillColor;
  final Color? focusedBorderColor;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final double? height;
  final double? width;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String? errorText; // Added to support showing an error message
  final ValueChanged<String>? onChanged;

  const CoreTextField({
    super.key,
    this.label,
    this.hint,
    this.obscureText,
    required this.controller,
    required this.keyboardType,
    this.hintColor,
    this.fillColor,
    this.focusedBorderColor,
    this.height,
    this.width,
    this.suffixIcon,
    this.errorText, // Allow passing an error text
    this.onChanged,
  });

  @override
  State<CoreTextField> createState() => _CoreTextFieldState();
}

class _CoreTextFieldState extends State<CoreTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText ?? false;
  }

  @override
  void didUpdateWidget(covariant CoreTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.obscureText != oldWidget.obscureText && widget.obscureText != null) {
      _isObscured = widget.obscureText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final labelText = widget.label;
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    Widget? suffix;
    if (widget.suffixIcon != null) {
      suffix = widget.suffixIcon;
    } else if (widget.obscureText != null) {
      suffix = IconButton(
        icon: Icon(
          _isObscured ? Icons.visibility_off : Icons.visibility,
          color: widget.hintColor ?? colors.grey500,
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _isObscured = !_isObscured;
          });
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(labelText),
          const SizedBox(height: 8),
        ],
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: TextFormField(
            controller: widget.controller,
            obscureText: _isObscured,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            style: TextStyle(
              color: hasError ? colors.systemRedBright : colors.grey900Text,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.fillColor ?? colors.grey100,
              hintText: widget.hint,
              hintStyle: TextStyle(color: widget.hintColor ?? colors.grey800),
              suffixIcon: suffix,
              // Normal state border
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: hasError
                    ? BorderSide(color: colors.systemRedBright, width: 1.5)
                    : BorderSide.none,
              ),
              // Focused state border
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: hasError
                      ? colors.systemRedBright
                      : (widget.focusedBorderColor ?? colors.primaryBlue100),
                  width: 1.5,
                ),
              ),
              contentPadding: widget.height != null
                  ? const EdgeInsets.symmetric(horizontal: 12, vertical: 0)
                  : null,
            ),
          ),
        ),
        // Error Message Below TextField
        if (hasError) ...[
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: colors.systemRedBright,
                size: 16,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  widget.errorText!,
                  style: TextStyle(
                    color: colors.systemRedBright,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
