

import 'package:get_it/get_it.dart';

import '../../../../features/splash/domain/use_case/check_app_update_use_case.dart';
import '../../../../features/splash/domain/use_case/get_driver_status_use_case.dart';
import '../../../../features/splash/domain/use_case/get_settings_use_case.dart';
import '../../../../features/splash/presentation/bloc/splash_bloc.dart';
import '../../../storage/session_controller.dart';

void initBlocModule(GetIt serviceLocator) {
  serviceLocator.registerFactory<SplashBloc>(
        () => SplashBloc(
      getSettingsUseCase: serviceLocator<GetSettingsUseCase>(),
      checkAppUpdateUseCase: serviceLocator<CheckAppUpdateUseCase>(),
      getDriverStatusUseCase: serviceLocator<GetDriverStatusUseCase>(),
      session: serviceLocator<SessionController>(),
    ),
  );
}