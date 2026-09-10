import 'package:chauffeur_hub/core/services/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/system/app_system_bar.dart';
import 'package:chauffeur_hub/core/widgets/core_Text_field.dart';
import 'package:chauffeur_hub/core/widgets/base_action_button.dart';
import '../../../../../core/utils/extentions/theme_context_extention.dart';
import 'package:chauffeur_hub/features/auth/presentation/widgets/login_welcome_text.dart';
import 'package:chauffeur_hub/features/auth/presentation/widgets/forget_password_text.dart';

import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onStateChanged(BuildContext context, LoginState state) {
    // Handle Navigation Effects
    if (state.effect == LoginEffect.openHome) {
      context.go(AppRoutes.home);
    } else if (state.effect == LoginEffect.openForgotPassword) {
      context.push(AppRoutes.forgotPassword);
    }

    // Handle Errors
    if (state.status == LoginStatus.failure && state.errorMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemBarStyle.dark,
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          listenWhen: (previous, current) => previous.effectId != current.effectId || previous.status != current.status,
          listener: _onStateChanged,
          builder: (context, state) {
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(color: colors.grey900Text),
                  child: SafeArea(
                    child: CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const Spacer(),
                                SvgPicture.asset(
                                  'assets/images/shift_logo.svg',
                                  height: 30.h,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Container(
                                  decoration: BoxDecoration(
                                    color: colors.lightWhite,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const LoginWelcomeText(),
                                      const SizedBox(height: 16),
                                      CoreTextField(
                                        controller: _emailController,
                                        hint: 'Email',
                                        height: 50.h,
                                        keyboardType: TextInputType.emailAddress,
                                        errorText: state.isEmailError 
                                            ? (state.emailErrorMessage ?? 'Please enter a valid email') 
                                            : null,
                                        onChanged: (value) {
                                          context.read<LoginBloc>().add(LoginEmailChanged(email: value));
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      CoreTextField(
                                        controller: _passwordController,
                                        hint: 'Password',
                                        height: 50.h,
                                        keyboardType: TextInputType.visiblePassword,
                                        obscureText: true,
                                        errorText: state.isPasswordError 
                                            ? (state.passwordErrorMessage ?? 'Please enter a valid password') 
                                            : null,
                                        onChanged: (value) {
                                          context.read<LoginBloc>().add(LoginPasswordChanged(password: value));
                                        },
                                      ),
                                      const SizedBox(height: 24),
                                      ForgetPasswordText(
                                        onPressed: () {
                                          context.read<LoginBloc>().add(const OnForgotPasswordPressed());
                                        },
                                      ),
                                      const SizedBox(height: 24),
                                      BaseActionButton(
                                        onPressed: () {
                                          context.read<LoginBloc>().add(
                                            LoginSubmitted(
                                              email: _emailController.text,
                                              password: _passwordController.text,
                                            ),
                                          );
                                        },
                                        isLoading: false, // Loading is handled by full-screen overlay
                                        text: 'Log in',
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Full Screen Loading Overlay
                if (state.status == LoginStatus.loading)
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
        ),
      ),
    );
  }
}
