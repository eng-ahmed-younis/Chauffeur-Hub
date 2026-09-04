import 'package:dio/dio.dart';
import 'package:chauffeur_hub/core/storage/session_controller.dart';
import 'package:chauffeur_hub/core/services/network/base/device_metadata.dart';

// ignore_for_file: unused_field
// ignore_for_file: file_names
// ignore_for_file: prefer_initializing_formals

final class RequestMetadataInterceptor extends Interceptor {
  const RequestMetadataInterceptor({
    required SessionController session,
    required String apiKey,
    required DeviceMetadata deviceMetadata,
  }) : _session = session,
       _apiKey = apiKey,
       _deviceMetadata = deviceMetadata;

  final SessionController _session;
  final String _apiKey;
  final DeviceMetadata _deviceMetadata;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.contentType = Headers.jsonContentType;

    if (_apiKey.isNotEmpty) {
      options.headers['api-key'] = _apiKey;
    }

    final token = _session.token;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    if (_deviceMetadata.deviceId.isNotEmpty) {
      options.headers['deviceId'] = _deviceMetadata.deviceId;
    }

    options.headers['Content-Language'] = 'en';
    options.headers['platformType'] = _deviceMetadata.platformType;
    options.headers['deviceType'] = _deviceMetadata.deviceType;
    options.headers['osVersion'] = _deviceMetadata.osVersion;
    options.headers['appVersion'] = _deviceMetadata.appVersion;
    options.headers['deviceModel'] = _deviceMetadata.deviceModel;
    options.headers['user-type'] = 'driver';

    return super.onRequest(options, handler);
  }
}
