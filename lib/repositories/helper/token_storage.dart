import 'package:alugueis_app/models/authentication.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'access_token';
  static const _typeTokenKey = 'type_token';
  static const _tokenExpireIn = 'token_Expire_in';
  static const _refreshTokenKey = 'refresh_token';

  static Future<void> saveToken(Authentication auth) async {
    await _storage.write(key: _tokenKey,value: auth.token);
    await _storage.write(key: _typeTokenKey,value: auth.type);
    await _storage.write(key: _tokenExpireIn,value: auth.expireIn.toString());
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  } 

  static Future<void> clear() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}