sealed class ResetPasswordEvent {
  const ResetPasswordEvent();

  const factory ResetPasswordEvent.submitted({
    required String email,
    required String otpCode,
    required int verificationId,
    required String password,
    required String confirmPassword,
  }) = ResetPasswordSubmitted;
}

final class ResetPasswordSubmitted extends ResetPasswordEvent {
  const ResetPasswordSubmitted({
    required this.email,
    required this.otpCode,
    required this.verificationId,
    required this.password,
    required this.confirmPassword,
  });

  final String email;
  final String otpCode;
  final int verificationId;
  final String password;
  final String confirmPassword;
}
