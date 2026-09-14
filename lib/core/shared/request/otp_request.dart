final class OtpRequest {

  const OtpRequest({
    this.isCheck = true,
    this.callingCode,
    this.mobile,
    this.email,
    this.verificationId,
    this.verificationCode,
  });

  final bool? isCheck;
  final String? callingCode;
  final String? mobile;
  final String? email;
  final int? verificationId;
  final int? verificationCode;
}



