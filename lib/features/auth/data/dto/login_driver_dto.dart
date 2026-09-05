final class LoginDriverDto {
  const LoginDriverDto({
    this.accountCode = '',
    this.email = '',
    this.firstName = '',
    this.lastName,
    this.mobile = '',
    this.token = '',
  });

  factory LoginDriverDto.fromJson(Map<String, dynamic> json) {
    return LoginDriverDto(
      accountCode: (json['account_code'] as String?) ?? '',
      email: (json['email'] as String?) ?? '',
      firstName: (json['first_name'] as String?) ?? '',
      lastName: json['last_name'] as String?,
      mobile: (json['mobile'] as String?) ?? '',
      token: (json['token'] as String?) ?? '',
    );
  }

  final String accountCode;
  final String email;
  final String firstName;
  final String? lastName;
  final String mobile;
  final String token;
}
