enum TripStatus {
  pending('pending'),
  scheduled('scheduled'),
  rejected('rejected'),
  accepted('accepted'),
  onWay('on_way'),
  arrived('arrived'),
  started('started'),
  cancelled('cancelled'),
  ended('ended');

  const TripStatus(this.wireValue);
  final String wireValue;

  bool get isActive =>
      this == TripStatus.accepted ||
      this == TripStatus.onWay ||
      this == TripStatus.arrived ||
      this == TripStatus.started;
}
