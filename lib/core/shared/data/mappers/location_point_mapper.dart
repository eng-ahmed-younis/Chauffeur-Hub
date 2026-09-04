import '../../domain/models/location_point.dart';
import '../dto/location_point_dto.dart';

extension LocationPointMapper on LocationPointDto {
  LocationPoint toDomain() => LocationPoint(
        latitude: latitude,
        longitude: longitude,
        speed: speed,
        recordedAt: sentAt != null ? DateTime.tryParse(sentAt!) : null,
      );
}
