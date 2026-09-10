import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forget_event.dart';
import 'forget_state.dart';



class ForgetBloc extends Bloc<ForgetEvent, ForgetState>{

  ForgetBloc() : super(const ForgetState()) {
    on<ForgetEvent>(_onForgetSubmitted);
  }

  void _onForgetSubmitted(ForgetEvent event, Emitter<ForgetState> emit) {

  }


}