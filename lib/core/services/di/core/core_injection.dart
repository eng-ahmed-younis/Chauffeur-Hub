import 'package:chauffeur_hub/core/services/notification/fcm_service.dart';
import 'package:get_it/get_it.dart';
import '../../../storage/session_store.dart';
import '../../network/base/device_metadata.dart';
import '../../../storage/session_controller.dart';
import '../../../../app/config/app_environment.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> initCoreModule(GetIt serviceLocator) async {
  // Initialize Firebase in the background without blocking main startup thread
  FcmService.initializeFirebase();

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
    ..registerSingleton<Connectivity>(Connectivity())
    ..registerLazySingleton<FcmService>(() => FcmService());

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
