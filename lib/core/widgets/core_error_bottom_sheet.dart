import 'package:chauffeur_hub/core/utils/extentions/theme_context_extention.dart';
import 'package:chauffeur_hub/core/widgets/base_action_button.dart';
import 'package:flutter/material.dart';

/// A luxury custom bottom sheet for displaying error alerts with icon, title, message, and action button.
class CoreErrorBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onPressed;
  final IconData icon;

  const CoreErrorBottomSheet({
    super.key,
    this.title = 'Something Went Wrong',
    required this.message,
    this.buttonText = 'OK',
    this.onPressed,
    this.icon = Icons.error_outline_rounded,
  });

  /// Static helper to display the error bottom sheet easily from any BuildContext.
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
    IconData? icon,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CoreErrorBottomSheet(
        title: title ?? 'Something Went Wrong',
        message: message,
        buttonText: buttonText ?? 'OK',
        onPressed: onPressed,
        icon: icon ?? Icons.error_outline_rounded,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      decoration: BoxDecoration(
        color: colors.lightWhite,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top handle indicator bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colors.grey400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),

            // Red Error Icon inside a soft tinted circle
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: colors.systemRedPastel,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: colors.systemRedBright,
                size: 36,
              ),
            ),
            const SizedBox(height: 16),

            // Error Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colors.grey900Text,
              ),
            ),
            const SizedBox(height: 8),

            // Error Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.4,
                fontWeight: FontWeight.w400,
                color: colors.grey800,
              ),
            ),
            const SizedBox(height: 28),

            // Action Button
            BaseActionButton(
              text: buttonText,
              backgroundColor: colors.systemRedBright,
              onPressed: () {
                Navigator.of(context).pop();
                if (onPressed != null) {
                  onPressed!();
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
