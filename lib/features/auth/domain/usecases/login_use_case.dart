import 'package:chauffeur_hub/core/utils/result.dart';
import 'package:chauffeur_hub/core/storage/session_controller.dart';
import 'package:chauffeur_hub/core/services/network/base/api_exception.dart';
import 'package:chauffeur_hub/features/auth/domain/models/login_driver.dart';
import 'package:chauffeur_hub/features/auth/domain/repo/auth_repository.dart';

final class LoginUseCase {
  const LoginUseCase({
    required this._repository,
    required this._sessionController,
  });

  final AuthRepository _repository;
  final SessionController _sessionController;

  Future<Result<LoginDriver>> call({
    required String email,
    required String password,
    required String deviceToken,
  }) async {
    Future<Result<LoginDriver>> establishSession(LoginDriver driver) async {
      if (driver.token.trim().isEmpty) {
        return Result.failure(
          const ApiException.unauthorized(
            'Login response contained no token.',
          ),
        );
      }

      final fullName = [
        driver.firstName,
        driver.lastName,
      ]
          .whereType<String>()
          .where((name) => name.trim().isNotEmpty)
          .join(' ');

      await _sessionController.establish(
        token: driver.token,
        accountCode: driver.accountCode,
        driverName: fullName,
      );

      return Result.success(driver);
    }

    final result = await _repository.login(
      email: email,
      password: password,
      deviceToken: deviceToken,
    );

    return switch (result) {
      Failure(:final error) => Result.failure(error),
      Success(:final data) => await establishSession(data),
    };
  }
}