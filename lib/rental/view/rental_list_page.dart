import 'package:flutter/material.dart';
import 'package:induk/common/models/equipment.dart';
import 'package:induk/rental/view/rental_apply_page.dart';
import 'package:induk/rental/view/widget/rental_list_item.dart';

class RentalListPage extends StatefulWidget {
  final int categoryId;

  RentalListPage({super.key, required this.categoryId});

  @override
  State<RentalListPage> createState() => _RentalListPageState();
}

class _RentalListPageState extends State<RentalListPage> {
  @override
  void initState() {


    super.initState();
  }

  final List<Equipment> equipmentList = [
    Equipment(id: 0, name: '카메라', englishCode: 'CAMERA', available: false, categoryId: 1),
    Equipment.empty,
    Equipment.empty, Equipment.empty,
    Equipment.empty, Equipment.empty,
    Equipment.empty, Equipment.empty
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: equipmentList.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return RentalListItem(
          key: ValueKey(equipmentList[index].id),
          equipment: equipmentList[index],
          onTap: () {
            final rentalApplyPage = RentalApplyPage(equipment: equipmentList[index]);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => rentalApplyPage,
                )
            );
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(
        color: Colors.black.withValues(alpha: 0.3),
        height: 12,
      ),
    );
  }
}