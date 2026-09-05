import 'package:chauffeur_hub/features/auth/data/dto/recovery_challenge_dto.dart';
import 'package:chauffeur_hub/features/auth/domain/models/recovery_challenge.dart';

extension RecoveryChallengeMapper on RecoveryChallengeDto {
  RecoveryChallenge toDomain() => RecoveryChallenge(
    email: email,
    firstName: firstName,
    lastName: lastName,
    mobile: mobile,
    verificationId: verificationId,
  );
}
