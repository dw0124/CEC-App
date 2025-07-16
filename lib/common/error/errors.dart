enum TokenErrorType { notFound, expired, invalid }

class TokenException implements Exception {
  final TokenErrorType type;

  TokenException(this.type);

  @override
  String toString() => 'TokenException $type';
}

class HttpException implements Exception {
  final int statusCode;
  final String message;

  HttpException(this.statusCode, this.message);

  @override
  String toString() => 'HttpException($statusCode): $message';
}
