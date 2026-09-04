import 'package:dio/dio.dart';
import 'base/device_metadata.dart';
import 'package:flutter/foundation.dart';
import 'interceptor/error_interceptor.dart';
import '../../storage/session_controller.dart';
import 'interceptor/safe_log_Interceptor.dart';
import 'interceptor/connection_interceptor.dart';
import '../../../app/config/app_environment.dart';
import 'interceptor/request_metadat_aInterceptor.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


enum ApiTarget { chauffeur, settings, notifications, apex }

final class DioFactory {
  const DioFactory(
    this._environment,
    this._session,
    this._connectivity,
    this._deviceMetadata,
  );

  Dio create(ApiTarget target) {
    final apiKey = target == ApiTarget.apex
        ? _environment.apexApiKey
        : _environment.chauffeurApiKey;

    final dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl(target),
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(minutes: 2),
        sendTimeout: const Duration(minutes: 2),
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    dio.interceptors.addAll([
      ConnectionInterceptor(_connectivity),
      RequestMetadataInterceptor(
        session: _session,
        apiKey: apiKey,
        deviceMetadata: _deviceMetadata,
      ),
      ErrorInterceptor(session: _session),
     // if (kDebugMode) SafeLogInterceptor(),
      if
    ]);

    return dio;
  }

  final AppEnvironment _environment;
  final SessionController _session;
  final Connectivity _connectivity;
  final DeviceMetadata _deviceMetadata;

  String _baseUrl(ApiTarget target) => switch (target) {
    ApiTarget.chauffeur => _environment.chauffeurBaseUrl,
    ApiTarget.settings => _environment.settingsBaseUrl,
    ApiTarget.notifications => _environment.notificationsBaseUrl,
    ApiTarget.apex => _environment.apexBaseUrl,
  };

  List<Interceptor> _interceptors(AppEnvironment environment) {
    if(environment.flavor == AppFlavor) {
      return [
        ConnectionInterceptor(_connectivity),
        RequestMetadataInterceptor(
          session: _session,
          apiKey: environment.chauffeurApiKey,
          deviceMetadata: _deviceMetadata,
        ),
        ErrorInterceptor(session: _session),
        SafeLogInterceptor(),
      ];
    }
  }





}
