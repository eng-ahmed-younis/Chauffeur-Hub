import '../../domain/models/splash_models.dart';
import '../dto/setting_item_dto.dart';

extension SettingItemMapper on SettingItemDto {
  SettingItem toDomain() => SettingItem(
        id: id,
        name: name,
        code: code,
        value: value,
        defaultValue: defaultValue,
        type: type,
        unit: unit,
        unitDescription: unitDescription,
      );
}
