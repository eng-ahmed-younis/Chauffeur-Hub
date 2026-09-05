sealed class LoginEvent {
  const LoginEvent();

  const factory LoginEvent.emailChanged({required String email}) =
      LoginEmailChanged;

  const factory LoginEvent.passwordChanged({required String password}) =
      LoginPasswordChanged;

  const factory LoginEvent.passwordVisibilityToggled() =
      LoginPasswordVisibilityToggled;

  const factory LoginEvent.loginButtonPressed({
    required String email,
    required String password,
  }) = OnLoginButtonPressed;

  const factory LoginEvent.forgotPasswordPressed() = OnForgotPasswordPressed;
}

final class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged({required this.email});

  final String email;
}

final class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged({required this.password});

  final String password;
}

final class LoginPasswordVisibilityToggled extends LoginEvent {
  const LoginPasswordVisibilityToggled();
}

final class OnLoginButtonPressed extends LoginEvent {
  const OnLoginButtonPressed({required this.email, required this.password});

  final String email;
  final String password;
}

final class OnForgotPasswordPressed extends LoginEvent {
  const OnForgotPasswordPressed();
}
