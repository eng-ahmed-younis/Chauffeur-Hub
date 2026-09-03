import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/services/di/service_locator.dart';
import '../../../../core/storage/session_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.65, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.65, curve: Curves.easeOutBack),
      ),
    );

    _controller.forward();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final sessionController = serviceLocator<SessionController>();
    
    // Run restore and minimum splash duration concurrently for a smooth luxury experience
    await Future.wait([
      sessionController.restore(),
      Future.delayed(const Duration(milliseconds: 2000)),
    ]);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Container with Luxury Glow
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.05),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
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
                      'Chauffeur Hub',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Subtitle
                    Text(
                      'ELITE CHAUFFEUR SERVICE',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFD4AF37),
                        letterSpacing: 3.0,
                      ),
                    ),
                    SizedBox(height: 48.h),

                    // Elegant Loader
                    SizedBox(
                      width: 28.w,
                      height: 28.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFD4AF37)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
