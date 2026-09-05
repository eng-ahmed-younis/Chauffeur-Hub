import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chauffeur_hub/core/utils/validators.dart';
import 'package:chauffeur_hub/core/utils/default_values.dart';
import 'package:chauffeur_hub/features/auth/presentation/screens/login/bloc/login_event.dart';
import 'package:chauffeur_hub/features/auth/presentation/screens/login/bloc/login_state.dart';

// ignore_for_file: unused_element

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>((event, emit) {
      emit(
        state.copyWith(
          email: event.email,
          isEmailError: event.email.trim().isEmpty,
        ),
      );
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(
        state.copyWith(
          password: event.password,
          isPasswordError: event.password.trim().isEmpty,
        ),
      );
    });

    on<LoginPasswordVisibilityToggled>((_, emit) {
      emit(state.copyWith(showPasswordField: !state.showPasswordField));
    });

    on<OnLoginButtonPressed>((event, emit) {
      final hasEmailError = event.email.trim().isEmpty;
      final hasPasswordError = event.password.trim().isEmpty;

      emit(
        state.copyWith(
          email: event.email,
          password: event.password,
          isEmailError: hasEmailError,
          isPasswordError: hasPasswordError,
          hasLoginAttempted: true,
          isLoading: false,
          responseMessage: DefaultValues.string,
        ),
      );
    });

    on<OnForgotPasswordPressed>((_, emit) {
      emit(state.copyWith(responseMessage: DefaultValues.string));
    });
  }

  void _onEmailChanged(Emitter<LoginState> emit, LoginEmailChanged event) {
    emit(
      state.copyWith(
        email: event.email,
        isEmailError: event.email.isNotEmpty && !isValidEmail(event.email),
        status: LoginStatus.initial,
      ),
    );
  }

  void _passwordChanged(Emitter<LoginState> emit, LoginPasswordChanged event) {
    emit(
      state.copyWith(
        password: event.password,
        isPasswordError:
            event.password.isNotEmpty && !isValidPassword(event.password),
        status: LoginStatus.initial,
      ),
    );
  }
}
