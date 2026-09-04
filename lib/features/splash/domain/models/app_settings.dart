import 'package:equatable/equatable.dart';

import 'setting_item.dart';

final class AppSettings extends Equatable {
  const AppSettings({
    this.items = const <SettingItem>[],
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'];
    final itemsList = rawItems is List
        ? rawItems
            .whereType<Map<String, dynamic>>()
            .map(SettingItem.fromJson)
            .toList()
        : const <SettingItem>[];
    return AppSettings(items: itemsList);
  }

  final List<SettingItem> items;

  static const defaultWaitingGraceMinutes = 2;
  static const defaultTripRequestExpirationSeconds = 15;

  Map<String, dynamic> toJson() => {
        'items': items.map((e) => e.toJson()).toList(),
      };

  SettingItem? _find(String code) =>
      items.where((item) => item.code == code).firstOrNull;

  SettingItem? get minimumDistanceToArrived =>
      _find('MIN_DISTANCE_DRIVER_ARRIVE_TO_PICKUP');

  SettingItem? get maximumLocationDeviation =>
      _find('DRIVER_POSITION_MAX_ALLOWED_DEVIATION');

  int get waitingGraceMinutes =>
      double.tryParse(_find('WAITING_GRACE_MINUTES')?.value ?? '')?.toInt() ??
      defaultWaitingGraceMinutes;

  int get tripRequestExpirationSeconds =>
      double.tryParse(_find('DRIVER_TRIP_REQUEST_EXPIRATION_TIME')?.value ?? '')
          ?.toInt() ??
      defaultTripRequestExpirationSeconds;

  AppSettings copyWith({List<SettingItem>? items}) {
    return AppSettings(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}
