import 'package:dio/dio.dart';
import 'package:chauffeur_hub/core/utils/network/api_response_utils.dart';
import 'package:chauffeur_hub/features/auth/data/api/auth_endpoints.dart';
import 'package:chauffeur_hub/features/auth/data/dto/login_driver_dto.dart';
import 'package:chauffeur_hub/core/services/network/base/api_exception.dart';
import 'package:chauffeur_hub/features/auth/data/dto/recovery_challenge_dto.dart';

// ignore_for_file: unused_element

final class AuthApi {
  AuthApi(this._dio);

  final Dio _dio;

  Future<LoginDriverDto> login({
    required String email,
    required String password,
    required String deviceToken,
  }) async {
    try {
      final response = await _dio.post(
        AuthEndpoints.login,
        data: {
          'app': 'chauffeur',
          'email': email,
          'password': password,
          'device_token': deviceToken,
        },
      );

      final result = parseApiResponse<Map<String, dynamic>>(
        response.data,
        asMap,
      ).requireSuccessfulResult();

      return LoginDriverDto.fromJson(result);
    } on DioException catch (e) {
      throw ServerApiException(
        e.message ?? 'Login request failed.',
        statusCode: e.response?.statusCode,
      );
    } on ApiException {
      // “throw the same exception again, without changing it.”
      rethrow;
    }
  }

  Future<RecoveryChallengeDto> requestPasswordReset(String email) async {
    try {
      final response = await _dio.post(
        AuthEndpoints.forgotPassword,
        data: {'email': email},
      );

      final result = parseApiResponse<Map<String, dynamic>>(
        response.data,
        asMap,
      ).requireSuccessfulResult();

      return RecoveryChallengeDto.fromJson(result);
    } on DioException catch (e) {
      throw ServerApiException(
        e.message ?? 'Password reset request failed.',
        statusCode: e.response?.statusCode,
      );
    } on ApiException {
      rethrow;
    }
  }

  Future<void> verifyOtp({
    required String email,
    required int verificationId,
    required int verificationCode,
  }) async {
    try {
      final response = await _dio.post(
        AuthEndpoints.verifyOtp,
        data: {
          'email': email,
          'verification_id': verificationId,
          'verification_code': verificationCode,
        },
      );

      parseApiResponse<Object?>(
        response.data,
        (json) => json,
      ).requireSuccessfulResult();
    } on DioException catch (e) {
      throw ServerApiException(
        e.message ?? 'OTP verification failed.',
        statusCode: e.response?.statusCode,
      );
    } on ApiException {
      rethrow;
    }
  }

  Future<RecoveryChallengeDto> resetPassword({
    required String email,
    required String otpCode,
    required int verificationId,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await _dio.post(
        AuthEndpoints.resetPassword,
        data: {
          'email': email,
          'otp_code': otpCode,
          'verification_id': verificationId,
          'password': password,
          'confirm_password': confirmPassword,
        },
      );

      final result = parseApiResponse<Map<String, dynamic>>(
        response.data,
        asMap,
      ).requireSuccessfulResult();

      return RecoveryChallengeDto.fromJson(result);
    } on DioException catch (e) {
      throw ServerApiException(
        e.message ?? 'Reset password failed.',
        statusCode: e.response?.statusCode,
      );
    } on ApiException {
      rethrow;
    }
  }
}
