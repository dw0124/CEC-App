import 'package:induk/features/cart/model/cart_item.dart';
import 'package:induk/features/cart/provider/cart_api_provider.dart';

import 'package:induk/common/models/api_response.dart';
import 'package:induk/common/models/result.dart';
import 'package:induk/common/error/error_mapper.dart';
import 'package:induk/common/network/http_response_handler.dart';

class CartRepository {
  CartRepository({CartApiProvider? cartApiProvider})
      : _cartApiProvider = cartApiProvider ?? CartApiProvider();

  final CartApiProvider _cartApiProvider;

  Future<Result<List<CartItem>>> fetchCartItems() async {
    try {
      final response = await _cartApiProvider.fetchCartItems();
      final jsonResponse = httpResponseHandler(response);

      final apiResponse = ApiResponse<List<CartItem>>.fromJson(
        json: jsonResponse,
        fromDataJson: (dynamic jsonData) {
          if (jsonData is List) {
            return jsonData
                .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
                .toList();
          }
          return [];
        },
      );

      final List<CartItem> cartItems = apiResponse.data ?? [];

      return Result.success(cartItems);
    } catch (e) {
      return ErrorMapper.toFailure(e);
    }
  }

  Future<Result<void>> rentCartItems({
    required List<int> cartItemIds,
    required DateTime startAt,
    required DateTime endAt,
  }) async {
    final startAtString = startAt.toIso8601String();
    final endAtString = endAt.toIso8601String();

    try {
      final result = await _cartApiProvider.rentCartItems(
          cartItemIds: cartItemIds,
          startAt: startAtString,
          endAt: endAtString
      );

      return Result.success(null);
    } catch(e) {
      return ErrorMapper.toFailure(e);
    }
  }

  Future<Result<void>> deleteCartItems({
    required List<int> cartItemIds,
  }) async {
    try {
      final result = await _cartApiProvider.deleteCartItems(
          cartItemIds: cartItemIds);
      return Result.success(null);
    } catch(e) {
      return ErrorMapper.toFailure(e);
    }
  }

  void dispose() {
    _cartApiProvider.close();
  }
}