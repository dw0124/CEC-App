import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:induk/common/error/errors.dart';
import 'package:induk/common/models/result.dart';

class ErrorMapper {
  static Result<T> toFailure<T>(Object error) {
    Exception originalException;
    String? userFriendlyMessage;

    // 1. TokenException (사용자 정의 인증 에러) 처리
    if (error is TokenException) {
      originalException = error;
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
      originalException = error;
      userFriendlyMessage = error.message;
    } else if (error is http.ClientException) {
      originalException = error;
      userFriendlyMessage = '네트워크 연결이 불안정합니다. 인터넷 연결을 확인하고 다시 시도해주세요.';
    }
    // 3. Dart의 내장 Exception 처리
    else if (error is FormatException) {
      originalException = error;
      userFriendlyMessage = '데이터 형식이 올바르지 않습니다. 다시 시도해주세요.';
    } else if (error is TimeoutException) {
      originalException = error;
      userFriendlyMessage = '작업 시간이 초과되었습니다. 다시 시도해주세요.';
    } else if (error is ArgumentError) {
      originalException = Exception('ArgumentError: ${error.message}');
      userFriendlyMessage = '잘못된 입력값입니다.';
    }
    // 5. 그 외 알 수 없는 모든 에러 처리 (가장 일반적인 Exception으로 처리)
    else if (error is Exception) {
      originalException = error;
      userFriendlyMessage = '알 수 없는 오류가 발생했습니다: ${error.toString()}'; // 좀 더 상세하게
    }
    else { // error가 Exception 타입이 아닌 경우 (예: Error, String 등)
      originalException = Exception('Unknown caught error of type ${error.runtimeType}');
      userFriendlyMessage = '알 수 없는 오류가 발생했습니다.';
    }

    return Failure(originalException, message: userFriendlyMessage ?? '알 수 없는 오류가 발생했습니다.');
  }
}