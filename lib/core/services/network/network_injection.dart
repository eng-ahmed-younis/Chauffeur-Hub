import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../app/config/app_environment.dart';
import '../../storage/session_controller.dart';
import 'base/device_metadata.dart';
import 'dio_factory.dart';

void initNetworkModule(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<DioFactory>(
    () => DioFactory(
      serviceLocator<AppEnvironment>(),
      serviceLocator<SessionController>(),
      serviceLocator<Connectivity>(),
      serviceLocator<DeviceMetadata>(),
    ),
  );

  // Register default Chauffeur Dio instance
  serviceLocator.registerLazySingleton<Dio>(
    () => serviceLocator<DioFactory>().create(ApiTarget.chauffeur),
  );
}
