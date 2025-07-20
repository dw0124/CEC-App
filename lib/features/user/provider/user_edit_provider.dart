import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:induk/common/error/errors.dart';
import 'package:induk/common/repository/token_repository.dart';

class UserEditProvider {
  UserEditProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<http.Response> updateUserInfoRequest({
    required String name,
    required String phoneNumber,
    required String nickname,
    String? newPassword,
    String? confirmPassword,
    required String profilePicture,
  }) async {
    try {
      final accessToken = await TokenRepository().getAccessToken();

      final String baseURL = dotenv.env['BASE_URL']!;

      final header = {
        "accept": "*/*",
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
        "Referer": "https://$baseURL",
      };

      // final body = jsonEncode({
      //   "name": "홍길동",
      //   "phoneNumber": "01012345678",
      //   "nickname": "길동이",
      //   "newPassword": "password",
      //   "confirmPassword": "string",
      //   "profilePicture": "https://example.com/path/profile.jpg"
      // });

      final body = jsonEncode({
        "name": name,
        "phoneNumber": phoneNumber,
        "nickname": nickname,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
        "profilePicture": profilePicture
      });

      final url = Uri.https(
          baseURL,
          "/api/mypage"
      );

      final request = http.Request('PUT', url);
      request.headers.addAll(header);
      request.body = body;

      final streamedResponse = await _httpClient.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      return response;
    } on TokenException {
      rethrow;
    } catch (error) {
      throw Exception("장바구니 아이템 삭제 실패: $error");
    }
  }

  void close() { _httpClient.close(); }
}