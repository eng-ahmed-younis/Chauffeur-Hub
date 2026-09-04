import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/config/app_environment.dart';
import '../../../storage/session_controller.dart';
import '../../../storage/session_store.dart';
import '../../network/base/device_metadata.dart';

Future<void> initCoreModule(GetIt serviceLocator) async {
  final deviceMetadata = await DeviceMetadata.load();
  final preferences = await SharedPreferences.getInstance();
  final preferencesAsync = SharedPreferencesAsync();
  const secureStorage = FlutterSecureStorage();

  serviceLocator
    ..registerSingleton<AppEnvironment>(AppEnvironment.fromDefines())
    ..registerSingleton<SharedPreferences>(preferences)
    ..registerLazySingleton<SharedPreferencesAsync>(() => preferencesAsync)
    ..registerLazySingleton<FlutterSecureStorage>(() => secureStorage)
    ..registerSingleton<DeviceMetadata>(deviceMetadata)
    ..registerSingleton<Connectivity>(Connectivity());

  serviceLocator.registerLazySingleton<SessionStore>(
    () => SecureSessionStore(
      serviceLocator<FlutterSecureStorage>(),
      serviceLocator<SharedPreferencesAsync>(),
    ),
  );

  serviceLocator.registerLazySingleton<SessionController>(
    () => SessionController(serviceLocator<SessionStore>()),
  );
}
