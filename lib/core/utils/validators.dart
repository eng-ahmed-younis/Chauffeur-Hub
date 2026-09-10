final RegExp _emailPattern = RegExp(
  r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
);

bool isValidEmail(String value) => _emailPattern.hasMatch(value.trim());

bool isValidPassword(String value) {
  const symbols = r'''!@#$%^&*()-+_=<>?{}[]|\/~`';:,." ''';
  return value.length >= 8 &&
      value.contains(RegExp('[A-Z]')) &&
      value.contains(RegExp('[a-z]')) &&
      value.contains(RegExp('[0-9]')) &&
      value.split('').any(symbols.contains);
}



String? validatePasswordMessage(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required.';
  }

  if (value.length < 8) {
    return 'Password must be at least 8 characters.';
  }

  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain an uppercase letter.';
  }

  if (!value.contains(RegExp(r'[a-z]'))) {
    return 'Password must contain a lowercase letter.';
  }

  if (!value.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain a number.';
  }

  const symbols = r'''!@#$%^&*()-+_=<>?{}[]|\/~`';:,." ''';

  if (!value.split('').any(symbols.contains)) {
    return 'Password must contain a special character.';
  }

  return null;
}