import 'dart:async';
import 'dart:io';

sealed class Result<T> {
  const Result();

  /// Creates an instance of Result containing a value
  factory Result.success(T value) => Success(value);

  /// Create an instance of Result containing an error
  factory Result.failure(Exception error, String? message) => Failure(error, message: message);
}

/// Subclass of Result for values
final class Success<T> extends Result<T> {
  const Success(this.value);

  /// Returned value in result
  final T value;
}

/// Subclass of Result for errors
final class Failure<T> extends Result<T> {
  const Failure(this.error, {this.message});

  /// Returned error in result
  final Exception error;
  final String? message;
}