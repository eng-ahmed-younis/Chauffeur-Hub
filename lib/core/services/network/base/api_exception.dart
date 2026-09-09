sealed class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});

  const factory ApiException.networkUnavailable([String message]) =
      NetworkUnavailableException;
  const factory ApiException.requestTimeout([String message]) =
      RequestTimeoutException;
  const factory ApiException.unauthorized([String message]) =
      UnauthorizedException;
  const factory ApiException.server(String message, {int? statusCode}) =
      ServerApiException;
  const factory ApiException.invalidResponse([String message]) =
      InvalidResponseException;

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

final class NetworkUnavailableException extends ApiException {
  const NetworkUnavailableException([
    super.message = 'No internet connection. Please reconnect and try again.',
  ]);
}

final class RequestTimeoutException extends ApiException {
  const RequestTimeoutException([
    super.message = 'The request timed out. Please try again.',
  ]);
}

final class UnauthorizedException extends ApiException {
  const UnauthorizedException([super.message = 'Your session has expired.'])
    : super(statusCode: 401);
}

final class ServerApiException extends ApiException {
  const ServerApiException(super.message, {super.statusCode});
}

final class InvalidResponseException extends ApiException {
  const InvalidResponseException([super.message = 'Invalid server response.']);
}




/// Traces the execution flow for a network unavailability error:
/// 
/// 1. [ApiException.networkUnavailable()] is called.
/// 2. Factory redirects to [NetworkUnavailableException()].
/// 3. The default error message is applied.
/// 4. `super.message` passes the default message up to the parent [ApiException].
/// 5. [ApiException] assigns it to `this.message`.
