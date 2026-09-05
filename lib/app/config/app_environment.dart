import '../../core/services/logger/app_logger.dart';
import 'app_flavor.dart';

/// AppEnvironment (Public): The final, complete configuration object used across your whole app.
/// It combines hardcoded defaults, command-line overrides (--dart-define), formats URLs (adding `https://`), and holds API keys.
final class AppEnvironment {
  const AppEnvironment({
    required this.flavor,
    required this.chauffeurBaseUrl,
    required this.settingsBaseUrl,
    required this.notificationsBaseUrl,
    required this.apexBaseUrl,
    required this.socketUrl,
    required this.firebaseStorageBucket,
    required this.chauffeurApiKey,
    required this.apexApiKey,
    required this.privacyPolicyUrl,
    required this.updateUrl,
    required this.googleClientId,
    required this.mapsApiKey,
    required this.googleDirectionsKey,
    required this.googlePlacesApiKey,
  });

  factory AppEnvironment.fromDefines([AppFlavor? targetFlavor]) {
    const rawFlavor = String.fromEnvironment(
      'APP_FLAVOR',
      defaultValue: '',
    );

    AppLogger.info('APP_FLAVOR', 'Raw flavor: "$rawFlavor"');

    final flavor = targetFlavor ??
        AppFlavor.values.firstWhere(
          (appFlavor) => appFlavor.name == rawFlavor,
          orElse: () => AppFlavor.dev,
        );

    AppLogger.info('APP_FLAVOR', 'Loaded environment flavor: ${flavor.name.toUpperCase()}');

    final defaults = switch (flavor) {
      AppFlavor.dev => const _EnvironmentDefaults(
        chauffeurHost: 'core-cf-uat.shiftinc.com',
        settingsHost: 'set-cf-uat.shiftinc.com',
        notificationsHost: 'ntf-uat.shiftinc.com',
        apexHost: 'api-uat-cs-apex.shiftinc.com',
        socketUrl: 'https://ws-uat-cf.shiftinc.com/',
        firebaseStorageBucket: 'gs://shift-uat-cf',
      ),
      AppFlavor.staging => const _EnvironmentDefaults(
        chauffeurHost: 'core-cf-dvlp.shiftinc.com',
        settingsHost: 'set-cf-dvlp.shiftinc.com',
        notificationsHost: 'ntf-dvlp.shiftinc.com',
        apexHost: 'api-dvlp-cs-apex.shiftinc.com',
        socketUrl: 'https://ws-dvlp-cf.shiftinc.com/',
        firebaseStorageBucket: 'gs://shift-dvlp-cf',
      ),
      AppFlavor.uat => const _EnvironmentDefaults(
        chauffeurHost: 'core-cf-uat.shiftinc.com',
        settingsHost: 'set-cf-uat.shiftinc.com',
        notificationsHost: 'ntf-uat.shiftinc.com',
        apexHost: 'api-uat-cs-apex.shiftinc.com',
        socketUrl: 'https://ws-uat-cf.shiftinc.com/',
        firebaseStorageBucket: 'gs://shift-uat-cf',
      ),
      AppFlavor.prod => const _EnvironmentDefaults(
        chauffeurHost: 'core-cf-ms.shiftinc.com',
        settingsHost: 'set-cf-ms.shiftinc.com',
        notificationsHost: 'ntf-ms.shiftinc.com',
        apexHost: 'api-uat-cs-apex.shiftinc.com',
        socketUrl: 'https://ws-cf-ms.shiftinc.com/',
        firebaseStorageBucket: 'gs://shift-cf',
      ),
    };

    const apexOverride = String.fromEnvironment('APEX_BASE_URL');
    final apexHost = _normaliseHost(
      apexOverride.isEmpty ? defaults.apexHost : apexOverride,
    );

    return AppEnvironment(
      flavor: flavor,
      chauffeurBaseUrl: _https(defaults.chauffeurHost),
      settingsBaseUrl: _https(defaults.settingsHost),
      notificationsBaseUrl: _https(defaults.notificationsHost),
      apexBaseUrl: _https(apexHost),
      socketUrl: defaults.socketUrl,
      firebaseStorageBucket: defaults.firebaseStorageBucket,
      chauffeurApiKey: const String.fromEnvironment('API_KEY_CHAUFFEUR'),
      apexApiKey: const String.fromEnvironment('API_KEY_APEX'),
      privacyPolicyUrl: 'https://api-cs.shiftinc.com/v4/api/LANG/privacy',
      updateUrl:
          'https://play.google.com/store/apps/details?id=com.shift.chauffeur.driver',
      googleClientId: const String.fromEnvironment('GOOGLE_CLIENT_ID'),
      mapsApiKey: const String.fromEnvironment('MAPS_API_KEY'),
      googleDirectionsKey: const String.fromEnvironment('GOOGLE_DIRECTIONS_KEY'),
      googlePlacesApiKey: const String.fromEnvironment('GOOGLE_PLACES_API_KEY'),
    );
  }

  final AppFlavor flavor;
  final String chauffeurBaseUrl;
  final String settingsBaseUrl;
  final String notificationsBaseUrl;
  final String apexBaseUrl;
  final String socketUrl;
  final String firebaseStorageBucket;
  final String chauffeurApiKey;
  final String apexApiKey;
  final String privacyPolicyUrl;
  final String updateUrl;
  final String googleClientId;
  final String mapsApiKey;
  final String googleDirectionsKey;
  final String googlePlacesApiKey;

  bool get isProduction => flavor == AppFlavor.prod;

  static String _https(String host) => host.isEmpty ? '' : 'https://$host/';

  static String _normaliseHost(String value) => value
      .trim()
      .replaceFirst(RegExp(r'^https?://'), '')
      .replaceFirst(RegExp(r'/$'), '');
}

/// _EnvironmentDefaults (Private): A private internal helper class (starts with _)
/// that simply holds hardcoded default domain hostnames for each flavor (dev, staging, uat, prod).
final class _EnvironmentDefaults {
  const _EnvironmentDefaults({
    required this.chauffeurHost,
    required this.settingsHost,
    required this.notificationsHost,
    required this.apexHost,
    required this.socketUrl,
    required this.firebaseStorageBucket,

  });

  final String chauffeurHost;
  final String settingsHost;
  final String notificationsHost;
  final String apexHost;
  final String socketUrl;
  final String firebaseStorageBucket;
}
