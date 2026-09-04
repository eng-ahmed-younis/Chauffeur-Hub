import 'api_exception.dart';

class ApiResponse<T> {
  const ApiResponse({
    this.code,
    this.statusCode,
    this.message,
    this.result,
  });

  // T Function(Object? json)
  // │     │        │
  // │     │        └── parameter is Object?
  // │     │
  // │     └── this is a function
  // │
  // └── function returns T
  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) decodeResult,
  ) {
    final rawResult = json['result'] ?? json['data'];
    return ApiResponse<T>(
      code: (json['code'] as num?)?.toInt(),
      statusCode: (json['statusCode'] as num?)?.toInt(),
      message: json['message'] as String?,
      result: rawResult != null ? decodeResult(rawResult) : null,
    );
  }

  final int? code;
  final int? statusCode;
  final String? message;
  final T? result;

  T requireSuccessfulResult() {
    ensureSuccessful();
    final value = result;
    if (value == null) {
      throw const InvalidResponseException(
        'The response did not contain data.',
      );
    }
    return value;
  }

  void ensureSuccessful() {
    final effectiveCode = code ?? statusCode;
    if (effectiveCode == null || effectiveCode < 200 || effectiveCode > 299) {
      throw ServerApiException(
        message ?? 'Unknown server error.',
        statusCode: effectiveCode,
      );
    }
  }
}
