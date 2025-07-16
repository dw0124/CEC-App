import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:induk/common/error/errors.dart';
import 'dart:convert';

import 'package:induk/common/repository/token_repository.dart';

class NoticeApiProvider {
  NoticeApiProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<Map<String, dynamic>> fetchNotices({
    required int page,
    required String searchType,
    required String? keyword,
    required String sortDirection
  }) async {
    try {
      final accessToken = await TokenRepository().getAccessToken();

      final String baseURL = dotenv.env['BASE_URL']!;

      final header = {
        "accept": "*/*",
        "Authorization": "Bearer $accessToken",
        "Referer": "https://$baseURL",
      };

      final query = {
        "searchType": searchType.toString(),
        if (keyword != null) "searchKeyword": keyword!.toString(),
        "sortDirection": sortDirection.toString(),
        "page": page.toString(),
        "size": 10.toString(),
      };

      final url = Uri.https(
        baseURL,
        "/api/notices",
        query
      );

      var response = await _httpClient.get(
        url,
        headers: header,
      );

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } on TokenException {
      rethrow;
    } catch (error) {
      throw Exception("공지사항 불러오기 실패: $error");
    }
  }

  void close() { _httpClient.close(); }
}