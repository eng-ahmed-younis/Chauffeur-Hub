import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/auth/presentation/screens/login/login.screen.dart';
import '../../../features/splash/presentation/bloc/splash_bloc.dart';
import '../../../features/splash/presentation/screens/splash_screen.dart';
import '../../storage/session_controller.dart';
import '../di/service_locator.dart';
import 'app_routes.dart';

abstract final class AppPages {
  static List<RouteBase> routes(SessionController session) => [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => BlocProvider<SplashBloc>(
        create: (context) => serviceLocator<SplashBloc>()
          // In Flutter BLoC, .add() is the method used to send an Event into the BLoC.
          ..add(const SplashStarted()),
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => session.signOut(),
            ),
          ],
        ),
        body: const Center(child: Text('Welcome to Chauffeur Hub Home')),
      ),
    ),
  ];
}
