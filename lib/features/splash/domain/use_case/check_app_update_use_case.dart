import '../models/splash_models.dart';
import '../repo/splash_repository.dart';

final class CheckAppUpdateUseCase {
  const CheckAppUpdateUseCase(this._repository);

  final SplashRepository _repository;

  Future<AppUpdateType> call() => _repository.appUpdateType();
}
