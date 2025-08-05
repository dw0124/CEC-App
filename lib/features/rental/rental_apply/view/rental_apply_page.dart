import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:induk/common/models/result.dart';
import 'package:induk/common/widgets/app_button.dart';
import 'package:induk/common/widgets/cart_badge_icon_button.dart';
import 'package:induk/common/widgets/custom_alert_dialog.dart';
import 'package:induk/common/widgets/key_value_text.dart';
import 'package:induk/features/rental/rental_apply/bloc/rental_apply_bloc.dart';
import 'package:induk/features/rental/rental_apply/bloc/rental_apply_event.dart';
import 'package:induk/features/rental/rental_apply/bloc/rental_apply_state.dart';

class RentalApplyPage extends StatefulWidget {
  RentalApplyPage({super.key});

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
    return BlocListener<RentalApplyBloc, RentalApplyState>(
      listenWhen: (prev, curr) => prev.addCartResult != curr.addCartResult,
      listener: (BuildContext context, state) {
        if (state.addCartResult != null) {
          switch (state.addCartResult) {
            case Success(:final value):
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return CustomAlertDialog(
                    title: '상품이 장바구니에 담겼습니다.',
                    cancelText: '닫기',
                    confirmText: '장바구니 보기',
                    onConfirm: () {  },
                    content: '',
                  );
                },
              );
              break;
            case Failure(:final error):
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return CustomAlertDialog(
                    isSingleButton: true,
                    title: '장바구니 추가에 실패하였습니다.',
                    onConfirm: () {  },
                    content: '',
                  );
                },
              );
              break;
            default:
              break;
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              '장비 예약',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          actions: [
            CartBadgeIconButton(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 1, 16, 16),
          child: Center(
            child: Column(
              spacing: 4,
              children: [
                // 1. 장비 이미지
                Container(
                  color: Colors.blue,
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: AspectRatio(aspectRatio: 16 / 9, child: Icon(Icons.image, color: Colors.grey)),
                ),

                SizedBox(height: 4,),

                // 2. 장비 관련 정보
                KeyValueText(keyString: '장비분류', valueString: '카메라 렌즈'),
                KeyValueText(keyString: '장비이름', valueString: '삼양(소니마운트/82mm) 24-70mm'),
                KeyValueText(keyString: '일련번호', valueString: '00000001'),
                KeyValueText(keyString: '대여', valueString: '대여 가능'),

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
                        onPressed: () {
                          context.read<RentalApplyBloc>().add(RentalApplyAddToCart());
                        },
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
                    child: AppButton(text: '대여하기', onPressed: () {
                      _showRentalBottomSheet(context);
                    })
                  ),
                ],
              ),
            );
          },
        ),
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
