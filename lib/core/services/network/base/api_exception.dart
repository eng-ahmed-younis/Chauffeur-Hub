sealed class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

final class NetworkUnavailableException extends ApiException {
  const NetworkUnavailableException()
      : super('No internet connection. Please reconnect and try again.');
}

final class RequestTimeoutException extends ApiException {
  const RequestTimeoutException()
      : super('The request timed out. Please try again.');
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
