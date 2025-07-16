import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:induk/common/error/errors.dart';

/// HTTP 응답을 처리하고, 성공 시 파싱된 JSON 데이터를 반환하거나
/// 실패 시 Exception을 발생
dynamic httpResponseHandler(http.Response response) {
  if (response.statusCode >= 200 && response.statusCode < 300) {
    // 200번대 성공 응답 처리
    return jsonDecode(response.body); // 파싱된 JSON 데이터 반환
  } else {
    // 200번대 외의 응답 (오류) 처리
    String errorMessage = '오류 발생: ${response.statusCode}';

    // statusCode에 따라 기본 메시지 설정
    switch (response.statusCode) {
      case 400:
        errorMessage = '잘못된 요청입니다.';
        break;
      case 401:
        errorMessage = '로그인이 필요합니다.';
        break;
      case 403:
        errorMessage = '접근이 거부되었습니다.';
        break;
      case 404:
        errorMessage = '요청한 리소스를 찾을 수 없습니다.';
        break;
      case 500:
        errorMessage = '서버에 문제가 발생했습니다.';
        break;
      default:
        errorMessage = '알 수 없는 오류가 발생했습니다.';
        break;
    }

    // 서버에서 내려준 메시지를 우선 사용
    try {
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic> && decoded['message'] is String) {
        errorMessage = decoded['message'];
      }
    } catch (_) {
      // 파싱 실패 시 기본 메시지 유지
    }

    throw HttpException(response.statusCode, errorMessage);
  }
}