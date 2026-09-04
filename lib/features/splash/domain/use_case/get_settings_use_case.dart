import '../models/splash_models.dart';
import '../repo/splash_repository.dart';

final class GetSettingsUseCase {
  const GetSettingsUseCase(this._repository);

  final SplashRepository _repository;

  Future<AppSettings> call() async {
    final settings = await _repository.settings();
    await _repository.cacheSettings(settings);
    return settings;
  }

  AppSettings? readCached() => _repository.readCachedSettings();
}
