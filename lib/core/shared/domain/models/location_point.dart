final class LocationPoint {
  const LocationPoint({
    required this.latitude,
    required this.longitude,
    this.speed = 0,
    this.recordedAt,
  });

  factory LocationPoint.fromJson(Map<String, dynamic> json) {
    return LocationPoint(
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      speed: (json['speed'] as num?)?.toDouble() ?? 0,
      recordedAt: json['recordedAt'] != null
          ? DateTime.tryParse(json['recordedAt'].toString())
          : (json['sent_at'] != null
              ? DateTime.tryParse(json['sent_at'].toString())
              : null),
    );
  }

  final double latitude;
  final double longitude;
  final double speed;
  final DateTime? recordedAt;

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'speed': speed,
        if (recordedAt != null) 'recordedAt': recordedAt!.toIso8601String(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocationPoint &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude &&
          speed == other.speed &&
          (recordedAt == other.recordedAt ||
              (recordedAt != null &&
                  other.recordedAt != null &&
                  recordedAt!.toUtc() == other.recordedAt!.toUtc()));

  @override
  int get hashCode =>
      latitude.hashCode ^
      longitude.hashCode ^
      speed.hashCode ^
      (recordedAt?.toUtc().millisecondsSinceEpoch ?? 0);
}
