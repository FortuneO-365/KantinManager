import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveTokens(String access, String refresh) async {
    await _storage.write(key: 'accessToken', value: access);
    await _storage.write(key: 'refreshToken', value: refresh);
  }

  static Future<String?> getAccessToken() async => await _storage.read(key: 'accessToken');

  static Future<String?> getRefreshToken() async => await _storage.read(key: 'refreshToken');

  static Future<void> clearTokens() async => await _storage.deleteAll();
}