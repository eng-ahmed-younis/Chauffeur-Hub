final class RecoveryChallengeDto {
  const RecoveryChallengeDto({
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.mobile = '',
    this.verificationId = 0,
  });

  factory RecoveryChallengeDto.fromJson(Map<String, dynamic> json) {
    return RecoveryChallengeDto(
      email: (json['email'] as String?) ?? '',
      firstName: (json['first_name'] as String?) ?? '',
      lastName: (json['last_name'] as String?) ?? '',
      mobile: (json['mobile'] as String?) ?? '',
      verificationId: (json['verification_id'] as num?)?.toInt() ?? 0,
    );
  }

  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final int verificationId;
}
