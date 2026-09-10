import 'package:flutter/material.dart';


sealed class  ResetPasswordEvent {
  const ResetPasswordEvent();
  const factory ResetPasswordEvent.passwordChanged({required String password, required String confirmPassword}) =
      ResetPasswordSubmitted;

}

final class ResetPasswordSubmitted extends ResetPasswordEvent {
  const ResetPasswordSubmitted({required this.password, required this.confirmPassword});
  final String password;
  final String confirmPassword;
}


