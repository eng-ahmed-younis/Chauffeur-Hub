import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Fetches platform and device metadata for HTTP headers & analytics.
final class DeviceMetadata {
  const DeviceMetadata({
    required this.platformType,
    required this.deviceType,
    required this.osVersion,
    required this.appVersion,
    required this.appBuildNumber,
    required this.deviceModel,
    required this.deviceId,
  });

  static Future<DeviceMetadata> load() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final deviceInfo = DeviceInfoPlugin();

    final view = WidgetsBinding.instance.platformDispatcher.views.firstOrNull;
    final logicalShortestSide = view == null
        ? 0.0
        : view.physicalSize.shortestSide / view.devicePixelRatio;

    final deviceType = logicalShortestSide >= 600 ? 'Tablet' : 'Phone';

    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      const deviceChannel = MethodChannel('chauffeur_hub/device');
      final deviceId =
          await deviceChannel.invokeMethod<String>('getAndroidId') ?? '';
      return DeviceMetadata(
        platformType: 'android',
        deviceType: deviceType,
        osVersion: info.version.release,
        appVersion: packageInfo.version,
        appBuildNumber: packageInfo.buildNumber,
        deviceModel: info.model,
        deviceId: deviceId,
      );
    }

    if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return DeviceMetadata(
        platformType: 'ios',
        deviceType: logicalShortestSide >= 600 ? 'Tablet' : 'Phone',
        osVersion: info.systemVersion,
        appVersion: packageInfo.version,
        appBuildNumber: packageInfo.buildNumber,
        deviceModel: info.utsname.machine,
        deviceId: info.identifierForVendor ?? '',
      );
    }

    return DeviceMetadata(
      platformType: Platform.operatingSystem,
      deviceType: deviceType,
      osVersion: Platform.operatingSystemVersion,
      appVersion: packageInfo.version,
      appBuildNumber: packageInfo.buildNumber,
      deviceModel: Platform.localHostname,
      deviceId: Platform.localHostname,
    );
  }

  final String platformType;
  final String deviceType;
  final String osVersion;
  final String appVersion;
  final String appBuildNumber;
  final String deviceModel;
  final String deviceId;
}
