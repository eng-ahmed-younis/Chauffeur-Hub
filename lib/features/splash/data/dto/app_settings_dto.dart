import 'setting_item_dto.dart';

final class AppSettingsDto {
  const AppSettingsDto({this.items = const []});

  factory AppSettingsDto.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'];
    final itemsList = rawItems is List
        ? rawItems
            .whereType<Map<String, dynamic>>()
            .map(SettingItemDto.fromJson)
            .toList()
        : <SettingItemDto>[];
    return AppSettingsDto(items: itemsList);
  }

  final List<SettingItemDto> items;
}
