import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class SessionStore {
  Future<String?> readToken();

  Future<void> saveSession({
    required String token,
    required String accountCode,
    required String driverName,
  });

  Future<void> clearSession();

  Future<String?> get fcmToken;

  Future<void> saveFcmToken(String token);
}

final class SecureSessionStore implements SessionStore {
  SecureSessionStore(this._secureStorage, this._preferences);

  static const _tokenKey = 'auth_token';
  static const _accountCodeKey = 'account_code';
  static const _driverNameKey = 'driver_name';
  static const _fcmTokenKey = 'fcm_token';

  // FlutterSecureStorage (Encrypted): Used for sensitive information like the auth_token (JWT).
  // Uses Android KeyStore / iOS Keychain under the hood.
  final FlutterSecureStorage _secureStorage;
  // SharedPreferencesAsync: Modern async key-value preferences without blocking app startup.
  final SharedPreferencesAsync _preferences;

  @override
  Future<String?> readToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  @override
  Future<void> saveSession({
    required String token,
    required String accountCode,
    required String driverName,
  }) async {
    await _secureStorage.write(key: _tokenKey, value: token);
    await _preferences.setString(_accountCodeKey, accountCode);
    await _preferences.setString(_driverNameKey, driverName);
  }

  @override
  Future<void> clearSession() async {
    await _secureStorage.delete(key: _tokenKey);
    await _preferences.remove(_accountCodeKey);
    await _preferences.remove(_driverNameKey);
  }

  @override
  Future<String?> get fcmToken => _preferences.getString(_fcmTokenKey);

  @override
  Future<void> saveFcmToken(String token) async {
    await _preferences.setString(_fcmTokenKey, token);
  }
}
