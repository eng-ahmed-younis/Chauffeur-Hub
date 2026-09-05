enum AppUpdateType { forced, optional, noUpdate }

extension AppUpdateTypeParser on AppUpdateType {
  static AppUpdateType fromWire(String? value) => switch (value) {
        'forced' || 'force' => AppUpdateType.forced,
        'optional' || 'option' => AppUpdateType.optional,
        'no_update' || 'noUpdate' || 'none' => AppUpdateType.noUpdate,
        _ => AppUpdateType.noUpdate,
      };
}
