import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:chauffeur_hub/core/services/navigation/keys/auth_navigation_keys.dart';

import '../../../../../core/services/navigation/app_routes.dart';
import '../../../../../core/utils/extentions/theme_context_extention.dart';
import '../../../../../core/utils/ui_effect.dart';
import '../../../../../core/widgets/base_action_button.dart';
import '../../../../../core/widgets/core_error_bottom_sheet.dart';
import '../../../../../core/widgets/core_Text_field.dart';
import 'bloc/forget_bloc.dart';
import 'bloc/forget_event.dart';
import 'bloc/forget_state.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ForgetPasswordContent();
  }
}

class _ForgetPasswordContent extends StatefulWidget {
  const _ForgetPasswordContent();

  @override
  State<_ForgetPasswordContent> createState() => _ForgetPasswordContentState();
}

class _ForgetPasswordContentState extends State<_ForgetPasswordContent> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onStateChanged(BuildContext context, ForgetState state) {
    if (state.effect == UiEffect.navigate) {
      switch (state.destination) {
        case ForgetPasswordDestination.otp:
          context.pushNamed(
            AppRoutes.otpPath,
            queryParameters: {
              AuthNavKeys.email: _emailController.text.isNotEmpty
                  ? _emailController.text
                  : state.email,
              AuthNavKeys.verificationId: state.verificationId.toString(),
            },
          );
          break;
        default:
          break;
      }
    }

    if (state.effect == UiEffect.showError) {
      CoreErrorBottomSheet.show(
        context,
        title: 'Request Failed',
        message: 'Failed to send OTP code to the email address.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return BlocConsumer<ForgetBloc, ForgetState>(
      listenWhen: (previous, current) =>
          previous.effectId != current.effectId ||
          previous.status != current.status ||
          previous.isLoading != current.isLoading,
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
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        hint: 'Enter email',
                        height: 48,
                        onChanged: (value) {
                          context.read<ForgetBloc>().add(ForgetEvent.onEmailChanged(email: value));
                        },
                        fillColor: colors.grey100,
                        errorText: state.isEmailError
                            ? 'Please enter a valid email address'
                            : null,
                      ),
                      const Spacer(),
                      BaseActionButton(
                        text: 'Send code',
                        isLoading: false,
                        onPressed: () {
                          context.read<ForgetBloc>().add(
                                SendOtp(email: _emailController.text),
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
            if (state.isLoading)
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
