import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chauffeur_hub/core/utils/result.dart';
import 'package:chauffeur_hub/core/utils/ui_effect.dart';
import 'package:chauffeur_hub/core/utils/validators.dart';
import '../../../../domain/usecases/forget_password_use_case.dart';
import 'forget_event.dart';
import 'forget_state.dart';

class ForgetBloc extends Bloc<ForgetEvent, ForgetState> {
  ForgetBloc({
    required this._forgetPasswordUseCase,
  })  : super(const ForgetState()) {
    on<OnEmailChanged>(_onEmailChanged);
    on<SendOtp>(_onSendOtpSubmitted);
  }

  final ForgetPasswordUseCase _forgetPasswordUseCase;

  void _onEmailChanged(OnEmailChanged event, Emitter<ForgetState> emit) {
    final isInvalid = event.email.isNotEmpty && !isValidEmail(event.email);
    emit(
      state.copyWith(
        email: event.email,
        isEmailError: isInvalid,
        emailErrorMessage: isInvalid ? 'Please enter a valid email' : null,
        status: ForgetPassStatus.initial,
      ),
    );
  }

  Future<void> _onSendOtpSubmitted(
    SendOtp event,
    Emitter<ForgetState> emit,
  ) async {
    final emailToValidate = event.email.isNotEmpty ? event.email : state.email;
    final validEmail = emailToValidate.isNotEmpty && isValidEmail(emailToValidate);

    if (!validEmail) {
      emit(
        state.copyWith(
          isEmailError: true,
          emailErrorMessage: 'Please enter a valid email',
          status: ForgetPassStatus.failure,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isLoading: true,
        status: ForgetPassStatus.loading,
      ),
    );

    final result = await _forgetPasswordUseCase.forgetPasswordRequest(emailToValidate);

    switch (result) {
      case Failure():
        emit(
          state.copyWith(
            isLoading: false,
            status: ForgetPassStatus.failure,
            effect: UiEffect.showError,
            effectId: state.effectId + 1,
          ),
        );
      case Success(:final data):
        emit(
          state.copyWith(
            isLoading: false,
            status: ForgetPassStatus.success,
            verificationId: data.verificationId,
            destination: ForgetPasswordDestination.otp,
            effect: UiEffect.navigate,
            effectId: state.effectId + 1,
          ),
        );
    }
  }
}
