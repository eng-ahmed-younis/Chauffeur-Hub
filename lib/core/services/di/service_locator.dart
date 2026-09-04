import 'package:get_it/get_it.dart';

import '../../../features/splash/domain/repo/splash_repository.dart';
import '../../../features/splash/domain/use_case/check_app_update_use_case.dart';
import '../../../features/splash/domain/use_case/get_driver_status_use_case.dart';
import '../../../features/splash/domain/use_case/get_settings_use_case.dart';
import '../../../features/splash/presentation/bloc/splash_bloc.dart';
import '../../storage/session_controller.dart';
import 'core/core_injection.dart';
import 'navigation/navigation_injection.dart';
import 'network/network_injection.dart';
import 'repo/repo_injection.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> configureDependencies() async {
  await initCoreModule(serviceLocator);
  initNetworkModule(serviceLocator);
  initRepositoryModule(serviceLocator);
  initServiceModule(serviceLocator);
  initBlocModule(serviceLocator);
  initNavigationModule(serviceLocator);
}

void initServiceModule(GetIt serviceLocator) {
  // Register Helper & Domain Services
}

void initBlocModule(GetIt serviceLocator) {
  // Splash Use Cases
  serviceLocator.registerFactory(
    () => GetSettingsUseCase(serviceLocator<SplashRepository>()),
  );
  serviceLocator.registerFactory(
    () => CheckAppUpdateUseCase(serviceLocator<SplashRepository>()),
  );
  serviceLocator.registerFactory(
    () => GetDriverStatusUseCase(serviceLocator<SplashRepository>()),
  );

  // Splash Bloc
  serviceLocator.registerFactory(
    () => SplashBloc(
      serviceLocator<GetSettingsUseCase>(),
      serviceLocator<CheckAppUpdateUseCase>(),
      serviceLocator<GetDriverStatusUseCase>(),
      serviceLocator<SessionController>(),
    ),
  );
}
