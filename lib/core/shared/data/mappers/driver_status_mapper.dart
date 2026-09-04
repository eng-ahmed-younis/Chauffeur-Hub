import '../../domain/models/driver_status.dart';
import '../dto/driver_status_dto.dart';

extension DriverStatusMapper on DriverStatusDto {
  DriverStatus toDomain() {
    return DriverStatus.values.firstWhere(
      (e) => e.wireValue == wireValue,
      orElse: () => DriverStatus.notAvailable,
    );
  }
}
