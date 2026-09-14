import 'package:chauffeur_hub/core/services/network/base/api_exception.dart';
import 'package:chauffeur_hub/core/utils/result.dart';
import 'package:chauffeur_hub/features/auth/data/api/auth_api.dart';
import 'package:chauffeur_hub/features/auth/data/mapper/forget_password_mapper.dart';
import 'package:chauffeur_hub/features/auth/data/mapper/login_driver_mapper.dart';
import 'package:chauffeur_hub/features/auth/domain/models/forget_password.dart';
import 'package:chauffeur_hub/features/auth/domain/models/login_driver.dart';
import 'package:chauffeur_hub/features/auth/domain/repo/auth_repository.dart';

import '../../../../core/shared/request/otp_request.dart';
import '../../../../core/shared/request/reset_password.dart';

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
  Future<Result<ForgetPassword>> forgetPasswordRequest(String email) async {
    try {
      final dto = await _api.requestPasswordForget(email);
      return Result.success(dto.toDomain());
    } on ApiException catch (error) {
      return Result.failure(error);
    }
  }

  @override
  Future<Result<void>> verifyOtp({
    required OtpRequest otpRequest,
  }) async {
    try {
      await _api.verifyOtp(
        otpRequest: otpRequest,
      );
      return const Result.success(null);
    } on ApiException catch (error) {
      return Result.failure(error);
    }
  }

  @override
  Future<Result<ForgetPassword>> resetPassword({
    required ResetPassword request,
  }) async {
    try {
      final dto = await _api.resetPassword(request: request);
      return Result.success(dto.toDomain());
    } on ApiException catch (error) {
      return Result.failure(error);
    }
  }
}
