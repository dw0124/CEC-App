import 'package:equatable/equatable.dart';
import 'package:induk/features/cart/model/cart_item.dart';

enum CartStatus { initial, loading, success, failure }

extension NoticeStatusX on CartStatus {
  bool get isInitial => this == CartStatus.initial;
  bool get isLoading => this == CartStatus.loading;
  bool get isSuccess => this == CartStatus.success;
  bool get isFailure => this == CartStatus.failure;
}

class CartState extends Equatable {

  final CartStatus cartStatus;
  final List<CartItem> cartItems;
  final Set<int> selectedItemsId;

  const CartState({
    this.cartStatus = CartStatus.initial,
    this.cartItems = const [],
    this.selectedItemsId = const {},
  });

  CartState copyWith({
    CartStatus? cartStatus,
    List<CartItem>? cartItems,
    Set<int>? selectedItemsId,
  }) {
    return CartState(
      cartStatus: cartStatus ?? this.cartStatus,
      cartItems: cartItems ?? this.cartItems,
      selectedItemsId: selectedItemsId ?? this.selectedItemsId,
    );
  }

  @override
  List<Object?> get props => [cartStatus, cartItems, selectedItemsId];
}

