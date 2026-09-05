import 'package:get_it/get_it.dart';

import '../../../../features/splash/domain/repo/splash_repository.dart';
import '../../../../features/splash/domain/use_case/check_app_update_use_case.dart';
import '../../../../features/splash/domain/use_case/get_driver_status_use_case.dart';
import '../../../../features/splash/domain/use_case/get_settings_use_case.dart';

void initUseCaseModule(GetIt serviceLocator) {
  serviceLocator
    ..registerLazySingleton<CheckAppUpdateUseCase>(
      () => CheckAppUpdateUseCase(serviceLocator<SplashRepository>()),
    )
    ..registerLazySingleton<GetDriverStatusUseCase>(
      () => GetDriverStatusUseCase(serviceLocator<SplashRepository>()),
    )
    ..registerLazySingleton<GetSettingsUseCase>(
      () => GetSettingsUseCase(serviceLocator<SplashRepository>()),
    );
}
