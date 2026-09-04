import 'package:equatable/equatable.dart';

enum UpdateType {
  forced('forced'),
  optional('optional'),
  noUpdate('no_update');

  const UpdateType(this.value);
  final String value;

  factory UpdateType.from(String? value) {
    switch (value?.toLowerCase()) {
      case 'forced':
        return UpdateType.forced;
      case 'optional':
        return UpdateType.optional;
      default:
        return UpdateType.noUpdate;
    }
  }

  bool get isForced => this == UpdateType.forced;
  bool get isOptional => this == UpdateType.optional;
  bool get hasUpdate => this != UpdateType.noUpdate;
}

class AppInfo extends Equatable {
  const AppInfo({
    this.updateType = UpdateType.noUpdate,
  });

  factory AppInfo.fromJson(Map<String, dynamic> json) {
    final rawType = json['update_type'] as String? ?? json['updateType'] as String?;
    return AppInfo(
      updateType: UpdateType.from(rawType),
    );
  }

  final UpdateType updateType;

  Map<String, dynamic> toJson() => {
        'update_type': updateType.value,
      };

  @override
  List<Object?> get props => [updateType];
}
