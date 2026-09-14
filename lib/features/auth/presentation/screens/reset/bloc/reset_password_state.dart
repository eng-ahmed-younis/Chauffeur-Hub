import 'package:chauffeur_hub/core/utils/ui_effect.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/utils/default_values.dart';

enum ResetPasswordStatus { initial, loading, success, failure }

enum ResetDestination { login }

final class ResetPasswordState extends Equatable {

  const ResetPasswordState({
    this.password = DefaultValues.string,
    this.confirmPassword = DefaultValues.string,
    this.confirmationError = DefaultValues.integer,
    this.passwordError = DefaultValues.integer,
    this.status = ResetPasswordStatus.initial,
    this.errorMessage = DefaultValues.string,
    this.effect = UiEffect.none,
    this.effectId = DefaultValues.integer,
    this.destination,
  });
  final String password;
  final String confirmPassword;
  final int confirmationError;
  final int passwordError;
  final ResetPasswordStatus status;
  final String errorMessage;
  final UiEffect effect;
  final ResetDestination? destination;
  final int effectId;

  ResetPasswordState copyWith({
    String? password,
    String? confirmPassword,
    int? confirmationError,
    int? passwordError,
    ResetPasswordStatus? status,
    String? errorMessage,
    UiEffect? effect,
    int? effectId,
    ResetDestination? destination,
  }) {
    return ResetPasswordState(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      confirmationError: confirmationError ?? this.confirmationError,
      passwordError: passwordError ?? this.passwordError,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      effect: effect ?? this.effect,
      effectId: effectId ?? this.effectId,
      destination: destination ?? this.destination,
    );
  }

  @override
  List<Object?> get props => [
        password,
        confirmPassword,
        confirmationError,
        passwordError,
        status,
        errorMessage,
        effect,
        effectId,
        destination,
      ];
}
