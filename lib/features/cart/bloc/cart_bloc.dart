import 'package:bloc/bloc.dart';
import 'package:induk/common/models/result.dart';
import 'package:induk/features/cart/bloc/cart_event.dart';
import 'package:induk/features/cart/bloc/cart_state.dart';
import 'package:induk/features/cart/model/cart_item.dart';
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

    on<CartDateTimeUpdated>((event, emit) async => await _dateTimeUpdated(event, emit));
  }

  Future<void> _fetchCartItems(CartFetch event, Emitter<CartState> emit) async {
    final result = await _cartRepository.fetchCartItems();

    switch (result) {
      case Success(:final value):
        final updateState = state.copyWith(
          cartStatus: CartStatus.success,
          cartItems: value,
          selectedItemsId: {},
        );
        emit(updateState);
        break;
      case Failure(:final message):

        break;
    }
  }

  Future<void> _selectAll(CartSelectAll event, Emitter<CartState> emit) async {
    final isSelected = event.isSelected;

    final selectedItemsId = Set<int>.from(state.selectedItemsId);

    if (isSelected) {
      state.cartItems.forEach((cartItem) {
        selectedItemsId.add(cartItem.id);
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
        .where((item) => !selectedItemsId.contains(item.id))
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
        .where((item) => item.id != selectedItemId)
        .toList();

    final result = await _cartRepository.deleteCartItems(cartItemIds: [selectedItemId]);

    switch (result) {
      case Success():
        final newState = state.copyWith(
            cartItems: updatedCartItems,
            selectedItemsId: updatedSelectedItems
        );
        emit(newState);
        break;
      case Failure(:final message):

        break;
    }
  }

  Future<void> _rentCartItems(CartRentSelectedRequested event, Emitter<CartState> emit) async {
    final selectedItemIds = state.selectedItemsId.toList();
    final startAt = state.startAt;
    final endAt = state.endAt;

    // selectedItemsIds - 장바구니ID
    // selectedItemsIds에서 장비ID 뽑아내고 List에 담아서 전달
    final rentItems = state.cartItems
        .where((cartItem) => selectedItemIds.contains(cartItem.id))
        .map((cartItem) => cartItem.equipment.id)
        .toList();

    final unselectedCartItems = state.cartItems
        .where((cartItem) => !selectedItemIds.contains(cartItem.id))
        .toList();

    final result = await _cartRepository.rentCartItems(cartItemIds: rentItems, startAt: startAt, endAt: endAt);

    switch (result) {
      case Success():
        final updateState = state.copyWith(
          cartStatus: CartStatus.success,
          cartItems: unselectedCartItems,
          selectedItemsId: {},
        );
        emit(updateState);
        break;
      case Failure(:final message):

        break;
    }
  }

  Future<void> _dateTimeUpdated(CartDateTimeUpdated event, Emitter<CartState> emit) async {
    final update = event.isStart ? state.startAt : state.endAt;

    final date = event.date;
    final time = event.time;

    final updated = DateTime(
      date?.year ?? update.year,
      date?.month ?? update.month,
      date?.day ?? update.day,
      time?.hour ?? update.hour,
      time?.minute ?? update.minute,
    );

    if (event.isStart) {
      emit(state.copyWith(startAt: updated));
    } else {
      emit(state.copyWith(endAt: updated));
    }
  }
}