import '../../../../core/shared/domain/models/driver_status.dart';
import '../models/splash_models.dart';

abstract interface class SplashRepository {
  Future<AppSettings> settings();
  Future<AppUpdateType> appUpdateType();
  Future<DriverStatus?> driverStatus();
  Future<void> cacheSettings(AppSettings settings);
  AppSettings? readCachedSettings();
}
