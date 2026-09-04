import '../../domain/models/splash_models.dart';
import '../dto/app_settings_dto.dart';
import 'setting_item_mapper.dart';

extension AppSettingsMapper on AppSettingsDto {
  AppSettings toDomain() =>
      AppSettings(items: items.map((item) => item.toDomain()).toList());
}
