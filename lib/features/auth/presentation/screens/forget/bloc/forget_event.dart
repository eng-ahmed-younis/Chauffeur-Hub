import 'package:flutter/material.dart';

enum ForgetPasswordDestination { login, otp }

enum ForgetPasswordEffect { none, navigate, showError }

sealed class ForgetEvent {
  const ForgetEvent();

  const factory ForgetEvent.sendOtp({required String email}) = SendOtp;
}

class SendOtp extends ForgetEvent {
  const SendOtp({required this.email});

  final String email;
}
