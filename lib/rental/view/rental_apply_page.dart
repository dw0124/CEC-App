import 'package:flutter/material.dart';
import 'package:induk/common/models/equipment.dart';

class RentalApplyPage extends StatefulWidget {
  final Equipment equipment;

  RentalApplyPage({super.key, required this.equipment});

  @override
  State<RentalApplyPage> createState() => _RentalApplyPageState();
}

class _RentalApplyPageState extends State<RentalApplyPage> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              children: [
                // 1. 장비 관련 정보
                Container(),

                // 2. 대여시간 - 대여, 반납 시간 선택 DateTime Picker
                Container(),

                // 3. 신청자 정보
                Container(),

                // 장바구니, 대여 버튼

              ],
            )
        )
    );
  }
}