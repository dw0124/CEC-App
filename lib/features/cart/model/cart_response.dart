class CartResponse {
  final String status;
  final String message;
  final List<dynamic> data;

  CartResponse({required this.status, required this.message, required this.data});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    final status = json['status'];
    final message = json['message'];
    final data = json['data'];

    return CartResponse(
        status: status,
        message: message,
        data: data
    );
  }
}