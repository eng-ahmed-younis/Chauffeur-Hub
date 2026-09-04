import 'package:dio/dio.dart';
import '../base/api_exception.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


final class ConnectionInterceptor extends Interceptor {
  const ConnectionInterceptor(this._connectivity);

  final Connectivity _connectivity;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: const NetworkUnavailableException(),
          type: DioExceptionType.connectionError,
        ),
      );
    }
    return super.onRequest(options, handler);
  }
}
