import 'package:flutter/cupertino.dart';
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
      appBar: AppBar(
        title: Text(
            '장비 예약',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Center(
          child: Column(
            spacing: 8,
            children: [
              // 1. 장비 관련 정보
              Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 16,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey.shade300,
                      child: Center(
                        child: Icon(Icons.image, color: Colors.grey),
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 70, child: Text('장비 분류: ', style: TextStyle(fontWeight: FontWeight.w600))),
                            Text('카메라'),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 70, child: Text('장비 이름: ', style: TextStyle(fontWeight: FontWeight.w600))),
                            Text('Sony FX3'),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 70, child: Text('모델명: ', style: TextStyle(fontWeight: FontWeight.w600))),
                            Text('ILME-FX3'),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 70, child: Text('일련 번호: ', style: TextStyle(fontWeight: FontWeight.w600))),
                            Text('00000001'),
                          ],
                        ),
                      ],
                    ),

                    Text(
                      true ? '대여 가능' : '대여 불가',
                      style: TextStyle(
                        color: true ? Colors.green[800] : Colors.redAccent,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),

              Divider(),

              // 2. 대여시간 - 대여, 반납 시간 선택 DateTime Picker
              Container(
                child: Column(
                  spacing: 8,
                  children: [
                    Row(
                      children: [
                        Text(
                            '대여 시작',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Spacer(),
                        ElevatedButton(
                            onPressed: () {
                              _showCupertinoDatePicker(context);
                            },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            fixedSize: Size(120, 36),
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.grey[200],
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
                            onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            fixedSize: Size(120, 36),
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.grey[200],
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
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                          ),
                        ),

                        Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            fixedSize: Size(120, 36),
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.grey[200],
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
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            fixedSize: Size(120, 36),
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.grey[200],
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
                  ],
                ),
              ),

              Divider(),

              // 3. 안내 문구
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFDFDEDE), // 연한 회색 (또는 연핑크, 연노랑 등)
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('대여 안내', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 4),
                    Text('• 대여 기간은 평일만 계산하여 최대 3일까지만 가능합니다.'),
                    Text('• 대여 시작 시간은 09:00~18:00만 가능합니다.'),
                    Text('• 주말(토,일)은 대여/반납 불가능합니다.'),
                    SizedBox(height: 12),
                    Text('반납 안내', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 4),
                    Text('• 대여일 포함 3일 사용 후 반납'),
                    Text('• 반납 시간은 최대 18:00까지만 가능합니다'),
                    Text('• 최대 3일 대여 시 오전 9시 또는 9시 30분 반납'),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),

      // bottomNavigationBar - 장바구니, 대여 버튼
      bottomNavigationBar: Builder(
        builder: (context) {
          final bottomPadding = MediaQuery.of(context).padding.bottom;
          final double buttonHeight = 48;

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey.shade300, // 선 색상 (연한 회색)
                  width: 1, // 선 두께
                ),
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
                        foregroundColor: Color(0xFF8A1E35),
                        backgroundColor: Color(0xFFF3DDE1),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                          '장바구니 담기',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                  ),
                ),
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
                          '지금 예약하기',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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

  void _showCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: 250,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date, // date, time, dateAndTime
            initialDateTime: DateTime.now(),
            minimumYear: 2000,
            maximumYear: 2100,
            onDateTimeChanged: (DateTime newDateTime) {
              print('선택된 날짜: $newDateTime');
            },
          ),
        );
      },
    );
  }

}
