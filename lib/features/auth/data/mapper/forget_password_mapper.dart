import 'package:chauffeur_hub/features/auth/data/dto/forget_password_dto.dart';
import 'package:chauffeur_hub/features/auth/domain/models/forget_password.dart';

extension ForgetPasswordMapper on ForgetPasswordDto {
  ForgetPassword toDomain() => ForgetPassword(
    email: email,
    firstName: firstName,
    lastName: lastName,
    mobile: mobile,
    verificationId: verificationId,
  );
}
