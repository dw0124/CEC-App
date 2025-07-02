import 'package:flutter/material.dart';
import 'package:induk/cart/model/cart_item.dart';

class CartListItem extends StatefulWidget {
  final CartItem cartItem;
  final VoidCallback onTap;

  const CartListItem({super.key, required this.cartItem, required this.onTap});

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
                Checkbox(
                  value: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                  side: WidgetStateBorderSide.resolveWith(
                        (states) => BorderSide(width: 1.2, color: Colors.grey),
                  ),
                  onChanged: (value) {

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
                      Text('25.07.01. 14:00', style: TextStyle(fontSize: 12, color: Colors.grey.shade800)),
                      Text('25.07.03. 14:00', style: TextStyle(fontSize: 12, color: Colors.grey.shade800))
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
                  onPressed: () {
                    // 삭제 처리
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}