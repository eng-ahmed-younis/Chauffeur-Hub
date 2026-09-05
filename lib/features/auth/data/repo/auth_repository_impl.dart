import 'package:chauffeur_hub/core/utils/result.dart';
import 'package:chauffeur_hub/features/auth/data/api/auth_api.dart';
import 'package:chauffeur_hub/core/services/network/base/api_exception.dart';
import 'package:chauffeur_hub/features/auth/domain/models/login_driver.dart';
import 'package:chauffeur_hub/features/auth/domain/repo/auth_repository.dart';
import 'package:chauffeur_hub/features/auth/data/mapper/login_driver_mapper.dart';
import 'package:chauffeur_hub/features/auth/domain/models/recovery_challenge.dart';
import 'package:chauffeur_hub/features/auth/data/mapper/recovery_challenge_mapper.dart';

final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._api);

  final AuthApi _api;

  @override
  Future<Result<LoginDriver>> login({
    required String email,
    required String password,
    required String deviceToken,
  }) async {
    try {
      final dto = await _api.login(
        email: email,
        password: password,
        deviceToken: deviceToken,
      );
      return Result.success(dto.toDomain());
    } on ApiException catch (error) {
      return Result.failure(error);
    }
  }

  @override
  Future<Result<RecoveryChallenge>> requestPasswordReset(String email) async {
    try {
      final dto = await _api.requestPasswordReset(email);
      return Result.success(dto.toDomain());
    } on ApiException catch (error) {
      return Result.failure(error);
    }
  }

  @override
  Future<Result<void>> verifyOtp({
    required String email,
    required int verificationId,
    required int verificationCode,
  }) async {
    try {
      await _api.verifyOtp(
        email: email,
        verificationId: verificationId,
        verificationCode: verificationCode,
      );
      return const Result.success(null);
    } on ApiException catch (error) {
      return Result.failure(error);
    }
  }

  @override
  Future<Result<RecoveryChallenge>> resetPassword({
    required String email,
    required String otpCode,
    required int verificationId,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final dto = await _api.resetPassword(
        email: email,
        otpCode: otpCode,
        verificationId: verificationId,
        password: password,
        confirmPassword: confirmPassword,
      );
      return Result.success(dto.toDomain());
    } on ApiException catch (error) {
      return Result.failure(error);
    }
  }
}
