import '../../domain/models/splash_models.dart';

enum SplashDestination { login, home, currentTrip }

enum SplashEffect { none, navigate, showError, openUpdateUrl }

final class SplashState {
  const SplashState({
    this.isLoading = true,
    this.settings,
    this.updateType,
    this.destination,
    this.errorMessage = '',
    this.effect = SplashEffect.none,
    this.effectId = 0,
  });

  final bool isLoading;
  final AppSettings? settings;
  final AppUpdateType? updateType;
  final SplashDestination? destination;
  final String errorMessage;
  final SplashEffect effect;
  final int effectId;

  SplashState copyWith({
    bool? isLoading,
    AppSettings? settings,
    AppUpdateType? updateType,
    SplashDestination? destination,
    String? errorMessage,
    SplashEffect? effect,
    int? effectId,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      settings: settings ?? this.settings,
      updateType: updateType ?? this.updateType,
      destination: destination ?? this.destination,
      errorMessage: errorMessage ?? this.errorMessage,
      effect: effect ?? this.effect,
      effectId: effectId ?? this.effectId,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SplashState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          settings == other.settings &&
          updateType == other.updateType &&
          destination == other.destination &&
          errorMessage == other.errorMessage &&
          effect == other.effect &&
          effectId == other.effectId;

  @override
  int get hashCode =>
      isLoading.hashCode ^
      settings.hashCode ^
      updateType.hashCode ^
      destination.hashCode ^
      errorMessage.hashCode ^
      effect.hashCode ^
      effectId.hashCode;
}
