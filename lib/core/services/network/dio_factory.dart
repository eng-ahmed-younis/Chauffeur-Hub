import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:webase_chucker/webase_chucker.dart';

import '../../../app/config/app_environment.dart';
import '../../../app/config/app_flavor.dart';
import '../../storage/session_controller.dart';
import 'base/device_metadata.dart';
import 'interceptor/connection_interceptor.dart';
import 'interceptor/error_interceptor.dart';
import 'interceptor/request_metadat_aInterceptor.dart';
import 'interceptor/safe_log_Interceptor.dart';

enum ApiTarget { chauffeur, settings, notifications, apex }

final class DioFactory {
  const DioFactory(
      this._environment,
      this._session,
      this._connectivity,
      this._deviceMetadata,
      );

  final AppEnvironment _environment;
  final SessionController _session;
  final Connectivity _connectivity;
  final DeviceMetadata _deviceMetadata;

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

    dio.interceptors.addAll(_interceptors(apiKey));

    return dio;
  }

  String _baseUrl(ApiTarget target) => switch (target) {
    ApiTarget.chauffeur => _environment.chauffeurBaseUrl,
    ApiTarget.settings => _environment.settingsBaseUrl,
    ApiTarget.notifications => _environment.notificationsBaseUrl,
    ApiTarget.apex => _environment.apexBaseUrl,
  };

  List<Interceptor> _interceptors(String apiKey) {
    final isNonProd =
        _environment.flavor == AppFlavor.staging ||
            _environment.flavor == AppFlavor.uat ||
            _environment.flavor == AppFlavor.dev;

    final shouldLog = kDebugMode || isNonProd;

    return [
      ConnectionInterceptor(_connectivity),
      RequestMetadataInterceptor(
        session: _session,
        apiKey: apiKey,
        deviceMetadata: _deviceMetadata,
      ),
      ErrorInterceptor(session: _session),
      if (shouldLog) ...[SafeLogInterceptor(), WebaseChucker.interceptor],
    ];
  }
}
