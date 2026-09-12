import 'package:equatable/equatable.dart';
import 'package:chauffeur_hub/core/utils/ui_effect.dart';
import '../../../../../../core/utils/default_values.dart';
import 'forget_event.dart';

enum ForgetPassStatus { initial, loading, success, failure }

final class ForgetState extends Equatable {
  final String email;
  final bool isEmailError;
  final String? emailErrorMessage;
  final bool isLoading;
  final int verificationId;
  final UiEffect effect;
  final ForgetPasswordDestination? destination;
  final ForgetPassStatus status;
  final int effectId;

  const ForgetState({
    this.email = DefaultValues.string,
    this.isEmailError = DefaultValues.boolean,
    this.emailErrorMessage,
    this.isLoading = DefaultValues.boolean,
    this.verificationId = DefaultValues.integer,
    this.effect = UiEffect.none,
    this.destination,
    this.status = ForgetPassStatus.initial,
    this.effectId = DefaultValues.integer,
  });

  ForgetState copyWith({
    String? email,
    bool? isEmailError,
    String? emailErrorMessage,
    bool? isLoading,
    int? verificationId,
    UiEffect? effect,
    ForgetPasswordDestination? destination,
    ForgetPassStatus? status,
    int? effectId,
  }) {
    return ForgetState(
      email: email ?? this.email,
      isEmailError: isEmailError ?? this.isEmailError,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      isLoading: isLoading ?? this.isLoading,
      verificationId: verificationId ?? this.verificationId,
      effect: effect ?? this.effect,
      destination: destination ?? this.destination,
      effectId: effectId ?? this.effectId,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        email,
        isEmailError,
        emailErrorMessage,
        isLoading,
        verificationId,
        effect,
        destination,
        effectId,
        status,
      ];
}
