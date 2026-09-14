import 'package:chauffeur_hub/core/services/network/base/api_exception.dart';
import 'package:chauffeur_hub/core/shared/request/otp_request.dart';
import 'package:chauffeur_hub/core/shared/request/reset_password.dart';
import 'package:chauffeur_hub/core/utils/network/api_response_utils.dart';
import 'package:chauffeur_hub/features/auth/data/api/auth_endpoints.dart';
import 'package:chauffeur_hub/features/auth/data/dto/forget_password_dto.dart';
import 'package:chauffeur_hub/features/auth/data/dto/login_driver_dto.dart';
import 'package:dio/dio.dart';

final class AuthApi {
  AuthApi({
    required this._apexDio,
  });

  final Dio _apexDio;

  ApiException _handleDioError(DioException e, String fallback) {
    if (e.error is ApiException) {
      return e.error! as ApiException;
    }
    final data = e.response?.data;
    final serverMessage = data is Map<String, dynamic>
        ? (data['message']?.toString() ??
            data['error']?.toString() ??
            data['msg']?.toString())
        : null;

    return ApiException.server(
      serverMessage ?? e.message ?? fallback,
      statusCode: e.response?.statusCode,
    );
  }

  Future<LoginDriverDto> login({
    required String email,
    required String password,
    required String deviceToken,
  }) async {
    try {
      final response = await _apexDio.post<Map<String, dynamic>>(
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
      throw _handleDioError(e, 'Login request failed.');
    } on ApiException {
      rethrow;
    }
  }

  Future<ForgetPasswordDto> requestPasswordForget(String email) async {
    try {
      final response = await _apexDio.post<Map<String, dynamic>>(
        AuthEndpoints.forgotPassword,
        data: {'email': email},
      );

      final result = parseApiResponse<Map<String, dynamic>>(
        response.data,
        asMap,
      ).requireSuccessfulResult();

      return ForgetPasswordDto.fromJson(result);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Password forget request failed.');
    } on ApiException {
      rethrow;
    }
  }

  Future<void> verifyOtp({
    required OtpRequest otpRequest,
  }) async {
    try {
      final response = await _apexDio.post<Map<String, dynamic>>(
        AuthEndpoints.verifyOtp,
        data: {
          'email': otpRequest.email,
          'verification_id': otpRequest.verificationId,
          'verification_code': otpRequest.verificationCode,
          'isCheck': otpRequest.isCheck,
        },
      );

      parseApiResponse<Object?>(
        response.data,
        (json) => json,
      ).requireSuccessfulResult();
    } on DioException catch (e) {
      throw _handleDioError(e, 'OTP verification failed.');
    } on ApiException {
      rethrow;
    }
  }

  Future<ForgetPasswordDto> resetPassword({
    required ResetPassword request,
  }) async {
    try {
      final response = await _apexDio.post<Map<String, dynamic>>(
        AuthEndpoints.resetPassword,
        data: {
          'email': request.email,
          'otp_code': request.otpCode,
          'verification_id': request.verificationId,
          'password': request.password,
          'confirm_password': request.confirmPassword,
        },
      );

      final result = parseApiResponse<Map<String, dynamic>>(
        response.data,
        asMap,
      ).requireSuccessfulResult();

      return ForgetPasswordDto.fromJson(result);
    } on DioException catch (e) {
      throw _handleDioError(e, 'Reset password failed.');
    } on ApiException {
      rethrow;
    }
  }
}
