import 'package:bloc/bloc.dart';
import 'package:induk/features/cart/bloc/cart_event.dart';
import 'package:induk/features/cart/bloc/cart_state.dart';
import 'package:induk/features/cart/repository/cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  final CartRepository _cartRepository;

  CartBloc(this._cartRepository) : super(CartState.initial()) {
    on<CartFetch>((event, emit) async => await _fetchCartItems(event, emit));

    on<CartSelectAll>((event, emit) async => await _selectAll(event, emit));

    on<CartDeleteSelectedItems>((event, emit) async => _deleteSelectedItems(event, emit));

    on<CartSelectItem>((event, emit) async => await _selectItem(event, emit));

    on<CartDeleteItem>((event, emit) async => await _deleteItem(event, emit));

    on<CartRentSelectedRequested>((event, emit) async => await _rentCartItems(event, emit));
  }

  Future<void> _fetchCartItems(CartFetch event, Emitter<CartState> emit) async {
    _cartRepository.fetchCartItems();
  }

  Future<void> _selectAll(CartSelectAll event, Emitter<CartState> emit) async {
    final isSelected = event.isSelected;

    final selectedItemsId = Set<int>.from(state.selectedItemsId);

    if (isSelected) {
      state.cartItems.forEach((cartItem) {
        selectedItemsId.add(cartItem.equipment.id);
      });
    } else {
      selectedItemsId.clear();
    }

    final newState = state.copyWith(selectedItemsId: selectedItemsId);

    emit(newState);
  }

  Future<void> _deleteSelectedItems(CartDeleteSelectedItems event, Emitter<CartState> emit) async {
    final selectedItemsId = state.selectedItemsId.toList();

    final updatedCartItems = state.cartItems
        .where((item) => !selectedItemsId.contains(item.equipment.id))
        .toList();

    _cartRepository.deleteCartItems(cartItemIds: selectedItemsId);

    emit(state.copyWith(
      cartItems: updatedCartItems,
      selectedItemsId: {},
    ));
  }

  Future<void> _selectItem(CartSelectItem event, Emitter<CartState> emit) async {
    final selectedItemId = event.selectedItemId;

    final selectedItemsId = Set<int>.from(state.selectedItemsId);

    if (selectedItemsId.contains(selectedItemId)) {
      selectedItemsId.remove(selectedItemId);
    } else {
      selectedItemsId.add(selectedItemId);
    }

    final newState = state.copyWith(selectedItemsId: selectedItemsId);

    emit(newState);
  }

  Future<void> _deleteItem(CartDeleteItem event, Emitter<CartState> emit) async {
    final selectedItemId = event.selectedItemId;

    final updatedSelectedItems = Set<int>.from(state.selectedItemsId);
    updatedSelectedItems.remove(selectedItemId);

    final updatedCartItems = state.cartItems
        .where((item) => item.equipment.id != selectedItemId)
        .toList();

    final newState = state.copyWith(
        cartItems: updatedCartItems,
        selectedItemsId: updatedSelectedItems
    );

    _cartRepository.deleteCartItems(cartItemIds: [selectedItemId]);

    emit(newState);
  }

  Future<void> _rentCartItems(CartRentSelectedRequested event, Emitter<CartState> emit) async {
    final selectedItemIds = state.selectedItemsId.toList();
    final startAt = state.startAt;
    final endAt = state.endAt;

    _cartRepository.rentCartItems(cartItemIds: selectedItemIds, startAt: startAt, endAt: endAt);
  }
}