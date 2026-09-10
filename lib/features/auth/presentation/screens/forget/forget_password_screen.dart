import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/widgets/base_action_button.dart';

import 'package:chauffeur_hub/core/widgets/core_Text_field.dart';

import '../../../../../core/services/navigation/app_routes.dart';
import '../../../../../core/utils/extentions/theme_context_extention.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ForgetPasswordContent();
  }
}

class _ForgetPasswordContent extends StatelessWidget {
  _ForgetPasswordContent();

  final TextEditingController controller = TextEditingController();
  final TextInputType keyboardType = TextInputType.emailAddress;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.login);
            }
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Forget Password'),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Enter email',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: colors.grey900Text,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Provide email to reset password',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: colors.grey800,
                ),
              ),

              const SizedBox(height: 16),
              CoreTextField(
                controller: controller,
                keyboardType: keyboardType,
                hint: 'Enter email',
                height: 48,
                fillColor: colors.grey100,
              ),

              const Spacer(),

              BaseActionButton(
                text: 'Send code',
                onPressed: () {
                  // Handle reset password logic
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
