import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:induk/common/widgets/app_button.dart';
import 'package:induk/common/widgets/custom_alert_dialog.dart';
import 'package:induk/features/cart/bloc/cart_bloc.dart';
import 'package:induk/features/cart/bloc/cart_event.dart';
import 'package:induk/features/cart/bloc/cart_state.dart';
import 'package:induk/features/cart/model/cart_item.dart';
import 'package:induk/features/cart/view/widget/cart_list_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    context.read<CartBloc>().add(CartFetch());

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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => CustomAlertDialog(
                            title: '선택한 장비를 장바구니에서 삭제할까요?',
                            content: '선택한 장비를 장바구니에서 삭제할까요?',
                            onConfirm: () {
                              context.read<CartBloc>().add(CartDeleteSelectedItems());
                            },
                          ),
                        );
                      },
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
                    key: ValueKey(cartItems[index].id),
                    cartItem: cartItems[index],
                    isSelected: true,
                    onSelectChanged: (value) {
                      final selectedItemId =
                          cartItems[index].id;
                      context.read<CartBloc>().add(
                        CartSelectItem(selectedItemId: selectedItemId),
                      );
                    },
                    onDelete: () {
                      final selectedItemId =
                          cartItems[index].id;
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
                  child: AppButton(text: '대여하기', onPressed: () => _showRentalBottomSheet(context))
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showRentalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        final bottomPadding = MediaQuery.of(context).padding.bottom;

        DateTime? startDate;
        DateTime? endDate;

        return Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, bottomPadding),
          child: Column(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    '대여 시작',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                    ),
                  ),

                  Spacer(),
                  ElevatedButton(
                    onPressed: () {

                      context.read<CartBloc>().add(CartDateTimeUpdated(isStart: true, date: DateTime(2025, 7, 8)));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      fixedSize: Size(120, 36),
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey[300],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      '2025.07.01',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CartBloc>().add(CartDateTimeUpdated(isStart: true, time: TimeOfDay(hour: 16, minute: 0)));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      fixedSize: Size(120, 36),
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey[300],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      '오후 11:11',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Text(
                    '대여 종료',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600
                    ),
                  ),

                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CartBloc>().add(CartDateTimeUpdated(isStart: false, date: DateTime(2025, 7, 8)));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      fixedSize: Size(120, 36),
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey[300],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      '2025.07.01',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CartBloc>().add(CartDateTimeUpdated(isStart: false, time: TimeOfDay(hour: 16, minute: 0)));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      fixedSize: Size(120, 36),
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey[300],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      '오후 11:11',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),

              Container(
                width: double.infinity,
                child: AppButton(
                  text: '대여하기',
                  onPressed: () {

                  },
                )
              ),
            ],
          ),
        );
      },
    );
  }

}
