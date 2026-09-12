import 'package:chauffeur_hub/core/utils/result.dart';
import '../repo/auth_repository.dart';

final class VerifyOtpUseCase {
  final AuthRepository _repository;

  const VerifyOtpUseCase(this._repository);

  Future<Result<void>> call({
    required String email,
    required int verificationId,
    required int verificationCode,
  }) {
    return _repository.verifyOtp(
      email: email,
      verificationId: verificationId,
      verificationCode: verificationCode,
    );
  }
}
