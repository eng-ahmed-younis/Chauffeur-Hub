import 'package:chauffeur_hub/core/utils/result.dart';
import 'package:flutter/material.dart';

import '../models/forget_password.dart';
import '../repo/auth_repository.dart';


final class ForgetPasswordUseCase{
  final AuthRepository _authRepository;

  ForgetPasswordUseCase({required this._authRepository});

  Future<Result<ForgetPassword>> forgetPasswordRequest(String email) {
    return _authRepository.forgetPasswordRequest(email);
  }
}