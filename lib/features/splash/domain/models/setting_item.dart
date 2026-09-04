import 'package:equatable/equatable.dart';

final class SettingItem extends Equatable {
  const SettingItem({
    this.id,
    this.name,
    this.code,
    this.value,
    this.defaultValue,
    this.type,
    this.unit,
    this.unitDescription,
  });

  factory SettingItem.fromJson(Map<String, dynamic> json) {
    return SettingItem(
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

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'code': code,
        'value': value,
        'default_value': defaultValue,
        'type': type,
        'unit': unit,
        'unit_desc': unitDescription,
      };

  SettingItem copyWith({
    String? id,
    String? name,
    String? code,
    String? value,
    String? defaultValue,
    String? type,
    String? unit,
    String? unitDescription,
  }) {
    return SettingItem(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      value: value ?? this.value,
      defaultValue: defaultValue ?? this.defaultValue,
      type: type ?? this.type,
      unit: unit ?? this.unit,
      unitDescription: unitDescription ?? this.unitDescription,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        code,
        value,
        defaultValue,
        type,
        unit,
        unitDescription,
      ];
}
