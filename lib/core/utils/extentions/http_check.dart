/// Extension on [int] to provide expressive helper getters and user-friendly error messages for HTTP status codes.
extension HttpCheck on int {
  // --- Core Success Checks ---
  /// Returns `true` if the status code is in the 2xx range (200–299).
  bool get isOk => this >= 200 && this <= 299;

  /// Returns `true` if the status code is NOT in the 2xx range.
  bool get isNotOk => !isOk;

  // --- Category Group Checks ---
  /// Informational responses (100–199)
  bool get isInformational => this >= 100 && this <= 199;

  /// Successful responses (200–299)
  bool get isSuccess => isOk;

  /// Redirection messages (300–399)
  bool get isRedirection => this >= 300 && this <= 399;

  /// Client error responses (400–499)
  bool get isClientError => this >= 400 && this <= 499;

  /// Server error responses (500–599)
  bool get isServerError => this >= 500 && this <= 599;

  // --- Specific Success Checks ---
  /// 200 OK
  bool get isSuccessOk => this == 200;

  /// 201 Created
  bool get isCreated => this == 201;

  /// 202 Accepted
  bool get isAccepted => this == 202;

  /// 204 No Content
  bool get isNoContent => this == 204;

  // --- Specific Client Error Checks ---
  /// 400 Bad Request
  bool get isBadRequest => this == 400;

  /// 401 Unauthorized (Session expired or invalid authentication token)
  bool get isUnauthorized => this == 401;

  /// 403 Forbidden (Authenticated, but lacks required permissions)
  bool get isForbidden => this == 403;

  /// 404 Not Found
  bool get isNotFound => this == 404;

  /// 405 Method Not Allowed
  bool get isMethodNotAllowed => this == 405;

  /// 408 Request Timeout
  bool get isRequestTimeout => this == 408;

  /// 409 Conflict
  bool get isConflict => this == 409;

  /// 422 Unprocessable Entity (Validation failed)
  bool get isUnprocessableEntity => this == 422;

  /// 429 Too Many Requests (Rate limit reached)
  bool get isRateLimited => this == 429;

  // --- Specific Server Error Checks ---
  /// 500 Internal Server Error
  bool get isInternalServerError => this == 500;

  /// 502 Bad Gateway
  bool get isBadGateway => this == 502;

  /// 503 Service Unavailable
  bool get isServiceUnavailable => this == 503;

  /// 504 Gateway Timeout
  bool get isGatewayTimeout => this == 504;

  // --- Helper Messages ---
  /// Returns a user-friendly error message based on the HTTP status code.
  String get errorMessage {
    if (isOk) return 'Success';
    if (isBadRequest) return 'Invalid request. Please check the provided details.';
    if (isUnauthorized) return 'Your session has expired. Please log in again.';
    if (isForbidden) return 'You do not have permission to access this resource.';
    if (isNotFound) return 'The requested information could not be found.';
    if (isRequestTimeout) return 'The connection timed out. Please try again.';
    if (isConflict) return 'A conflict occurred. The resource might already exist.';
    if (isUnprocessableEntity) return 'Validation failed. Please verify your input.';
    if (isRateLimited) return 'Too many requests. Please slow down and try again.';
    if (isClientError) return 'Invalid request format or missing data.';
    if (isServiceUnavailable) return 'Service temporarily unavailable. Please try again later.';
    if (isServerError) return 'Our servers are experiencing issues. Please try again later.';
    return 'An unexpected network error occurred.';
  }
}

/// Extension on nullable [int?] to handle HTTP status checks safely when status code may be null.
extension NullableHttpCheck on int? {
  /// Returns `true` if non-null and status code is in the 2xx range (200–299).
  bool get isOk => this != null && this!.isOk;

  /// Returns `true` if null or status code is NOT in the 2xx range.
  bool get isNotOk => !isOk;

  /// Returns `true` if non-null and status code is 401 Unauthorized.
  bool get isUnauthorized => this != null && this!.isUnauthorized;

  /// Returns `true` if non-null and status code is 403 Forbidden.
  bool get isForbidden => this != null && this!.isForbidden;

  /// Returns `true` if non-null and status code is 404 Not Found.
  bool get isNotFound => this != null && this!.isNotFound;

  /// Returns `true` if non-null and is a client error (400–499).
  bool get isClientError => this != null && this!.isClientError;

  /// Returns `true` if non-null and is a server error (500–599).
  bool get isServerError => this != null && this!.isServerError;

  /// Returns a user-friendly error message, or a default message if status code is `null`.
  String get errorMessage => this?.errorMessage ?? 'Network connection error or no response.';
}
