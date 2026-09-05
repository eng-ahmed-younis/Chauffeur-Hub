import 'package:chauffeur_hub/core/utils/result.dart';
import 'package:chauffeur_hub/features/auth/domain/models/login_driver.dart';
import 'package:chauffeur_hub/features/auth/domain/models/recovery_challenge.dart';

abstract interface class AuthRepository {
  Future<Result<LoginDriver>> login({
    required String email,
    required String password,
    required String deviceToken,
  });

  Future<Result<RecoveryChallenge>> requestPasswordReset(String email);

  Future<Result<void>> verifyOtp({
    required String email,
    required int verificationId,
    required int verificationCode,
  });

  Future<Result<RecoveryChallenge>> resetPassword({
    required String email,
    required String otpCode,
    required int verificationId,
    required String password,
    required String confirmPassword,
  });
}
