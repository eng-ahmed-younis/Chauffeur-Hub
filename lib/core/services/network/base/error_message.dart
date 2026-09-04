import 'package:dio/dio.dart';

import 'api_exception.dart';

String readableError(Object error) {
  // if is one of predefined exceptions return its message
  if (error is ApiException) return error.message;
  // if is DioException and error is ApiException return its message
  if (error is DioException && error.error is ApiException) {
    return (error.error! as ApiException).message;
  }
  return 'Something went wrong. Please try again.';
}
