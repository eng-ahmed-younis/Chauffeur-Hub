import 'package:chauffeur_hub/core/utils/result.dart';
import '../../../../core/shared/request/otp_request.dart';
import '../repo/auth_repository.dart';

final class VerifyOtpUseCase {

  const VerifyOtpUseCase(this._repository);
  final AuthRepository _repository;

  Future<Result<void>> call({
    required OtpRequest otpRequest,
  }) {
    return _repository.verifyOtp(otpRequest: otpRequest);
  }
}

