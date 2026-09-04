import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/di/service_locator.dart';
import '../../../../core/storage/session_controller.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({SessionController? sessionController})
      : _sessionController =
            sessionController ?? serviceLocator<SessionController>(),
        super(const SplashState()) {
    on<SplashInitializeRequested>(_onInitializeRequested);
  }

  final SessionController _sessionController;

  Future<void> _onInitializeRequested(
    SplashInitializeRequested event,
    Emitter<SplashState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      await Future.wait([
        _sessionController.restore(),
        Future.delayed(const Duration(milliseconds: 2000)),
      ]);

      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }
}
