import 'package:equatable/equatable.dart';

import 'app_update_type.dart';

final class AppInfo extends Equatable {
  const AppInfo({
    this.appVersion,
    this.buildNumber,
    this.updateType = AppUpdateType.noUpdate,
    this.updateUrl,
  });

  final String? appVersion;
  final String? buildNumber;
  final AppUpdateType updateType;
  final String? updateUrl;

  AppInfo copyWith({
    String? appVersion,
    String? buildNumber,
    AppUpdateType? updateType,
    String? updateUrl,
  }) {
    return AppInfo(
      appVersion: appVersion ?? this.appVersion,
      buildNumber: buildNumber ?? this.buildNumber,
      updateType: updateType ?? this.updateType,
      updateUrl: updateUrl ?? this.updateUrl,
    );
  }

  @override
  List<Object?> get props => [appVersion, buildNumber, updateType, updateUrl];
}
