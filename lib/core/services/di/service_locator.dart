import 'package:get_it/get_it.dart';

import 'bloc/bloc_injection.dart';
import 'core/core_injection.dart';
import 'navigation/navigation_injection.dart';
import 'network/network_injection.dart';
import 'repo/repo_injection.dart';
import 'use_cases/use_cases.injection.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> configureDependencies() async {
  await initCoreModule(serviceLocator);
  initNetworkModule(serviceLocator);
  initRepositoryModule(serviceLocator);
  initUseCaseModule(serviceLocator);
  initBlocModule(serviceLocator);
  initNavigationModule(serviceLocator);
}

