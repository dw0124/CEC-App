import 'package:bloc/bloc.dart';
import 'package:induk/cart/bloc/cart_event.dart';
import 'package:induk/cart/bloc/cart_state.dart';
import 'package:induk/cart/repository/cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  final CartRepository _CartRepository;

  CartBloc(this._CartRepository) : super(CartState(cartItems: [])) {
    on<CartFetch>((event, emit) async {

    });

    on<CartSelectAll>((event, emit) async {

    });

    on<CartDeleteSelectedItems>((event, emit) async {

    });

    on<CartSelectItem>((event, emit) async {

    });

    on<CartDeleteItem>((event, emit) async {

    });

    on<CartRentSelectedRequested>((event, emit) async {

    });


  }
}