import 'package:dio/dio.dart';
import '../base/api_exception.dart';
import '../../../storage/session_controller.dart';
import '../../../utils/extentions/http_check.dart';


// ignore_for_file: avoid_renaming_method_parameters

// The ErrorInterceptor class is a Dio network interceptor responsible for
// 1- catching, 2- translating, 3- and handling all network errors
// (HTTP failures, timeouts, etc.) globally across your application.
final class ErrorInterceptor extends Interceptor {
  ErrorInterceptor({required SessionController session}) : _session = session;

  final SessionController _session;

  @override
  Future<void> onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final mapped = _map(error);
    if (mapped is UnauthorizedException && _session.isAuthenticated) {
      // The native API exposes no refresh endpoint. A 401 must invalidate the
      // session instead of retrying with the same token indefinitely.
      await _session.signOut();
    }
    handler.reject(error.copyWith(error: mapped));
  }

  // ConnectionInterceptor and ErrorInterceptor work together seamlessly:
  // ConnectionInterceptor Before any request even leaves your device (onRequest), it checks internet connectivity using connectivity_plus.
  //  If there is no internet return NetworkUnavailableException in DioException
  // .......................
  // ErrorInterceptor (The Receiver):
  // When ConnectionInterceptor rejects the request, ErrorInterceptor catches that DioException in onError.
  // Because error.error is already a NetworkUnavailableException (which extends ApiException), your _map method hits this exact line:
  // if (error.error is ApiException) return error.error! as ApiException;
  ApiException _map(DioException error) {
    // this line if true it is from ConnectionInterceptor
    if (error.error is ApiException) return error.error! as ApiException;
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return const RequestTimeoutException();
    }
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    final message = data is Map<String, dynamic>
        ? data['message']?.toString()
        : data?.toString();

    if (statusCode.isUnauthorized) {
      return UnauthorizedException(message ?? statusCode.errorMessage);
    }
    return ServerApiException(
      message ?? statusCode.errorMessage,
      statusCode: statusCode,
    );
  }
}
