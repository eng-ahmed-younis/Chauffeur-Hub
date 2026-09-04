abstract final class AppSettingsConstants {
  // Setting Code Keys
  static const String minDistanceDriverArriveToPickup =
      'MIN_DISTANCE_DRIVER_ARRIVE_TO_PICKUP';
  static const String driverPositionMaxAllowedDeviation =
      'DRIVER_POSITION_MAX_ALLOWED_DEVIATION';
  static const String waitingGraceMinutes = 'WAITING_GRACE_MINUTES';
  static const String driverTripRequestExpirationTime =
      'DRIVER_TRIP_REQUEST_EXPIRATION_TIME';

  // Default Values
  static const int defaultWaitingGraceMinutes = 2;
  static const int defaultDriverTripRequestExpirationTimeSeconds = 15;
}
