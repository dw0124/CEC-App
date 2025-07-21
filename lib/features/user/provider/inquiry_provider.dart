import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:induk/common/error/errors.dart';
import 'package:induk/common/repository/token_repository.dart';

class InquiryProvider {
  InquiryProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<http.Response> requestInquiryList({
    required int page,
    int size = 10,
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

      final query = {
        "page": page.toString(),
        "size": size.toString(),
      };

      final url = Uri.https(
          baseURL,
          "/api/inquiry",
          query
      );

      var response = await _httpClient.get(
        url,
        headers: header,
      );

      return response;
    } on TokenException {
      rethrow;
    } catch (error) {
      throw Exception("문의글 목록 불러오기 실패: $error");
    }
  }

  void close() { _httpClient.close(); }
}