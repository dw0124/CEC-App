import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:induk/common/error/errors.dart';
import 'package:induk/common/models/result.dart';

class ErrorMapper {
  static Result<T> toFailure<T>(Object error) {
    Exception? originalException = error is Exception ? error : null;
    String? userFriendlyMessage;

    // 1. TokenException (사용자 정의 인증 에러) 처리
    if (error is TokenException) {
      switch (error.type) {
        case TokenErrorType.notFound:
          userFriendlyMessage = '로그인 정보가 없습니다. 다시 로그인해 주세요.';
          break;
        case TokenErrorType.expired:
          userFriendlyMessage = '세션이 만료되었습니다. 다시 로그인해 주세요.';
          break;
        case TokenErrorType.invalid:
          userFriendlyMessage = '유효하지 않은 로그인 정보입니다. 다시 로그인해 주세요.';
          break;
      }
    }
    // 2. http.ClientException 처리 (네트워크 오류, 타임아웃 등)
    else if (error is HttpException) {
      userFriendlyMessage = error.message;
    } else if (error is http.ClientException) { // http 패키지의 ClientException (네트워크 연결 문제 등)
      userFriendlyMessage = '네트워크 연결이 불안정합니다. 인터넷 연결을 확인하고 다시 시도해주세요.';
    }

    // 3. Dart의 내장 Exception 처리
    else if (error is FormatException) {
      userFriendlyMessage = '데이터 형식이 올바르지 않습니다. 다시 시도해주세요.';
    } else if (error is TimeoutException) {
      // http.ClientException에 포함되지 않는 다른 비동기 작업의 타임아웃
      userFriendlyMessage = '작업 시간이 초과되었습니다. 다시 시도해주세요.';
    } else if (error is ArgumentError) {
      userFriendlyMessage = '잘못된 입력값입니다.';
    }

    // 5. 그 외 알 수 없는 모든 에러 처리
    return Failure(originalException ?? Exception('Unknown caught error'),
        message: userFriendlyMessage ?? '알 수 없는 오류가 발생했습니다.');
  }
}