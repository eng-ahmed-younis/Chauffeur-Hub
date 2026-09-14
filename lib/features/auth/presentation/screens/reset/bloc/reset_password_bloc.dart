import 'package:chauffeur_hub/core/shared/request/reset_password.dart';
import 'package:chauffeur_hub/core/utils/result.dart';
import 'package:chauffeur_hub/core/utils/ui_effect.dart';
import 'package:chauffeur_hub/features/auth/domain/usecases/forget_password_use_case.dart';
import 'package:chauffeur_hub/features/auth/presentation/screens/reset/bloc/reset_password_event.dart';
import 'package:chauffeur_hub/features/auth/presentation/screens/reset/bloc/reset_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc({
    required this._forgetPasswordUseCase,
  })  : super(const ResetPasswordState()) {
    on<ResetPasswordSubmitted>(_onResetPasswordSubmitted);
  }

  final ForgetPasswordUseCase _forgetPasswordUseCase;

  Future<void> _onResetPasswordSubmitted(
    ResetPasswordSubmitted event,
    Emitter<ResetPasswordState> emit,
  ) async {
    if (event.password.isEmpty || event.confirmPassword.isEmpty) {
      emit(
        state.copyWith(
          status: ResetPasswordStatus.failure,
          errorMessage: 'Please enter both password fields.',
          effect: UiEffect.showError,
          effectId: state.effectId + 1,
        ),
      );
      return;
    }

    if (event.password != event.confirmPassword) {
      emit(
        state.copyWith(
          status: ResetPasswordStatus.failure,
          errorMessage: 'Passwords do not match.',
          effect: UiEffect.showError,
          effectId: state.effectId + 1,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: ResetPasswordStatus.loading,
      ),
    );

    final result = await _forgetPasswordUseCase.resetPassword(
      request: ResetPassword(
        email: event.email,
        otpCode: event.otpCode,
        verificationId: event.verificationId,
        password: event.password,
        confirmPassword: event.confirmPassword,
      ),
    );

    switch (result) {
      case Failure(:final error):
        emit(
          state.copyWith(
            status: ResetPasswordStatus.failure,
            errorMessage: error.message,
            effect: UiEffect.showError,
            effectId: state.effectId + 1,
          ),
        );
      case Success():
        emit(
          state.copyWith(
            status: ResetPasswordStatus.success,
            destination: ResetDestination.login,
            effect: UiEffect.navigate,
            effectId: state.effectId + 1,
          ),
        );
    }
  }
}
