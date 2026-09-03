abstract final class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const forgotPassword = '/forgot_password';
  static const home = '/home';
  static const currentTrip = '/current_trip';
  static const rateRide = '/rate_ride';
  static const privacyPolicy = '/privacy_policy';

  // Public path constants are used only when declaring GoRouter routes.
  // Screens should use the typed navigation extension methods instead.
  static const inspectionPath = '/inspection';
  static const otpPath = '/otp';
  static const resetPasswordPath = '/reset_password';

  static bool isAuthPath(String path) =>
      path == login ||
      path == forgotPassword ||
      path == otpPath ||
      path == resetPasswordPath;

  static bool isProtectedPath(String path) =>
      path == home ||
      path == currentTrip ||
      path == rateRide ||
      path == inspectionPath ||
      path == privacyPolicy;

  // Normal path + query params (type-safe compile checks)
  static String inspection({
    required String assetNumber,
    required String inspectionId,
    required String inspectionType,
  }) => Uri(
    path: inspectionPath,
    queryParameters: {
      'assetNumber': assetNumber,
      'inspectionId': inspectionId,
      'inspectionType': inspectionType,
    },
  ).toString();
}
