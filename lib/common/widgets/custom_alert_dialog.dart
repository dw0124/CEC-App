import 'package:flutter/material.dart';
import 'package:induk/common/widgets/colors.dart';

class CustomAlertDialog extends StatelessWidget {
  final bool isSingleButton;
  final String title;
  final String content;
  final String cancelText;
  final String confirmText;
  final VoidCallback onConfirm;

  const CustomAlertDialog({
    super.key,
    this.isSingleButton = false,
    required this.title,
    required this.content,
    this.cancelText = '취소',
    this.confirmText = '확인',
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      insetPadding: EdgeInsets.all(16),
      actionsPadding: EdgeInsets.only(bottom: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Container(
        width: maxWidth,
        alignment: Alignment.center,
        child: Text(
            title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),

      actions: [
        Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Row(
            children: [
              if(!isSingleButton)
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(cancelText, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey.shade600)),
                ),
              ),

              if(!isSingleButton)
              Container(
                height: 48,
                width: 1,
                color: Colors.grey.shade300,
              ),

              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onConfirm();
                  },
                  child: Text(confirmText, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.main)),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
