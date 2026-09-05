final class ResetPasswordParameters {
  const ResetPasswordParameters({
    required this.email,
    required this.otpCode,
    required this.verificationId,
  });

  final String email;
  final String otpCode;
  final int verificationId;
}
