enum OtpDestination { login }

sealed class OtpEvent {
  const OtpEvent();

  const factory OtpEvent.emailChanged({required String email}) = OtpEmailChanged;
  const factory OtpEvent.otpCodeChanged({required String otpCode}) = OtpCodeChanged;
  const factory OtpEvent.verifyOtp({required String otpCode, required int verificationId}) = VerifyOtp;
  const factory OtpEvent.sendOtpAgain() = SendOtpAgain;
}

final class OtpEmailChanged extends OtpEvent {
  const OtpEmailChanged({required this.email});
  final String email;
}

final class OtpCodeChanged extends OtpEvent {
  const OtpCodeChanged({required this.otpCode});
  final String otpCode;
}

final class VerifyOtp extends OtpEvent {
  const VerifyOtp({required this.otpCode, required this.verificationId});
  final String otpCode;
  final int verificationId;
}

final class SendOtpAgain extends OtpEvent {
  const SendOtpAgain();
}
