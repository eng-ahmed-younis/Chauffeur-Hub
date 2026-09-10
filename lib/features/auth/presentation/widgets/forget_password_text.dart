import 'package:flutter/material.dart';

import '../../../../core/utils/extentions/theme_context_extention.dart';

class ForgetPasswordText extends StatelessWidget {


  final VoidCallback onPressed;
  const ForgetPasswordText({super.key, required this.onPressed});



  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: onPressed,
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: context.appColors.grey900Text,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
