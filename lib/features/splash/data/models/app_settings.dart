import 'package:equatable/equatable.dart';

import '../../../../core/constants/app_settings_constants.dart';
import 'setting_item.dart';

enum SettingCode {
  minDistanceDriverArriveToPickup(
      AppSettingsConstants.minDistanceDriverArriveToPickup),
  driverPositionMaxAllowedDeviation(
      AppSettingsConstants.driverPositionMaxAllowedDeviation),
  waitingGraceMinutes(AppSettingsConstants.waitingGraceMinutes),
  driverTripRequestExpirationTime(
      AppSettingsConstants.driverTripRequestExpirationTime);

  const SettingCode(this.value);
  final String value;
}

class AppSettings extends Equatable {
  const AppSettings({
    this.items = const [],
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List<dynamic>?;
    final itemsList = rawItems != null
        ? rawItems
            .map((item) => SettingItem.fromJson(item as Map<String, dynamic>))
            .toList()
        : <SettingItem>[];

    return AppSettings(items: itemsList);
  }

  final List<SettingItem> items;

  SettingItem? find(SettingCode code) {
    try {
      return items.firstWhere((item) => item.code == code.value);
    } catch (_) {
      return null;
    }
  }

  SettingItem? get minimumDistanceToArrived =>
      find(SettingCode.minDistanceDriverArriveToPickup);

  SettingItem? get maxDistanceToSendLocation =>
      find(SettingCode.driverPositionMaxAllowedDeviation);

  int get waitingGraceMinutes {
    final itemValue = find(SettingCode.waitingGraceMinutes)?.value;
    if (itemValue == null) {
      return AppSettingsConstants.defaultWaitingGraceMinutes;
    }
    final parsedDouble = double.tryParse(itemValue);
    return parsedDouble?.toInt() ??
        AppSettingsConstants.defaultWaitingGraceMinutes;
  }

  int get driverTripRequestExpirationTime {
    final itemValue = find(SettingCode.driverTripRequestExpirationTime)?.value;
    if (itemValue == null) {
      return AppSettingsConstants.defaultDriverTripRequestExpirationTimeSeconds;
    }
    final parsedDouble = double.tryParse(itemValue);
    return parsedDouble?.toInt() ??
        AppSettingsConstants.defaultDriverTripRequestExpirationTimeSeconds;
  }

  Map<String, dynamic> toJson() => {
        'items': items.map((item) => item.toJson()).toList(),
      };

  @override
  List<Object?> get props => [items];
}
