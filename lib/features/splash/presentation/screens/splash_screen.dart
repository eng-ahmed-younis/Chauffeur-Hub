import '../bloc/splash_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/navigation/app_routes.dart';
import 'package:chauffeur_hub/core/theme/system/app_system_bar.dart';
import 'package:chauffeur_hub/core/utils/extentions/theme_context_extention.dart';




class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemBarStyle.dark,
      child: const _SplashContent(),
    );
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent();

  void _onStateChanged(BuildContext context, SplashState state) {
    if (state.effect == SplashEffect.navigate && state.destination != null) {
      switch (state.destination!) {
        case SplashDestination.login:
          context.go(AppRoutes.login);
          return;

        case SplashDestination.home:
          context.go(AppRoutes.home);
          return;

        case SplashDestination.currentTrip:
          context.go(AppRoutes.currentTrip);
          return;
      }
    }

    if (state.effect == SplashEffect.showError &&
        state.errorMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.errorMessage),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {
              context.read<SplashBloc>().add(const SplashErrorDismissed());
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listenWhen: (previous, current) =>
            previous.effectId != current.effectId,
        listener: _onStateChanged,
        child: Container(
          decoration: BoxDecoration(color: colors.grey900Text),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Container
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.05),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFD4AF37)
                              .withValues(alpha: 0.15),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                      border: Border.all(
                        color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/app_icon.png',
                        width: 90.w,
                        height: 90.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // App Name
                  Text(
                    'Shift Driver',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),

                  SizedBox(height: 48.h),

                  // Only this section rebuilds when isLoading changes
                  BlocBuilder<SplashBloc, SplashState>(
                    buildWhen: (previous, current) =>
                        previous.isLoading != current.isLoading,
                    builder: (context, state) {
                      if (!state.isLoading) {
                        return const SizedBox.shrink();
                      }

                      return SizedBox(
                        width: 28.w,
                        height: 28.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 155, 131, 50),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
