class ApiResponse<T> {
  final String status;
  final String message;
  final T? data;

  ApiResponse({
    required this.status,
    required this.message,
    required this.data
  });

  factory ApiResponse.fromJson({
    required Map<String, dynamic> json,
    T? Function(dynamic? json)? fromDataJson,
  }) {
    return ApiResponse(
      status: json['status'],
      message: json['message'],
      data: fromDataJson != null ? fromDataJson(json['data']) : null,
    );
  }
}
