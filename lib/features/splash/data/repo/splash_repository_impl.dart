import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/shared/domain/models/driver_status.dart';
import '../../domain/models/splash_models.dart';
import '../../domain/repo/splash_repository.dart';
import '../api/splash_api.dart';

final class SplashRepositoryImpl implements SplashRepository {
  const SplashRepositoryImpl(this._api, this._preferences);

  static const _settingsKey = 'app_settings';

  final SplashApi _api;
  final SharedPreferences _preferences;

  @override
  Future<AppUpdateType> appUpdateType() => _api.appUpdateType();

  @override
  Future<DriverStatus?> driverStatus() => _api.driverStatus();

  @override
  Future<AppSettings> settings() => _api.settings();

  @override
  Future<void> cacheSettings(AppSettings settings) =>
      _preferences.setString(_settingsKey, jsonEncode(settings.toJson()));

  @override
  AppSettings? readCachedSettings() {
    final value = _preferences.getString(_settingsKey);
    if (value == null) return null;
    try {
      return AppSettings.fromJson(
        Map<String, dynamic>.from(jsonDecode(value) as Map),
      );
    } on Object {
      return null;
    }
  }
}
