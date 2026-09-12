import 'package:chauffeur_hub/features/auth/domain/usecases/forget_password_use_case.dart';
import 'package:chauffeur_hub/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:get_it/get_it.dart';
import '../../../../features/splash/domain/repo/splash_repository.dart';

import 'package:chauffeur_hub/features/auth/domain/repo/auth_repository.dart';

import '../../../../features/splash/domain/use_case/get_settings_use_case.dart';

import 'package:chauffeur_hub/features/auth/domain/usecases/login_use_case.dart';

import '../../../../features/splash/domain/use_case/check_app_update_use_case.dart';
import '../../../../features/splash/domain/use_case/get_driver_status_use_case.dart';
import '../../../storage/session_controller.dart';

void initUseCaseModule(GetIt serviceLocator) {
  serviceLocator
    ..registerLazySingleton<CheckAppUpdateUseCase>(
      () => CheckAppUpdateUseCase(serviceLocator<SplashRepository>()),
    )
    ..registerLazySingleton<GetDriverStatusUseCase>(
      () => GetDriverStatusUseCase(serviceLocator<SplashRepository>()),
    )
    ..registerLazySingleton<GetSettingsUseCase>(
      () => GetSettingsUseCase(serviceLocator<SplashRepository>()),
    )
    ..registerLazySingleton(
      () => LoginUseCase(
        repository: serviceLocator<AuthRepository>(),
        sessionController: serviceLocator<SessionController>(),
      )
    )
    ..registerLazySingleton(
      () => ForgetPasswordUseCase(
        authRepository: serviceLocator<AuthRepository>(),
      )
    )
    ..registerLazySingleton(
      () => VerifyOtpUseCase(
        serviceLocator<AuthRepository>(),
      )
    );
}
