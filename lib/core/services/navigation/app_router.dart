import 'package:go_router/go_router.dart';

import '../../storage/session_controller.dart';
import 'app_pages.dart';
import 'app_routes.dart';

GoRouter createAppRouter(SessionController session) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: session,
    redirect: (context, state) {
      final path = state.uri.path;

      // 1. If session isn't loaded yet, force the user to stay on or go to /splash
      if (!session.isReady) {
        return path == AppRoutes.splash ? null : AppRoutes.splash;
      }

      // 2. Once session is ready, redirect away from /splash
      if (path == AppRoutes.splash) {
        return session.isAuthenticated ? AppRoutes.home : AppRoutes.login;
      }

      // 3. If authenticated and trying to access auth pages, redirect to /home
      if (session.isAuthenticated && AppRoutes.isAuthPath(path)) {
        return AppRoutes.home;
      }

      // 4. If unauthenticated and trying to access protected pages, redirect to /login
      if (!session.isAuthenticated && AppRoutes.isProtectedPath(path)) {
        return AppRoutes.login;
      }

      return null;
    },
    routes: AppPages.routes(session),
  );
}
