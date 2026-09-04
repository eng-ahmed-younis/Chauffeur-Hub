import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

// fetch metadata about your application from the underlying native platform
class DeviceMetadata {
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
    // Load package info, device info, and determine device form factor based on screen size
    final packageInfo = await PackageInfo.fromPlatform();
    final deviceInfo = DeviceInfoPlugin();
    // [WidgetsBinding.instance: ]Returns the active singleton instance of the widget framework environment.
    // .........................
    // [.platformDispatcher:] Provides access to platform-level features directly from the Flutter engine
    // (such as window displays, system locales, light/dark mode settings, etc.).
    // .views: Returns the list of physical app windows (FlutterView instances) attached to the device.
    final view = WidgetsBinding.instance.platformDispatcher.views.firstOrNull;
    final logicalShortestSide = view == null
        ? 0.0
        // Physical Resolution (1080 × 2400 px): The literal number of tiny glass lights on the screen. This screen is [1080 lights wide] and [2400 lights tall].
        // physicalSize.shortestSide (1080.0 px): The width of the screen when holding it normally (portrait mode). The shortest side is the width.
        // devicePixelRatio (2.75): This tells Flutter how dense the screen is. On this specific phone, a cluster of 2.75 physical pixels is bundled together
        // to represent 1 logical pixel in your Flutter code. This stops widgets from looking microscopic on high-resolution screens.
        //
        // .......................................................
        //
        // Logical Shortest Side = 1080.0 (Physical Pixels) / 2.75 (Pixel Ratio) ≈ 392.7 dp
        // The Final Result (Phone vs. Tablet)
        // In mobile app development, the industry standard rule to classify screen sizes is:
        // Less than 600 dp → It is a Phone 📱
        // 600 dp or higher → It is a Tablet default 🗺️
        // Resulting deviceType: 392.7 < 600 → 'Phone'
        : view.physicalSize.shortestSide / view.devicePixelRatio;
    final deviceType = logicalShortestSide >= 600 ? 'Tablet' : 'android';

    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      const androidId = AndroidId();
      final deviceId = await androidId.getId() ?? '';
      return DeviceMetadata(
        platformType: 'android',
        deviceType: deviceType,
        osVersion: info.version.release ?? '',
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
        deviceType: logicalShortestSide >= 600 ? 'Tablet' : 'ios',
        osVersion: info.systemVersion,
        appVersion: packageInfo.version,
        appBuildNumber: packageInfo.buildNumber,
        deviceModel: info.utsname.machine,
        deviceId: info.identifierForVendor ?? '',
      );
    }

    return DeviceMetadata(
      platformType: Platform.operatingSystem,
      deviceType: Platform.operatingSystem,
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
