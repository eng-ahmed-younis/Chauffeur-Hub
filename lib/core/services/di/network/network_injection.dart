import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../../app/config/app_environment.dart';
import '../../../storage/session_controller.dart';
import '../../network/base/device_metadata.dart';
import '../../network/dio_factory.dart';

// DioFactory (The Builder/Factory): It is NOT an HTTP client. It is a builder class whose job is to manufacture
// and configure Dio HTTP client instances with base URLs, headers, and interceptors.
// ....................
// The Dio Registrations (apex, chauffeur, settings, notifications): These are actual HTTP clients created by DioFactory,
// each configured for a specific backend microservice target using ApiTarget enum names.
void initNetworkModule(GetIt serviceLocator) {
  serviceLocator.registerLazySingleton<DioFactory>(
    () => DioFactory(
      serviceLocator<AppEnvironment>(),
      serviceLocator<SessionController>(),
      serviceLocator<Connectivity>(),
      serviceLocator<DeviceMetadata>(),
    ),
  );

  // Register a Dio instance for each ApiTarget using its enum name as instanceName
  for (final target in ApiTarget.values) {
    serviceLocator.registerLazySingleton<Dio>(
      () => serviceLocator<DioFactory>().create(target),
      instanceName: target.name,
    );
  }
}
