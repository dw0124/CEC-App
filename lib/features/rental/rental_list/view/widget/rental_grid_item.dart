import 'package:flutter/material.dart';
import 'package:induk/common/models/equipment.dart';

class RentalGridItem extends StatelessWidget {
  final Equipment equipment;
  final VoidCallback onTap;

  const RentalGridItem({
    super.key,
    required this.equipment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints contraints) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 장비 이미지
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.6,
                      ),
                      borderRadius: BorderRadius.circular(6.0)
                    ),
                    child: Image.network(
                      equipment.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                // 장비 이름, 모델명, 일련번호, 대여기간
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        equipment.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        equipment.serialNumber,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        equipment.available ? '대여 가능' : '대여 불가',
                        style: TextStyle(
                          color: equipment.available ? Colors.green[800] : Colors.redAccent,
                        ),
                      ),
                    ],
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
