import 'dart:async';

import 'splash_event.dart';
import 'splash_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/splash_models.dart';
import '../../../../core/storage/session_controller.dart';
import '../../domain/use_case/get_settings_use_case.dart';
import '../../domain/use_case/check_app_update_use_case.dart';
import '../../domain/use_case/get_driver_status_use_case.dart';
import '../../../../core/shared/domain/models/driver_status.dart';
import '../../../../core/services/network/base/error_message.dart';

import 'package:chauffeur_hub/core/services/notification/fcm_service.dart';
import 'package:chauffeur_hub/core/storage/session_store.dart';

export 'splash_event.dart';
export 'splash_state.dart';

final class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({
    required this.getSettingsUseCase,
    required this.checkAppUpdateUseCase,
    required this.getDriverStatusUseCase,
    required this.session,
    required this.fcmService,
    required this.store,
  }) : super(const SplashState()) {
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

  final GetSettingsUseCase getSettingsUseCase;
  final CheckAppUpdateUseCase checkAppUpdateUseCase;
  final GetDriverStatusUseCase getDriverStatusUseCase;
  final SessionController session;
  final FcmService fcmService;
  final SessionStore store;

  Future<void> _onStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // Fetch and save FCM Token asynchronously in SessionStore on splash screen
    fcmService.getFcmToken().then((token) {
      if (token != null && token.isNotEmpty) {
        store.saveFcmToken(token);
      }
    }).catchError((_) {});

    // 1. Fast local session restoration (< 10ms)
    await session.restore();

    // 2. If user is not authenticated, navigate to Login immediately without waiting for network!
    if (!session.isAuthenticated) {
      emit(state.copyWith(isLoading: false));
      _navigate(emit, SplashDestination.login);
      return;
    }

    // 3. For logged-in users, run update & settings checks with a short 1.5s timeout
    Object? settingsError;
    Object? appInfoError;
    AppSettings? settings;
    AppUpdateType? updateType;

    await Future.wait([
      getSettingsUseCase()
          .then<void>((value) {
            settings = value;
            updateType = AppUpdateType.noUpdate;
          })
          .catchError((Object error) {
            settingsError = error;
          }),

      checkAppUpdateUseCase()
          .then<void>((value) => updateType = value)
          .catchError((Object error) {
            appInfoError = error;
          }),
    ]).timeout(const Duration(milliseconds: 1500), onTimeout: () => <void>[]);

    settings ??= getSettingsUseCase.readCached();

    emit(
      state.copyWith(
        isLoading: false,
        settings: settings,
        updateType: updateType,
      ),
    );

    final error = appInfoError ?? settingsError;
    if (error != null && settings == null) {
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
    if (!session.isAuthenticated) {
      _navigate(emit, SplashDestination.login);
      return;
    }
    // If the user is authenticated, we check their driver status to determine the appropriate navigation destination.

    try {
      final status = await getDriverStatusUseCase().timeout(
        const Duration(seconds: 5),
      );
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
    session.markReady();
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
