import 'package:chauffeur_hub/core/services/notification/fcm_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chauffeur_hub/core/utils/result.dart';
import 'package:chauffeur_hub/core/utils/validators.dart';
import 'package:chauffeur_hub/core/storage/session_store.dart';
import 'package:chauffeur_hub/core/storage/session_controller.dart';
import 'package:chauffeur_hub/features/auth/domain/usecases/login_use_case.dart';
import 'package:chauffeur_hub/features/auth/presentation/screens/login/bloc/login_event.dart';
import 'package:chauffeur_hub/features/auth/presentation/screens/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this._loginUseCase,
    required this._sessionController,
    required this._store,
    required this._fcmService,
  })  : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_passwordChanged);
    on<OnForgotPasswordPressed>(_onForgotPasswordPressed);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  final LoginUseCase _loginUseCase;
  final SessionController _sessionController;
  final SessionStore _store;
  final FcmService _fcmService;

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        email: event.email,
        isEmailError: event.email.isNotEmpty && !isValidEmail(event.email),
        emailErrorMessage: isValidEmail(event.email) ? null : 'Please enter a valid email',
        status: LoginStatus.initial,
      ),
    );
  }

  void _passwordChanged(LoginPasswordChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        password: event.password,
        isPasswordError:
            event.password.isNotEmpty && !isValidPassword(event.password),
        passwordErrorMessage:
            isValidPassword(event.password) ? null : 'Please enter a valid password',
            //validatePasswordMessage(event.password),
        status: LoginStatus.initial,
      ),
    );
  }

  void _onForgotPasswordPressed(
    OnForgotPasswordPressed event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        effect: LoginEffect.openForgotPassword,
        effectId: state.effectId + 1,
      ),
    );
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    final validEmail = state.email.isNotEmpty && isValidEmail(state.email);
    final validPassword = state.password.isNotEmpty;

    if (!validEmail || !validPassword) {
      emit(
        state.copyWith(
          hasLoginAttempted: true,
          isEmailError: !validEmail,
          isPasswordError: !validPassword,
          status: LoginStatus.failure,
          errorMessage: 'Please enter valid email and password.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading, errorMessage: ''));

    final fcmToken = await _store.fcmToken ?? await _fcmService.getFcmToken() ?? '';

    final result = await _loginUseCase(
      email: state.email,
      password: state.password,
      deviceToken: fcmToken,
    );

    switch (result) {
      case Failure(:final error):
        emit(
          state.copyWith(
            status: LoginStatus.failure,
            errorMessage: error.message,
          ),
        );
      case Success(:final data):
        emit(
          state.copyWith(
            status: LoginStatus.success,
            effect: LoginEffect.openHome,
            effectId: state.effectId + 1,
          ),
        );
    }
  }
}
