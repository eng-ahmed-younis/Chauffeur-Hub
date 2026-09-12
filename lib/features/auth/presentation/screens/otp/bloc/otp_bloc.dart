import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chauffeur_hub/core/utils/result.dart';
import 'package:chauffeur_hub/core/utils/ui_effect.dart';
import '../../../../domain/usecases/forget_password_use_case.dart';
import '../../../../domain/usecases/verify_otp_use_case.dart';
import 'otp_event.dart';
import 'otp_state.dart';

export 'otp_event.dart';
export 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc({
    required this._verifyOtpUseCase,
    required this._forgetPasswordUseCase,
  })  : super(const OtpState()) {
    on<OtpEmailChanged>(_onEmailChanged);
    on<OtpCodeChanged>(_onOtpCodeChanged);
    on<VerifyOtp>(_onVerifyOtpSubmitted);
    on<SendOtpAgain>(_onSendOtpAgain);
  }

  final VerifyOtpUseCase _verifyOtpUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;

  void _onEmailChanged(OtpEmailChanged event, Emitter<OtpState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onOtpCodeChanged(OtpCodeChanged event, Emitter<OtpState> emit) {
    emit(
      state.copyWith(
        otpCode: event.otpCode,
        isOtpError: false,
        otpErrorMessage: null,
      ),
    );
  }

  Future<void> _onVerifyOtpSubmitted(
    VerifyOtp event,
    Emitter<OtpState> emit,
  ) async {
    final codeString = event.otpCode.isNotEmpty ? event.otpCode : state.otpCode;
    if (codeString.length < state.digits) {
      emit(
        state.copyWith(
          isOtpError: true,
          otpErrorMessage: 'Please enter all ${state.digits} digits.',
        ),
      );
      return;
    }

    final parsedCode = int.tryParse(codeString);
    if (parsedCode == null) {
      emit(
        state.copyWith(
          isOtpError: true,
          otpErrorMessage: 'Invalid verification code format.',
        ),
      );
      return;
    }

    emit(state.copyWith(isLoading: true, isOtpError: false, otpErrorMessage: null));

    final result = await _verifyOtpUseCase(
      email: state.email,
      verificationId: event.verificationId,
      verificationCode: parsedCode,
    );

    switch (result) {
      case Failure(:final error):
        emit(
          state.copyWith(
            isLoading: false,
            isOtpError: true,
            otpErrorMessage: error.message,
            effect: UiEffect.showError,
            effectId: state.effectId + 1,
          ),
        );
      case Success():
        emit(
          state.copyWith(
            isLoading: false,
            otpCode: codeString,
            effect: UiEffect.navigate,
            effectId: state.effectId + 1,
          ),
        );
    }
  }

  Future<void> _onSendOtpAgain(
    SendOtpAgain event,
    Emitter<OtpState> emit,
  ) async {
    if (state.email.isEmpty) return;

    emit(state.copyWith(isLoading: true));

    final result = await _forgetPasswordUseCase.forgetPasswordRequest(state.email);

    switch (result) {
      case Failure():
        emit(
          state.copyWith(
            isLoading: false,
            effect: UiEffect.showError,
            effectId: state.effectId + 1,
          ),
        );
      case Success(:final data):
        emit(
          state.copyWith(
            isLoading: false,
            verificationId: data.verificationId,
            timer: 30,
          ),
        );
    }
  }
}
