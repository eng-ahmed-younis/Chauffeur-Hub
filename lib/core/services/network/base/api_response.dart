import 'api_exception.dart';

// ignore: prefer_initializing_formals
class ApiResponse<T> {
  const ApiResponse({
    int? code,
    int? statusCode,
    String? message,
    T? result,
  })  : _code = code,
        _statusCode = statusCode,
        _message = message,
        _result = result;

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
    final rawStatusCode =
        json['status_code'] ?? json['statusCode'] ?? json['code'];

    return ApiResponse<T>(
      code: (json['code'] as num?)?.toInt(),
      statusCode: (rawStatusCode as num?)?.toInt(),
      message: json['message'] as String?,
      result: rawResult != null ? decodeResult(rawResult) : null,
    );
  }

  final int? _code;
  final int? _statusCode;
  final String? _message;
  final T? _result;

  int? get code => _code;
  int? get statusCode => _statusCode;
  String? get message => _message;
  T? get result => _result;

  T requireSuccessfulResult() {
    ensureSuccessful();
    final value = _result;
    if (value == null) {
      throw const InvalidResponseException(
        'The response did not contain data.',
      );
    }
    return value;
  }

  void ensureSuccessful() {
    final effectiveCode = _code ?? _statusCode;
    if (effectiveCode == null || effectiveCode < 200 || effectiveCode > 299) {
      throw ServerApiException(
        _message ?? 'Unknown server error.',
        statusCode: effectiveCode,
      );
    }
  }
}
