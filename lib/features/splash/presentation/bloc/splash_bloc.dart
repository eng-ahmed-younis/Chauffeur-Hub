import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/network/base/error_message.dart';
import '../../../../core/shared/domain/models/driver_status.dart';
import '../../../../core/storage/session_controller.dart';
import '../../domain/models/splash_models.dart';
import '../../domain/use_case/check_app_update_use_case.dart';
import '../../domain/use_case/get_driver_status_use_case.dart';
import '../../domain/use_case/get_settings_use_case.dart';
import 'splash_event.dart';
import 'splash_state.dart';

export 'splash_event.dart';
export 'splash_state.dart';

final class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(
    this._getSettings,
    this._checkAppUpdate,
    this._getDriverStatus,
    this._session,
  ) : super(const SplashState()) {
    on<SplashStarted>(_onStarted);
    on<SplashUpdatePressed>(
      (_, emit) => emit(
        state.copyWith(
          effect: SplashEffect.openUpdateUrl,
          effectId: state.effectId + 1,
        ),
      ),
    );
    on<SplashUpdateLaterPressed>((_, emit) => _navigateAfterAuth(emit));
    on<SplashErrorDismissed>((_, emit) => _navigateAfterAuth(emit));
  }

  final GetSettingsUseCase _getSettings;
  final CheckAppUpdateUseCase _checkAppUpdate;
  final GetDriverStatusUseCase _getDriverStatus;
  final SessionController _session;

  Future<void> _onStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    Object? settingsError;
    Object? appInfoError;
    AppSettings? settings;
    AppUpdateType? updateType;

    await Future.wait([
      _getSettings()
          .then<void>((value) => settings = value)
          .catchError((Object error) {
            settingsError = error;
          }),
      _checkAppUpdate()
          .then<void>((value) => updateType = value)
          .catchError((Object error) {
            appInfoError = error;
          }),
    ]);

    settings ??= _getSettings.readCached();
    emit(
      state.copyWith(
        isLoading: false,
        settings: settings,
        updateType: updateType,
      ),
    );

    final error = appInfoError ?? settingsError;
    if (error != null) {
      emit(
        state.copyWith(
          errorMessage: readableError(error),
          effect: SplashEffect.showError,
          effectId: state.effectId + 1,
        ),
      );
      return;
    }

    if (updateType == AppUpdateType.forced ||
        updateType == AppUpdateType.optional) {
      return;
    }
    await _navigateAfterAuth(emit);
  }

  Future<void> _navigateAfterAuth(Emitter<SplashState> emit) async {
    if (!_session.isAuthenticated) {
      _navigate(emit, SplashDestination.login);
      return;
    }

    try {
      final status = await _getDriverStatus();
      _navigate(
        emit,
        status == DriverStatus.inRide
            ? SplashDestination.currentTrip
            : SplashDestination.home,
      );
    } on Object {
      _navigate(emit, SplashDestination.home);
    }
  }

  void _navigate(Emitter<SplashState> emit, SplashDestination destination) {
    emit(
      state.copyWith(
        destination: destination,
        updateType: null,
        effect: SplashEffect.navigate,
        effectId: state.effectId + 1,
      ),
    );
  }
}
