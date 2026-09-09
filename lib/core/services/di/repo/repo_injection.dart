import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../network/dio_factory.dart';
import '../../network/base/device_metadata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../features/splash/data/api/splash_api.dart';
import 'package:chauffeur_hub/features/auth/data/api/auth_api.dart';
import '../../../../features/splash/domain/repo/splash_repository.dart';
import '../../../../features/splash/data/repo/splash_repository_impl.dart';
import 'package:chauffeur_hub/features/auth/domain/repo/auth_repository.dart';
import 'package:chauffeur_hub/features/auth/data/repo/auth_repository_impl.dart';


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




  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      AuthApi(
        dio: serviceLocator<Dio>(instanceName: ApiTarget.chauffeur.name),
      ),
    ),
  );
}
