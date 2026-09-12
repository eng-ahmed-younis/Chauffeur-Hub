import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/services/navigation/app_routes.dart';
import '../../../../../core/utils/extentions/theme_context_extention.dart';
import '../../../../../core/utils/ui_effect.dart';
import '../../../../../core/widgets/base_action_button.dart';
import '../../../../../core/widgets/core_error_bottom_sheet.dart';
import '../../../../../core/widgets/core_pin_code_field.dart';
import 'bloc/otp_bloc.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  final int verificationId;

  const OtpScreen({
    super.key,
    required this.email,
    required this.verificationId,
  });

  @override
  Widget build(BuildContext context) {
    return _OtpContent(
      email: email,
      verificationId: verificationId,
    );
  }
}

class _OtpContent extends StatefulWidget {
  final String email;
  final int verificationId;

  const _OtpContent({
    required this.email,
    required this.verificationId,
  });

  @override
  State<_OtpContent> createState() => _OtpContentState();
}

class _OtpContentState extends State<_OtpContent> {
  late final TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _onStateChanged(BuildContext context, OtpState state) {
    if (state.effect == UiEffect.navigate) {
      context.pushNamed(
        AppRoutes.resetPasswordPath,
        queryParameters: {
          'email': widget.email,
          'verificationId': widget.verificationId.toString(),
          'otpCode': state.otpCode,
        },
      );
    }

    if (state.effect == UiEffect.showError) {
      CoreErrorBottomSheet.show(
        context,
        title: 'Verification Failed',
        message: state.otpErrorMessage ?? 'Invalid or expired code.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final displayEmail = widget.email.isNotEmpty ? widget.email : 'Email@gen-c.com';

    return BlocConsumer<OtpBloc, OtpState>(
      listenWhen: (previous, current) =>
          previous.effectId != current.effectId || previous.isLoading != current.isLoading,
      listener: _onStateChanged,
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(AppRoutes.login);
                    }
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                title: const Text('Verification code'),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter code',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: colors.grey900Text,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Code was sent to $displayEmail',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: colors.grey800,
                        ),
                      ),
                      const SizedBox(height: 28),
                      CorePinCodeField(
                        length: state.digits,
                        controller: _otpController,
                        onChanged: (code) {
                          context.read<OtpBloc>().add(
                                OtpCodeChanged(otpCode: code),
                              );
                        },
                        errorText: state.isOtpError
                            ? (state.otpErrorMessage ?? 'Please enter valid code')
                            : null,
                      ),
                      const Spacer(),
                      Center(
                        child: _OtpTimerWidget(
                          initialSeconds: state.timer,
                          onResend: () {
                            context.read<OtpBloc>().add(
                                  const SendOtpAgain(),
                                );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      BaseActionButton(
                        text: 'Verify',
                        isLoading: false,
                        onPressed: () {
                          context.read<OtpBloc>().add(
                                VerifyOtp(
                                  otpCode: _otpController.text,
                                  verificationId: widget.verificationId,
                                ),
                              );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),

            // Full Screen Loading Overlay (Covers Scaffold + AppBar seamlessly)
            if (state.isLoading)
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withValues(alpha: 0.5),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Isolated Timer Widget so ticking every second only rebuilds the timer text
/// without rebuilding the parent widget tree or resetting TextEditingControllers.
class _OtpTimerWidget extends StatefulWidget {
  final int initialSeconds;
  final VoidCallback onResend;

  const _OtpTimerWidget({
    required this.initialSeconds,
    required this.onResend,
  });

  @override
  State<_OtpTimerWidget> createState() => _OtpTimerWidgetState();
}

class _OtpTimerWidgetState extends State<_OtpTimerWidget> {
  Timer? _timer;
  late int _secondsRemaining;

  @override
  void initState() {
    super.initState();
    _startTimer(widget.initialSeconds);
  }

  void _startTimer(int seconds) {
    _timer?.cancel();
    setState(() {
      _secondsRemaining = seconds;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _formattedTime {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _secondsRemaining == 0
              ? () {
                  _startTimer(widget.initialSeconds);
                  widget.onResend();
                }
              : null,
          child: Text(
            'Send code again',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _secondsRemaining == 0
                  ? colors.primaryBlue100
                  : colors.primaryBlue100.withValues(alpha: 0.7),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          _formattedTime,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: colors.grey600,
          ),
        ),
      ],
    );
  }
}
