import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:induk/common/errors.dart';
import 'dart:convert';

import 'package:induk/common/repository/token_repository.dart';

class RentalApiProvider {
  RentalApiProvider({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  /// 장바구니 조회
  Future<Map<String, dynamic>> fetchCartItems() async {
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
          "api/equipments/cart"
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
      throw Exception("장바구니 조회 실패: $error");
    }
  }

  /// 장바구니 아이템 대여 신청
  Future<Map<String, dynamic>> requestRentCartItems({
    required List<int> cartItemIds,
    required String startAt,
    required String endAt,
  }) async {
    try {
      final accessToken = await TokenRepository().getAccessToken();

      final String baseURL = dotenv.env['BASE_URL']!;

      final header = {
        "accept": "*/*",
        "Authorization": "Bearer $accessToken",
        "Referer": "https://$baseURL",
      };

      final body = jsonEncode({
        "action": "RENT_REQUEST",
        "ids": cartItemIds,
        "startAt": startAt,
        "endAt": endAt
      });

      final url = Uri.https(
          baseURL,
          "/api/equipments/action"
      );

      var response = await _httpClient.post(
        url,
        headers: header,
        body: body,
      );

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse;
    } on TokenException {
      rethrow;
    } catch (error) {
      throw Exception("대여 요청 실패: $error");
    }
  }

  /// 장바구니 아이템 삭제
  Future<Map<String, dynamic>> requestDeleteCartItems({
    required List<int> cartItemIds,
  }) async {
    try {
      final accessToken = await TokenRepository().getAccessToken();

      final String baseURL = dotenv.env['BASE_URL']!;

      final header = {
        "accept": "*/*",
        "Authorization": "Bearer $accessToken",
        "Referer": "https://$baseURL",
      };

      final body = jsonEncode({
        "ids": cartItemIds,
      });

      final url = Uri.https(
          baseURL,
          "/api/equipments/cart"
      );

      final request = http.Request('DELETE', url);
      request.headers.addAll(header);
      request.body = body;

      final streamedResponse = await _httpClient.send(request);
      final response = await http.Response.fromStream(streamedResponse);
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      return jsonResponse;
    } on TokenException {
      rethrow;
    } catch (error) {
      throw Exception("장바구니 아이템 삭제 실패: $error");
    }
  }

  void close() { _httpClient.close(); }
}