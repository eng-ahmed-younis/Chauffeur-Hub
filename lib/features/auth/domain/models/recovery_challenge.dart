final class RecoveryChallenge {
  const RecoveryChallenge({
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.mobile = '',
    this.verificationId = 0,
  });

  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final int verificationId;
}
