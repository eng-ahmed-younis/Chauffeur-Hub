import 'package:chauffeur_hub/core/utils/ui_effect.dart';

enum ForgetPasswordDestination { login, otp  }

sealed class ForgetEvent {
  const ForgetEvent();

  const factory ForgetEvent.sendOtp({required String email}) = SendOtp;
  const factory ForgetEvent.onEmailChanged({required String email}) = OnEmailChanged;
}

class SendOtp extends ForgetEvent {
  const SendOtp({required this.email});

  final String email;
}


class OnEmailChanged extends ForgetEvent {
  const OnEmailChanged({required this.email});
  final String email;
}