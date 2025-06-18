import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:induk/common/errors.dart';

class TokenRepository {
  static final TokenRepository _instance = TokenRepository._internal();

  TokenRepository._internal();

  factory TokenRepository() => _instance;

  final _storage = const FlutterSecureStorage();

  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  Future<String> getAccessToken() async {
    final token = await _storage.read(key: 'access_token');
    if (token == null) {
      throw TokenException(TokenErrorType.notFound);
    }

    return token;
  }

  Future<void> deleteAccessToken() async {
    await _storage.delete(key: 'access_token');
  }
}
