import 'package:chauffeur_hub/core/services/notification/fcm_service.dart';
import 'package:get_it/get_it.dart';
import '../../../../features/auth/domain/usecases/forget_password_use_case.dart';
import '../../../../features/auth/domain/usecases/verify_otp_use_case.dart';
import '../../../../features/auth/presentation/screens/forget/bloc/forget_bloc.dart';
import '../../../../features/auth/presentation/screens/otp/bloc/otp_bloc.dart';
import '../../../storage/session_store.dart';
import '../../../storage/session_controller.dart';
import '../../../../features/splash/presentation/bloc/splash_bloc.dart';
import '../../../../features/splash/domain/use_case/get_settings_use_case.dart';
import 'package:chauffeur_hub/features/auth/domain/usecases/login_use_case.dart';
import '../../../../features/splash/domain/use_case/check_app_update_use_case.dart';
import '../../../../features/splash/domain/use_case/get_driver_status_use_case.dart';
import 'package:chauffeur_hub/features/auth/presentation/screens/login/bloc/login_bloc.dart'
    show LoginBloc;

void initBlocModule(GetIt serviceLocator) {
  // registerFactory is commonly used for BLoCs because a BLoC usually
  //belongs to a specific screen/feature lifecycle. not app lifecycle
  serviceLocator.registerFactory<SplashBloc>(
    () => SplashBloc(
      getSettingsUseCase: serviceLocator<GetSettingsUseCase>(),
      checkAppUpdateUseCase: serviceLocator<CheckAppUpdateUseCase>(),
      getDriverStatusUseCase: serviceLocator<GetDriverStatusUseCase>(),
      session: serviceLocator<SessionController>(),
      fcmService: serviceLocator<FcmService>(),
      store: serviceLocator<SessionStore>(),
    ),
  );

  serviceLocator.registerFactory<LoginBloc>(
    () => LoginBloc(
      loginUseCase: serviceLocator<LoginUseCase>(),
      sessionController: serviceLocator<SessionController>(),
      store: serviceLocator<SessionStore>(),
      fcmService: serviceLocator<FcmService>(),
    ),
  );

  serviceLocator.registerFactory<ForgetBloc>(
    () => ForgetBloc(
      forgetPasswordUseCase: serviceLocator<ForgetPasswordUseCase>(),
    ),
  );

  serviceLocator.registerFactory<OtpBloc>(
    () => OtpBloc(
      verifyOtpUseCase: serviceLocator<VerifyOtpUseCase>(),
      forgetPasswordUseCase: serviceLocator<ForgetPasswordUseCase>(),
    ),
  );
}
