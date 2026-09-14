import 'package:chauffeur_hub/core/utils/result.dart';

import '../../../../core/shared/request/reset_password.dart';
import '../models/forget_password.dart';
import '../repo/auth_repository.dart';

final class ForgetPasswordUseCase {
  ForgetPasswordUseCase({required this._authRepository});

  final AuthRepository _authRepository;

  Future<Result<ForgetPassword>> forgetPasswordRequest(String email) {
    return _authRepository.forgetPasswordRequest(email);
  }

  Future<Result<ForgetPassword>> resetPassword({
    required ResetPassword request,
  }) {
    return _authRepository.resetPassword(request: request);
  }
}
