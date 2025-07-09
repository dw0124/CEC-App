import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:induk/features/cart/bloc/cart_bloc.dart';
import 'package:induk/features/cart/bloc/cart_state.dart';
import 'package:induk/features/cart/model/cart_item.dart';

class CartListItem extends StatefulWidget {
  final CartItem cartItem;
  final bool isSelected;
  final ValueChanged<bool?> onSelectChanged;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const CartListItem({
    super.key,
    required this.cartItem,
    required this.onTap,
    required this.isSelected,
    required this.onSelectChanged,
    required this.onDelete
  });

  @override
  State<CartListItem> createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  @override
  Widget build(BuildContext context) {
    final cartItem = widget.cartItem;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // 장바구니 선택 버튼
                BlocSelector<CartBloc, CartState, bool>(
                    selector: (state) => state.selectedItemsId.contains(cartItem.id),
                    builder: (context, isSelected) {
                      return
                        Checkbox(
                            value: isSelected,
                            activeColor: Color(0xFF8A1E35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            side: WidgetStateBorderSide.resolveWith(
                                  (states) => BorderSide(width: 1.2, color: Colors.grey),
                            ),
                            onChanged: widget.onSelectChanged
                        );
                    }
                ),

                // 장비 이미지
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey.shade300,
                  child: Center(
                    child: Icon(Icons.image, color: Colors.grey),
                  ),
                ),

                SizedBox(width: 12,),

                // 장비 이름, 모델명, 일련번호, 대여기간
                SizedBox(
                  height: 100,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('카메라', style: TextStyle(fontSize: 12, color: Colors.black)),
                      Text(cartItem.equipment.name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      Text(cartItem.equipment.englishCode, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
                      Spacer(),
                      Text(
                        cartItem.equipment.available ? '대여 가능' : '대여 불가',
                        style: TextStyle(
                          color: cartItem.equipment.available ? Colors.green[800] : Colors.redAccent,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      //Spacer(),
                    ],
                  ),
                ),

                Spacer(),

                IconButton(
                  icon: Icon(
                    Icons.clear,
                    size: 20, // 기본은 24. 작게 하면 얇아 보여요.
                    color: Colors.grey[500],
                  ),
                  onPressed: widget.onDelete,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}