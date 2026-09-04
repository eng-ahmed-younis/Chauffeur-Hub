final class LocationPointDto {
  const LocationPointDto({
    required this.latitude,
    required this.longitude,
    this.speed = 0,
    this.sentAt,
  });

  factory LocationPointDto.fromJson(Map<String, dynamic> json) {
    return LocationPointDto(
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      speed: (json['speed'] as num?)?.toDouble() ?? 0,
      sentAt: json['sent_at']?.toString() ?? json['recordedAt']?.toString(),
    );
  }

  final double latitude;
  final double longitude;
  final double speed;
  final String? sentAt;
}
