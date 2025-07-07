import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:induk/cart/bloc/cart_bloc.dart';
import 'package:induk/cart/bloc/cart_event.dart';
import 'package:induk/cart/bloc/cart_state.dart';
import 'package:induk/cart/model/cart_item.dart';
import 'package:induk/cart/view/widget/cart_list_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        title: Text(
          '장바구니',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56), // 버튼 높이에 맞춰 조정
          child: Column(
            children: [
              Divider(height: 1, color: Colors.grey.shade300),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 전체 선택 버튼
                    Row(
                      children: [
                        BlocSelector<CartBloc, CartState, bool>(
                        selector: (state) {
                          return state.selectedItemsId.isNotEmpty && state.selectedItemsId.length == state.cartItems.length;
                        },
                        builder: (context, isSelected) {
                          return Checkbox(
                            value: isSelected,
                            activeColor: Color(0xFF8A1E35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            side: WidgetStateBorderSide.resolveWith(
                                  (states) =>
                                  BorderSide(width: 1.2, color: Colors.grey),
                            ),
                            onChanged: (value) {
                              if (value != null) {
                                context.read<CartBloc>().add(CartSelectAll(isSelected: value));
                              }
                            },
                          );
                        }),

                        Text(
                          '전체 선택',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),

                    // 선택 삭제 버튼
                    TextButton(
                      onPressed: () => context.read<CartBloc>().add(CartDeleteSelectedItems()),
                      child: Text(
                        '선택삭제',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: BlocSelector<CartBloc, CartState, List<CartItem>>(
            selector: (state) => state.cartItems,
            builder: (context, cartItems) {
              return ListView.separated(
                itemCount: cartItems.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return CartListItem(
                    key: ValueKey(cartItems[index].equipment.id),
                    cartItem: cartItems[index],
                    isSelected: true,
                    onSelectChanged: (value) {
                      final selectedItemId =
                          cartItems[index].equipment.id;
                      context.read<CartBloc>().add(
                        CartSelectItem(selectedItemId: selectedItemId),
                      );
                    },
                    onDelete: () {
                      final selectedItemId =
                          cartItems[index].equipment.id;
                      context.read<CartBloc>().add(
                        CartDeleteItem(selectedItemId: selectedItemId),
                      );
                    },
                    onTap: () {},
                  );
                },
                separatorBuilder:
                    (BuildContext context, int index) => Divider(
                      color: Colors.black.withValues(alpha: 0.3),
                      height: 12,
                    ),
              );
            },
          ),
        ),
      ),

      // bottomNavigationBar - 대여 하기 버튼
      bottomNavigationBar: Builder(
        builder: (context) {
          final bottomPadding = MediaQuery.of(context).padding.bottom;
          final double buttonHeight = 48;

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            padding: EdgeInsets.fromLTRB(16, 8, 16, bottomPadding),
            child: Row(
              spacing: 16,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(double.infinity, buttonHeight),
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF8A1E35),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      '대여하기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
