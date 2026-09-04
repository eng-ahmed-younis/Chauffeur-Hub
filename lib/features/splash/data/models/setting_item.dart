import 'package:equatable/equatable.dart';

class SettingItem extends Equatable {
  const SettingItem({
    this.code,
    this.value,
  });

  factory SettingItem.fromJson(Map<String, dynamic> json) {
    return SettingItem(
      code: json['code'] as String?,
      value: json['value'] as String?,
    );
  }

  final String? code;
  final String? value;

  Map<String, dynamic> toJson() => {
        'code': code,
        'value': value,
      };

  @override
  List<Object?> get props => [code, value];
}
