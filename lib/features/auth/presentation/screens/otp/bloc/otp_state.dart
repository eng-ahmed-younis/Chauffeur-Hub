import 'package:equatable/equatable.dart';
import 'package:chauffeur_hub/core/utils/ui_effect.dart';
import '../../../../../../core/utils/default_values.dart';

final class OtpState extends Equatable {
  final String email;
  final String otpCode;
  final int verificationId;
  final String? otpErrorMessage;
  final bool isOtpError;
  final bool isLoading;
  final int digits;
  final int timer;
  final UiEffect effect;
  final int effectId;

  const OtpState({
    this.email = DefaultValues.string,
    this.otpCode = DefaultValues.string,
    this.verificationId = DefaultValues.integer,
    this.otpErrorMessage,
    this.isOtpError = DefaultValues.boolean,
    this.isLoading = DefaultValues.boolean,
    this.digits = 6,
    this.timer = 30,
    this.effect = UiEffect.none,
    this.effectId = DefaultValues.integer,
  });

  OtpState copyWith({
    String? email,
    String? otpCode,
    int? verificationId,
    String? otpErrorMessage,
    bool? isOtpError,
    bool? isLoading,
    int? digits,
    int? timer,
    UiEffect? effect,
    int? effectId,
  }) {
    return OtpState(
      email: email ?? this.email,
      otpCode: otpCode ?? this.otpCode,
      verificationId: verificationId ?? this.verificationId,
      otpErrorMessage: otpErrorMessage ?? this.otpErrorMessage,
      isOtpError: isOtpError ?? this.isOtpError,
      isLoading: isLoading ?? this.isLoading,
      digits: digits ?? this.digits,
      timer: timer ?? this.timer,
      effect: effect ?? this.effect,
      effectId: effectId ?? this.effectId,
    );
  }

  @override
  List<Object?> get props => [
        email,
        otpCode,
        verificationId,
        otpErrorMessage,
        isOtpError,
        isLoading,
        digits,
        timer,
        effect,
        effectId,
      ];
}
