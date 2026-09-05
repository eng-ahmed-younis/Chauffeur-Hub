import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chauffeur_hub/core/utils/result.dart';
import 'package:chauffeur_hub/core/utils/validators.dart';
import 'package:chauffeur_hub/features/auth/domain/usecases/login_use_case.dart';
import 'package:chauffeur_hub/features/auth/presentation/screens/login/bloc/login_event.dart';
import 'package:chauffeur_hub/features/auth/presentation/screens/login/bloc/login_state.dart';

// ignore_for_file: unused_local_variable

// ignore_for_file: unused_element

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc({required this._loginUseCase})
    : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_passwordChanged);
    on<OnForgotPasswordPressed>(_onForgotPasswordPressed);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  final LoginUseCase _loginUseCase;

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        email: event.email,
        isEmailError: event.email.isNotEmpty && !isValidEmail(event.email),
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

    final result = await _loginUseCase(
      email: state.email,
      password: state.password,
      deviceToken: 'dummy-device-token',
    );

    switch (result) {
      case Success(:final data):
        emit(
          state.copyWith(
            status: LoginStatus.success,
            errorMessage: '',
            effect: LoginEffect.openHome,
            effectId: state.effectId + 1,
          ),
        );
      case Failure(:final error):
        emit(
          state.copyWith(
            status: LoginStatus.failure,
            errorMessage: error.message,
            effect: LoginEffect.showError,
            effectId: state.effectId + 1,
          ),
        );
    }
  }
}
