enum TokenErrorType { notFound, expired, invalid }

class TokenException implements Exception {
  final TokenErrorType type;

  TokenException(this.type);

  @override
  String toString() => 'TokenException $type';
}
