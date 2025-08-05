import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:induk/common/widgets/colors.dart';
import 'package:induk/features/cart/bloc/cart_bloc.dart';
import 'package:induk/features/cart/bloc/cart_state.dart';
import 'package:induk/features/cart/view/cart_page.dart';

class CartBadgeIconButton extends StatelessWidget {
  const CartBadgeIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final cartItemCount = state.cartItems.length;

        return IconButton(
            onPressed: () {
              final cartPage = CartPage();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => cartPage,
                  )
              );
            },
            icon: Badge(
              isLabelVisible: cartItemCount > 0,
              label: Text('$cartItemCount'),
              offset: const Offset(4, -4),
              backgroundColor: AppColors.main,
              child: const Icon(Icons.shopping_bag_outlined)
            )
        );
      },
    );
  }
}