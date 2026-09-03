import 'package:chauffeur_hub/core/services/navigation/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../storage/session_controller.dart';

void initNavigationModule(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<GoRouter>(
    () => createAppRouter(serviceLocator<SessionController>()),
    dispose: (router) => router.dispose(),
  );
}
