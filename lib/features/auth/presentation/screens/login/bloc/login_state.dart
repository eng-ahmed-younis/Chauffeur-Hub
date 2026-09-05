import '../../../../../../core/utils/default_values.dart';

enum LoginStatus { initial, loading, success, failure }

enum LoginEffect { none, openForgotPassword, openHome, showError }

final class LoginState {
  const LoginState({
    this.email = DefaultValues.string,
    this.password = DefaultValues.string,
    this.hasLoginAttempted = DefaultValues.boolean,
    this.isEmailError = DefaultValues.boolean,
    this.isPasswordError = DefaultValues.boolean,
    this.status = LoginStatus.initial,
    this.errorMessage = DefaultValues.string,
    this.effect = LoginEffect.none,
    this.effectId = DefaultValues.integer,
  });

  final String email;
  final String password;
  final bool hasLoginAttempted;
  final bool isEmailError;
  final bool isPasswordError;
  final LoginStatus status;
  final String errorMessage;
  final LoginEffect effect;
  final int effectId;

  LoginState copyWith({
    String? email,
    String? password,
    bool? hasLoginAttempted,
    bool? isEmailError,
    bool? isPasswordError,
    LoginStatus? status,
    String? errorMessage,
    LoginEffect? effect,
    int? effectId, 
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      hasLoginAttempted: hasLoginAttempted ?? this.hasLoginAttempted,
      isEmailError: isEmailError ?? this.isEmailError,
      isPasswordError: isPasswordError ?? this.isPasswordError,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      effect: effect ?? this.effect,
      effectId: effectId ?? this.effectId,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginState &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password &&
          hasLoginAttempted == other.hasLoginAttempted &&
          isEmailError == other.isEmailError &&
          isPasswordError == other.isPasswordError &&
          status == other.status &&
          errorMessage == other.errorMessage &&
          effect == other.effect &&
          effectId == other.effectId;

  @override
  int get hashCode => Object.hash(
    email,
    password,
    hasLoginAttempted,
    isEmailError,
    isPasswordError,
    status,
    errorMessage,
    effect,
    effectId,
  );
}
