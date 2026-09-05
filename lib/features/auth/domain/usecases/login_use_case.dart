import 'package:chauffeur_hub/core/utils/result.dart';
import 'package:chauffeur_hub/features/auth/domain/models/login_driver.dart';
import 'package:chauffeur_hub/features/auth/domain/repo/auth_repository.dart';

final class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<LoginDriver>> call({
    required String email,
    required String password,
    required String deviceToken,
  }) async {
    return _repository.login(
      email: email,
      password: password,
      deviceToken: deviceToken,
    );
  }
}
