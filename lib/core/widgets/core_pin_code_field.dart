import 'package:chauffeur_hub/core/utils/extentions/theme_context_extention.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CorePinCodeField extends StatelessWidget {
  final int length;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final bool isObscured;
  final String? errorText;

  const CorePinCodeField({
    super.key,
    this.length = 6,
    this.controller,
    this.onChanged,
    this.onCompleted,
    this.isObscured = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final hasError = errorText != null && errorText!.isNotEmpty;

    final borderColor = hasError ? colors.systemRedBright : colors.primaryBlue100;
    final textStyleColor = hasError ? colors.systemRedBright : colors.grey900Text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PinCodeTextField(
          appContext: context,
          length: length,
          controller: controller,
          obscureText: isObscured,
          obscuringCharacter: '•',
          animationType: AnimationType.fade,
          keyboardType: TextInputType.number,
          backgroundColor: Colors.transparent,
          cursorColor: colors.grey900Text, // #242E42 cursor color
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textStyleColor,
          ),
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(12),
            fieldHeight: 52,
            fieldWidth: 46,
            activeFillColor: colors.grey100,
            inactiveFillColor: colors.grey100,
            selectedFillColor: colors.grey100,
            activeColor: borderColor,
            inactiveColor: hasError ? colors.systemRedBright : Colors.transparent,
            selectedColor: borderColor,
            borderWidth: 1.5,
          ),
          animationDuration: const Duration(milliseconds: 200),
          enableActiveFill: true,
          onChanged: onChanged ?? (_) {},
          onCompleted: onCompleted,
        ),
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
                  errorText!,
                  style: TextStyle(
                    color: colors.systemRedBright,
                    fontSize: 13,
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
