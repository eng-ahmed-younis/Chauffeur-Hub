import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

final class SafeLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('[HTTP] ${options.method} ${options.uri}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    debugPrint('[HTTP] ${response.statusCode} ${response.requestOptions.uri}');
    debugPrint('[RESPONSE] ${response.data}');
    super.onResponse(response, handler);
  }
}
