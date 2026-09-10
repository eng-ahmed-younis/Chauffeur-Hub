import 'package:flutter/material.dart';

import '../../../../core/utils/extentions/theme_context_extention.dart';

class LoginWelcomeText extends StatelessWidget {
  const LoginWelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Welcome to SHIFT!',
          style: TextStyle(
            color: colors.lightBlack,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          'Let’s log you in to start driving',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'SF Pro',
            color: colors.grey900Text,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
