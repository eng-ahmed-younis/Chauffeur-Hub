import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chauffeur_hub/core/utils/extentions/theme_context_extention.dart';

class BaseActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final ShapeBorder shape;

  // Because BaseActionButton has a const constructor (const BaseActionButton({ ... })),
  // any default values assigned in optional parameters must be compile-time constants.
  const BaseActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.width,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        onPressed: isLoading ? null : onPressed,
        color: backgroundColor ?? colors.primaryBlue100,
        height: height ?? 50,
        minWidth: width ?? double.infinity,
        shape: shape,
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
