import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../features/splash/data/api/splash_api.dart';
import '../../../../features/splash/data/repo/splash_repository_impl.dart';
import '../../../../features/splash/domain/repo/splash_repository.dart';
import '../../network/base/device_metadata.dart';
import '../../network/dio_factory.dart';

void initRepositoryModule(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(
      SplashApi(
        serviceLocator<Dio>(instanceName: ApiTarget.settings.name),
        serviceLocator<Dio>(instanceName: ApiTarget.chauffeur.name),
        serviceLocator<DeviceMetadata>(),
      ),
      serviceLocator<SharedPreferences>(),
    ),
  );
}
