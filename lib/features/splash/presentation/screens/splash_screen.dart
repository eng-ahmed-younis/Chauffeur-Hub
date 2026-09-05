import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/navigation/app_routes.dart';
import '../bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void _onStateChanged(BuildContext context, SplashState state) {
    if (state.effect == SplashEffect.navigate && state.destination != null) {
      switch (state.destination!) {
        case SplashDestination.login:
          context.go(AppRoutes.login);
        case SplashDestination.home:
          context.go(AppRoutes.home);
        case SplashDestination.currentTrip:
          context.go(AppRoutes.currentTrip);
      }
    } else if (state.effect == SplashEffect.showError &&
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0B132B),
              Color(0xFF131952),
              Color(0xFF1C2541),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: BlocConsumer<SplashBloc, SplashState>(
              listenWhen: (previous, current) =>
                  previous.effectId != current.effectId,
              listener: _onStateChanged,
              builder: (context, state) {
                return Column(
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
                          color:
                              const Color(0xFFD4AF37).withValues(alpha: 0.3),
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
                      'Chauffeur Hub',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 48.h),

                    // Loader
                    if (state.isLoading)
                      SizedBox(
                        width: 28.w,
                        height: 28.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFFD4AF37),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
