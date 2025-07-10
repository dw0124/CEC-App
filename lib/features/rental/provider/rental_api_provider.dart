import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:induk/common/errors.dart';
import 'dart:convert';

import 'package:induk/common/repository/token_repository.dart';

class RentalApiProvider {
  RentalApiProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  /// 카테고리 조회 및 카테고리 별 장비 개수 통계
  Future<Map<String, dynamic>> fetchEquipmentCategories() async {
    try {
      final accessToken = await TokenRepository().getAccessToken();

      final String baseURL = dotenv.env['BASE_URL']!;

      final header = {
        "accept": "*/*",
        "Authorization": "Bearer $accessToken",
        "Referer": "https://$baseURL",
      };

      final url = Uri.https(
        baseURL,
        "/api/equipment-categories",
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
      throw Exception("카테고리 목록 불러오기 실패: $error");
    }
  }

  /// 카테고리에 해당하는 장비목록
  Future<Map<String, dynamic>> fetchEquipmentModels({
    required int page,
    required String categoryId,
    String? searchKeyword,
    String sortDirection = "ASC"
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
        "categoryId": categoryId.toString(),
        if (searchKeyword != null) "searchKeyword": searchKeyword!.toString(),
        "sortDirection": sortDirection.toString(),
        "page": page.toString(),
        "size": 10.toString(),
      };

      final url = Uri.https(
          baseURL,
          "/api/equipment-models",
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
      throw Exception("장비 목록 불러오기 실패: $error");
    }
  }

  void close() { _httpClient.close(); }
}