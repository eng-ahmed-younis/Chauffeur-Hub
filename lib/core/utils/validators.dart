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
