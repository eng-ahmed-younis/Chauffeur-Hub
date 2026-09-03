import 'package:get_it/get_it.dart';

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
  // Register Blocs & Cubits
}

