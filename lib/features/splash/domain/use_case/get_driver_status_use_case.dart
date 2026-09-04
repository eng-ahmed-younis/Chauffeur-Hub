import '../../../../core/shared/domain/models/driver_status.dart';
import '../repo/splash_repository.dart';

final class GetDriverStatusUseCase {
  const GetDriverStatusUseCase(this._repository);

  final SplashRepository _repository;

  Future<DriverStatus?> call() => _repository.driverStatus();
}
