import 'dart:convert';
import '../../services/network/base/api_response.dart';
import '../../services/network/base/api_exception.dart';


Map<String, dynamic> asMap(Object? value) {
  // couvert dio response data from Map<dynamic, dynamic> to Map<String, dynamic>
  if (value is Map) return Map<String, dynamic>.from(value);
  if (value is String) {
    try {
      return Map<String, dynamic>.from(
        // convert json string to Map<String, dynamic> if the string is not empty, otherwise return an empty map
        value.isNotEmpty ? jsonDecode(value) : <String, dynamic>{},
      );
    } catch (_) {
      throw const InvalidResponseException();
    }
  }
  throw const InvalidResponseException();
}
// we have 2 maps maps fron api response and map from
// result
ApiResponse<T> parseApiResponse<T>(
  Object? value,
  T Function(Object? json) decode,
) => ApiResponse.fromJson(asMap(value), decode);


/**
 * Flow:
 *
 * 1. parseApiResponse calls:
 *    asMap(raw)
 *
 * 2. It converts the whole object to:
 *    Map<String, dynamic>
 *
 * 3. ApiResponse.fromJson(...) reads:
 *    json['result']
 *
 * 4. Example result:
 *    {
 *      "email": "a@b.com",
 *      "token": "xyz"
 *    }
 *
 * 5. Then it calls:
 *    asMap(json['result'])
 *
 * 6. The result is:
 *    Map<String, dynamic>
 *
 * So, asMap is used twice for two different purposes.
 */