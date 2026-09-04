final class DriverStatusDto {
  const DriverStatusDto({required this.wireValue});

  factory DriverStatusDto.fromJson(Object? value) {
    return DriverStatusDto(wireValue: value?.toString() ?? '');
  }

  final String wireValue;
}
