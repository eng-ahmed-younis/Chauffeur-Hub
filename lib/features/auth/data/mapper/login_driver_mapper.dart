import 'package:chauffeur_hub/features/auth/data/dto/login_driver_dto.dart';
import 'package:chauffeur_hub/features/auth/domain/models/login_driver.dart';

extension LoginDriverMapper on LoginDriverDto {
  LoginDriver toDomain() => LoginDriver(
    accountCode: accountCode,
    email: email,
    firstName: firstName,
    lastName: lastName,
    mobile: mobile,
    token: token,
  );
}
