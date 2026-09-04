import 'package:equatable/equatable.dart';

import '../../data/models/app_info.dart';
import '../../data/models/app_settings.dart';

/// State object representing the UI state for the Splash screen.
///
/// Holds immutable properties for initialization status, app settings, version update checks, and errors.
class SplashState extends Equatable {
  /// Default constructor for [SplashState].
  const SplashState({
    this.isLoading = false,
    this.settings,
    this.appInfo,
    this.errorMessage,
    this.isForceUpdate,
  });

  /// Indicates whether the app startup initialization is in progress.
  final bool isLoading;

  /// System settings loaded from backend during app launch.
  final AppSettings? settings;

  /// Application version and update metadata.
  final AppInfo? appInfo;

  /// Human-readable error message if initialization fails.
  final String? errorMessage;

  /// Flags whether a critical force update is required before using the app.
  final bool? isForceUpdate;

  /// Creates a copy of [SplashState] with updated field values.
  SplashState copyWith({
    bool? isLoading,
    AppSettings? settings,
    AppInfo? appInfo,
    String? errorMessage,
    bool? isForceUpdate,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      settings: settings ?? this.settings,
      appInfo: appInfo ?? this.appInfo,
      errorMessage: errorMessage ?? this.errorMessage,
      isForceUpdate: isForceUpdate ?? this.isForceUpdate,
    );
  }


  //This ensures BlocBuilder and BlocListener will only trigger rebuilds when one of these
  // properties actually changes. Let me know if you need any additional adjustments!
  @override
  List<Object?> get props => [
        isLoading,
        settings,
        appInfo,
        errorMessage,
        isForceUpdate,
      ];
}
