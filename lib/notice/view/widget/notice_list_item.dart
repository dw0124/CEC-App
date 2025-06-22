import 'package:flutter/material.dart';
import 'package:induk/common/extensions/datetime_extensions.dart';
import 'package:induk/common/models/notice.dart';

class NoticeListItem extends StatelessWidget {
  final Notice notice;
  final VoidCallback onTap;

  const NoticeListItem({super.key, required this.notice, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notice.title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),

            Text(
              notice.content,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),


            Row(
              children: [
                Text(
                  "${notice.author.nickname}[${notice.author.role}] ・ 조회수 ${notice.view}",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),

                Spacer(),

                Text(
                  "${notice.createdAt.timeAgo()}",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}