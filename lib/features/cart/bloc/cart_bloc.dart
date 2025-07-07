import 'package:bloc/bloc.dart';
import 'package:induk/features/cart/bloc/cart_event.dart';
import 'package:induk/features/cart/bloc/cart_state.dart';
import 'package:induk/features/cart/model/cart_item.dart';
import 'package:induk/features/cart/repository/cart_repository.dart';
import 'package:induk/common/models/equipment.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  final CartRepository _CartRepository;

  CartBloc(this._CartRepository) : super(CartState(cartItems: [
    CartItem(equipment: Equipment.empty),
    CartItem(equipment: Equipment.empty2),
    CartItem(equipment: Equipment.empty3),
    CartItem(equipment: Equipment.empty4),
    CartItem(equipment: Equipment.empty5),
    CartItem(equipment: Equipment.empty6),
    CartItem(equipment: Equipment.empty7),
    CartItem(equipment: Equipment.empty8),
  ])) {
    on<CartFetch>((event, emit) async => ());

    on<CartSelectAll>((event, emit) async => await _selectAll(event, emit));

    on<CartDeleteSelectedItems>((event, emit) async => _deleteSelectedItems(event, emit));

    on<CartSelectItem>((event, emit) async => await _selectItem(event, emit));

    on<CartDeleteItem>((event, emit) async => await _deleteItem(event, emit));

    on<CartRentSelectedRequested>((event, emit) => ());
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
    final selectedItemsId = state.selectedItemsId;

    final updatedCartItems = state.cartItems
        .where((item) => !selectedItemsId.contains(item.equipment.id))
        .toList();

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

    emit(newState);
  }
}