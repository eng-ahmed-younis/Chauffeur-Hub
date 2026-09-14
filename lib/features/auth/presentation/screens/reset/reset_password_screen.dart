import 'dart:async';

import 'package:chauffeur_hub/core/services/navigation/app_routes.dart';
import 'package:chauffeur_hub/core/utils/extentions/theme_context_extention.dart';
import 'package:chauffeur_hub/core/utils/ui_effect.dart';
import 'package:chauffeur_hub/core/widgets/base_action_button.dart';
import 'package:chauffeur_hub/core/widgets/core_error_bottom_sheet.dart';
import 'package:chauffeur_hub/core/widgets/core_text_field.dart';
import 'package:chauffeur_hub/features/auth/presentation/screens/reset/bloc/reset_password_bloc.dart';
import 'package:chauffeur_hub/features/auth/presentation/screens/reset/bloc/reset_password_event.dart';
import 'package:chauffeur_hub/features/auth/presentation/screens/reset/bloc/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otpCode,
    required this.verificationId,
  });

  final String? email;
  final String? otpCode;
  final int? verificationId;

  @override
  Widget build(BuildContext context) {
    return _ResetPasswordContent(
      email: email,
      otpCode: otpCode,
      verificationId: verificationId,
    );
  }
}

class _ResetPasswordContent extends StatefulWidget {
  const _ResetPasswordContent({
    required this.email,
    required this.otpCode,
    required this.verificationId,
  });

  final String? email;
  final String? otpCode;
  final int? verificationId;

  @override
  State<StatefulWidget> createState() {
    return _ResetPasswordContentState();
  }
}

class _ResetPasswordContentState extends State<_ResetPasswordContent> {
  late final TextEditingController _createPasswordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    _createPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _createPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onStateChanged(BuildContext context, ResetPasswordState state) {
    if (state.effect == UiEffect.navigate) {
      switch (state.destination) {
        case ResetDestination.login:
          context.go(AppRoutes.login);
          break;
        case null:
          break;
      }
    }

    if (state.effect == UiEffect.showError && state.errorMessage.isNotEmpty) {
      unawaited(CoreErrorBottomSheet.show<void>(
        context,
        title: 'Reset Password Failed',
        message: state.errorMessage,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listenWhen: (previous, current) =>
          previous.effectId != current.effectId || previous.status != current.status,
      listener: _onStateChanged,
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(AppRoutes.otpPath);
                    }
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                title: const Text('Reset password'),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create new password',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: colors.grey900Text,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Create new password to get access to your account',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: colors.grey800,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: colors.grey900Text,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CoreTextField(
                        controller: _createPasswordController,
                        hint: 'Create password',
                        height: 48,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Confirm password',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: colors.grey900Text,
                        ),
                      ),
                      const SizedBox(height: 8),
                      CoreTextField(
                        controller: _confirmPasswordController,
                        hint: 'Confirm password',
                        height: 48,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                      const Spacer(),
                      BaseActionButton(
                        text: 'Reset password',
                        isLoading: false,
                        onPressed: () {
                          context.read<ResetPasswordBloc>().add(
                                ResetPasswordSubmitted(
                                  email: widget.email ?? '',
                                  otpCode: widget.otpCode ?? '',
                                  verificationId: widget.verificationId ?? 0,
                                  password: _createPasswordController.text,
                                  confirmPassword: _confirmPasswordController.text,
                                ),
                              );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Full Screen Loading Overlay (Covers Scaffold + AppBar seamlessly)
            if (state.status == ResetPasswordStatus.loading)
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withValues(alpha: 0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
