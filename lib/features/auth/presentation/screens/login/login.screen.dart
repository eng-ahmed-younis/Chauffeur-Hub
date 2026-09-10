import 'package:chauffeur_hub/core/services/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/system/app_system_bar.dart';
import '../../../../../../core/storage/session_controller.dart';
import 'package:chauffeur_hub/core/widgets/core_Text_field.dart';
import '../../../../../../core/services/di/service_locator.dart';
import 'package:chauffeur_hub/core/widgets/base_action_button.dart';
import '../../../../../core/utils/extentions/theme_context_extention.dart';
import 'package:chauffeur_hub/features/auth/presentation/widgets/login_welcome_text.dart';
import 'package:chauffeur_hub/features/auth/presentation/widgets/forget_password_text.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);

    // Simulate network request
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    // Establish session (stores dummy token and auto-redirects via GoRouter)
    final sessionController = serviceLocator<SessionController>();
    await sessionController.establish(
      token: 'dummy_bearer_token_12345',
      accountCode: 'ACC-001',
      driverName: 'Elite Chauffeur',
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemBarStyle.dark,
      child: Scaffold(
        body: Stack(
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
                                  // other design here

                                  const LoginWelcomeText(),
                                  const SizedBox(height: 16),
                                  CoreTextField(
                                    controller: _emailController,
                                    hint: 'Email',
                                    height: 50.h,
                                    keyboardType: TextInputType.emailAddress,
                                  ),

                                  const SizedBox(height: 16),

                                  CoreTextField(
                                    controller: _passwordController,
                                    hint: 'Password',
                                    height: 50.h,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                  ),

                                  const SizedBox(height: 24),
                                  ForgetPasswordText(
                                    onPressed: () {
                                      // Handle forget password action
                                      context.push(AppRoutes.forgotPassword);
                                    },
                                  ),
                                  const SizedBox(height: 24),
                                  BaseActionButton(
                                    onPressed: _handleLogin,
                                    isLoading: false,
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
            if (_isLoading)
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
        ),
      ),
    );
  }
}
