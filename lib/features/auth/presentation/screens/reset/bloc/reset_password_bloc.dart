import 'package:chauffeur_hub/features/auth/presentation/screens/reset/bloc/reset_password_event.dart';
import 'package:chauffeur_hub/features/auth/presentation/screens/reset/bloc/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



final class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState>{

  ResetPasswordBloc() : super(const ResetPasswordState()) {
    on<ResetPasswordSubmitted>(_onPasswordChanged);
  }

  void _onPasswordChanged(ResetPasswordSubmitted event, Emitter<ResetPasswordState> emit) {

  }

}

