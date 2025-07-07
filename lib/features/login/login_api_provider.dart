import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginApiProvider {
  LoginApiProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<Map<String, dynamic>> requestLogin({required String id, required String pwd}) async {
    final String baseURL = dotenv.env['BASE_URL']!;

    final url = Uri.https(
      baseURL,
      "/api/auth/sign-in",
    );

    final body = jsonEncode({
      "studentNumber": id,
      "password": pwd
    });

    var response = await _httpClient.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse;
    } else {
      throw Exception('Failed to Login: ${response.statusCode}');
    }
  }

  void close() { _httpClient.close(); }
}