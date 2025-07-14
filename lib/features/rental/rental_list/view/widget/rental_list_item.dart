import 'package:flutter/material.dart';
import 'package:induk/common/models/equipment.dart';

class RentalListItem extends StatelessWidget {
  final Equipment equipment;
  final VoidCallback onTap;

  const RentalListItem({
    super.key,
    required this.equipment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        equipment.name,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis
                        )
                      ),
                      Text(
                        equipment.englishCode,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                          overflow: TextOverflow.ellipsis
                        )
                      ),
                      Text(
                        '${equipment.id}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                          overflow: TextOverflow.ellipsis
                        )
                      ),
                      Spacer(),
                      Text(
                        equipment.available ? '대여 가능' : '대여 불가',
                        style: TextStyle(
                          color: equipment.available ? Colors.green[800] : Colors.redAccent,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      //Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
