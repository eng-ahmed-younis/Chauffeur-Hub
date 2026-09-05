class DefaultValues {
  const DefaultValues._();

  static const String string = '';
  static const String? nullableString = null;

  static const bool boolean = false;
  static const bool? nullableBoolean = null;

  static const int integer = 0;
  static const int? nullableInteger = null;

  static const double decimal = 0.0;
  static const double? nullableDecimal = null;

  static const num number = 0;
  static const num? nullableNumber = null;

  static const List<dynamic> list = <dynamic>[];
  static const List<dynamic>? nullableList = null;

  static const Map<String, dynamic> map = <String, dynamic>{};
  static const Map<String, dynamic>? nullableMap = null;

  static const Set<String> set = <String>{};
  static const Set<String>? nullableSet = null;

  static const Duration duration = Duration.zero;
  static const Duration? nullableDuration = null;

  static final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(0);
  static const DateTime? nullableDateTime = null;

  static T value<T>({T? value, T? fallback}) {
    if (value != null) return value;
    if (fallback != null) return fallback;

    if (T == String) return '' as T;
    if (T == bool) return false as T;
    if (T == int) return 0 as T;
    if (T == double) return 0.0 as T;
    if (T == num) return 0 as T;
    if (T == List) return const <dynamic>[] as T;
    if (T == Map) return const <String, dynamic>{} as T;
    if (T == Set) return const <String>{} as T;
    if (T == Duration) return const Duration() as T;
    if (T == DateTime) return DateTime.fromMillisecondsSinceEpoch(0) as T;

    throw UnsupportedError('No default value found for type $T');
  }
}
