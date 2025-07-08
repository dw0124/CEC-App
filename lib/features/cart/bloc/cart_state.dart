import 'package:equatable/equatable.dart';
import 'package:induk/features/cart/model/cart_item.dart';

import 'package:induk/common/models/equipment.dart';

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
  final DateTime startAt;
  final DateTime endAt;

  CartState({
    required this.cartStatus,
    required this.cartItems,
    required this.selectedItemsId,
    required this.startAt,
    required this.endAt,
  });

  factory CartState.initial() {
    final now = DateTime.now();
    return CartState(
      cartStatus: CartStatus.initial,
      cartItems: [
        CartItem(equipment: Equipment.empty),
        CartItem(equipment: Equipment.empty2),
        CartItem(equipment: Equipment.empty3),
        CartItem(equipment: Equipment.empty4),
        CartItem(equipment: Equipment.empty5),
        CartItem(equipment: Equipment.empty6),
        CartItem(equipment: Equipment.empty7),
        CartItem(equipment: Equipment.empty8),
      ],
      selectedItemsId: {},
      startAt: now,
      endAt: now.add(Duration(hours: 1)),
    );
  }

  CartState copyWith({
    CartStatus? cartStatus,
    List<CartItem>? cartItems,
    Set<int>? selectedItemsId,
    DateTime? startAt,
    DateTime? endAt,
  }) {
    return CartState(
      cartStatus: cartStatus ?? this.cartStatus,
      cartItems: cartItems ?? this.cartItems,
      selectedItemsId: selectedItemsId ?? this.selectedItemsId,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
    );
  }

  @override
  List<Object?> get props => [cartStatus, cartItems, selectedItemsId, startAt, endAt];
}

