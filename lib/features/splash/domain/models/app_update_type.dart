enum AppUpdateType { forced, optional, noUpdate }

extension AppUpdateTypeParser on AppUpdateType {
  static AppUpdateType fromWire(String? value) => switch (value) {
        'forced' => AppUpdateType.forced,
        'optional' => AppUpdateType.optional,
        _ => AppUpdateType.noUpdate,
      };
}
