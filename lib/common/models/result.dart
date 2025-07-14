sealed class Result<T> {
  const Result();

  /// Creates an instance of Result containing a value
  factory Result.ok(T value) => Success(value);

  /// Create an instance of Result containing an error
  factory Result.error(Exception error) => Failure(error);
}

/// Subclass of Result for values
final class Success<T> extends Result<T> {
  const Success(this.value);

  /// Returned value in result
  final T value;
}

/// Subclass of Result for errors
final class Failure<T> extends Result<T> {
  const Failure(this.error);

  /// Returned error in result
  final Exception error;
}