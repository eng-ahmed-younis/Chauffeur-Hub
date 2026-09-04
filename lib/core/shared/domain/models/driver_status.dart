import 'package:json_annotation/json_annotation.dart';

enum DriverStatus {
  @JsonValue('not_available')
  notAvailable,
  @JsonValue('available')
  available,
  @JsonValue('assigned_to_car')
  assignedToCar,
  @JsonValue('ready_for_order')
  readyForOrder,
  @JsonValue('in_ride')
  inRide,
  @JsonValue('hold')
  hold,
}

extension DriverStatusWire on DriverStatus {
  String get wireValue => switch (this) {
    DriverStatus.notAvailable => 'not_available',
    DriverStatus.available => 'available',
    DriverStatus.assignedToCar => 'assigned_to_car',
    DriverStatus.readyForOrder => 'ready_for_order',
    DriverStatus.inRide => 'in_ride',
    DriverStatus.hold => 'hold',
  };

  bool get isOnline =>
      this == DriverStatus.readyForOrder || this == DriverStatus.inRide;
}
