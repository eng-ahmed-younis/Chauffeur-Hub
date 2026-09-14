import 'package:chauffeur_hub/core/utils/result.dart';
import 'package:chauffeur_hub/features/auth/domain/models/forget_password.dart';
import 'package:chauffeur_hub/features/auth/domain/models/login_driver.dart';

import '../../../../core/shared/request/otp_request.dart';
import '../../../../core/shared/request/reset_password.dart';

abstract interface class AuthRepository {
  Future<Result<LoginDriver>> login({
    required String email,
    required String password,
    required String deviceToken,
  });

  Future<Result<ForgetPassword>> forgetPasswordRequest(String email);

  Future<Result<void>> verifyOtp({
    required OtpRequest otpRequest,
  });

  Future<Result<ForgetPassword>> resetPassword({
    required ResetPassword request,
  });
}
