final class SettingItemDto {
  const SettingItemDto({
    this.id,
    this.name,
    this.code,
    this.value,
    this.defaultValue,
    this.type,
    this.unit,
    this.unitDescription,
  });

  factory SettingItemDto.fromJson(Map<String, dynamic> json) {
    return SettingItemDto(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      value: json['value'] as String?,
      defaultValue: json['default_value'] as String?,
      type: json['type'] as String?,
      unit: json['unit'] as String?,
      unitDescription: json['unit_desc'] as String?,
    );
  }

  final String? id;
  final String? name;
  final String? code;
  final String? value;
  final String? defaultValue;
  final String? type;
  final String? unit;
  final String? unitDescription;
}
