import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/services/navigation/app_routes.dart';
import 'bloc/reset_password_state.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ResetPasswordContent();
  }
}

class _ResetPasswordContent extends StatelessWidget {
  const _ResetPasswordContent();

  void _onStateChanged(BuildContext context, ResetPasswordState state) {
    if (state.effect == ResetPasswordEffect.navigate && state.destination != null) {
      switch(state.destination) {
        case ResetDestination.login: {
          context.go(AppRoutes.login);
          return;
        }
        default: null;
          return;
      }
    }
  }





  @override
  Widget build(BuildContext context) {

    return Scaffold(

    );
  }





}



