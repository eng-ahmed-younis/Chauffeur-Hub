import 'package:chauffeur_hub/features/splash/presentation/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../../storage/session_controller.dart';
import 'app_routes.dart';

GoRouter createAppRouter(SessionController session) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: session,
    //state (GoRouterState): An object provided by GoRouter containing information about the current navigation event.
    redirect: (context, state) {
      final path = state.uri.path;

      // 1. If session isn't loaded yet, force the user to stay on or go to /splash
      if (!session.isReady) {
        return path == AppRoutes.splash ? null : AppRoutes.splash;
      }

      // 2. If authenticated and trying to access auth pages, redirect to /home
      if (session.isAuthenticated && AppRoutes.isAuthPath(path)) {
        return AppRoutes.home;
      }

      // 3. If unauthenticated and trying to access protected pages, redirect to /login
      if (!session.isAuthenticated && AppRoutes.isProtectedPath(path)) {
        return AppRoutes.login;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      )
    ],
  );
}
