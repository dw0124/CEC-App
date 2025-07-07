import 'package:induk/features/cart/provider/cart_api_provider.dart';

class CartRepository {
  CartRepository({CartApiProvider? cartApiProvider})
      : _cartApiProvider = cartApiProvider ?? CartApiProvider();

  final CartApiProvider _cartApiProvider;

  void fetchCartItems() {
    _cartApiProvider.fetchCartItems();
  }

  void rentCartItems({
    required List<int> cartItemIds,
    required DateTime startAt,
    required DateTime endAt,
  }) {
    final startAtString = startAt.toIso8601String();
    final endAtString = endAt.toIso8601String();

    _cartApiProvider.rentCartItems(cartItemIds: cartItemIds, startAt: startAtString, endAt: endAtString);
  }

  void deleteCartItems({
    required List<int> cartItemIds,
  }) async {
    final result = await _cartApiProvider.deleteCartItems(cartItemIds: cartItemIds);
  }

  void dispose() {
    _cartApiProvider.close();
  }
}