import 'package:dio/dio.dart';
import 'splash_endpoints.dart';
import '../../domain/models/splash_models.dart';
import '../../../../core/utils/network/api_response_utils.dart';
import '../../../../core/shared/data/dto/driver_status_dto.dart';
import '../../../../core/shared/domain/models/driver_status.dart';
import '../../../../core/services/network/base/device_metadata.dart';
import '../../../../core/shared/data/mappers/driver_status_mapper.dart';


final class DriverProfile {
  const DriverProfile({this.status});

  final DriverStatus? status;

  factory DriverProfile.fromJson(Map<String, dynamic> json) {
    final statusWire = json['status']?.toString();
    return DriverProfile(
      status: statusWire != null
          ? DriverStatusDto.fromJson(statusWire).toDomain()
          : null,
    );
  }
}

final class SplashApi {
  const SplashApi(this._settingsDio, this._chauffeurDio, this._deviceMetadata);

  final Dio _settingsDio;
  final Dio _chauffeurDio;
  final DeviceMetadata _deviceMetadata;

  Future<AppSettings> settings() async {
    final response = await _settingsDio.get<Object?>(
      SplashEndpoints.settings,
      queryParameters: const {'take': 1000},
    );
    return parseApiResponse(
      response.data,
      (json) => AppSettings.fromJson(asMap(json)),
    ).requireSuccessfulResult();
  }

  Future<AppUpdateType> appUpdateType() async {
    final response = await _chauffeurDio.get<Object?>(
      SplashEndpoints.appInfo,
      queryParameters: {
        'app_name': 'Shift Driver',
        'platform': _deviceMetadata.platformType,
        'os_version': _extractMajorVersion(_deviceMetadata.osVersion),
        'app_version': int.tryParse(_deviceMetadata.appBuildNumber) ?? 0,
      },
    );
    final result = parseApiResponse<Map<String, dynamic>>(
      response.data,
      asMap,
    ).requireSuccessfulResult();
    return AppUpdateTypeParser.fromWire(result['update_type']?.toString());
  }

  Future<DriverStatus?> driverStatus() async {
    final response = await _chauffeurDio.get<Object?>(
      SplashEndpoints.driverProfile,
      options: Options(headers: const {'latitude': '', 'longitude': ''}),
    );
    final profile = parseApiResponse(
      response.data,
      (json) => DriverProfile.fromJson(asMap(json)),
    ).requireSuccessfulResult();
    return profile.status;
  }

  int _extractMajorVersion(String value) =>
      int.tryParse(value.split('.').firstOrNull ?? '') ?? 0;
}
