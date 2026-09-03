import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../storage/session_controller.dart';
import '../../../storage/session_store.dart';

Future<void> initCoreModule(GetIt serviceLocator) async {
  final preferencesAsync = SharedPreferencesAsync();
  serviceLocator.registerLazySingleton<SharedPreferencesAsync>(
    () => preferencesAsync,
  );

  const secureStorage = FlutterSecureStorage();
  serviceLocator.registerLazySingleton<FlutterSecureStorage>(
    () => secureStorage,
  );

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
