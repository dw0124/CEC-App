import 'package:flutter/material.dart';
import 'package:induk/common/models/equipment.dart';

class RentalListItem extends StatelessWidget {
  final Equipment equipment;
  final VoidCallback onTap;

  const RentalListItem({super.key, required this.equipment, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        height: 48,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(width: 30, child: Text('${equipment.id}')),
              SizedBox(width: 100, child: Text(equipment.name)),
              SizedBox(width: 120, child: Text(equipment.englishCode)),
              SizedBox(
                width: 80,
                child: Text(
                  equipment.available ? '대여 가능' : '대여 불가',
                  style: TextStyle(
                    color: equipment.available ? Colors.green[800] : Colors.redAccent,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
