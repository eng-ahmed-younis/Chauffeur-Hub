import '../models/splash_models.dart';
import '../repo/splash_repository.dart';

final class CheckAppUpdateUseCase {
  const CheckAppUpdateUseCase(this._repository);

  final SplashRepository _repository;

  Future<AppUpdateType> call() async {
    try {
      return await _repository.appUpdateType().timeout(
        const Duration(seconds: 5),
      );
    } on Object {
      // App-update checks are optional and must not block startup.
      return AppUpdateType.noUpdate;
    }
  }
}
