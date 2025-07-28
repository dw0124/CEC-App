import 'package:flutter/material.dart';
import 'package:induk/features/user/model/inquiry.dart';

class InquiryListItem extends StatelessWidget {

  final Inquiry inquiry;

  const InquiryListItem({super.key, required this.inquiry});

  @override
  Widget build(BuildContext context) {
    final imagesUrl = inquiry.attachments;

    return ListTileTheme(
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: ExpansionTile(
        showTrailingIcon: false,
        initiallyExpanded: false,
        title: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              inquiry.status.displayName,
              style: TextStyle(
                  fontSize: 14.0,
                  color: inquiry.status == InquiryStatus.NOT_ANSWERED ? Colors.red : Colors.blue
              ),
            ),

            SizedBox(),

            Row(
              children: [
                Text(
                  '[${inquiry.type.displayName}]',
                  style: TextStyle(
                      fontSize: 14.0,
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(width: 4,),
                Text(
                  inquiry.title,
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),

            Text(
              inquiry.content,
              style: const TextStyle(fontSize: 14.0),
            ),

            if (inquiry.attachments.isNotEmpty) ...[
              SizedBox(
                height: 110, // 반드시 높이 지정
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: inquiry.attachments.length,
                  itemBuilder: (BuildContext context, int index) {
                    final imageUrl = inquiry.attachments[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.network(
                        imageUrl,
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 110,
                            height: 110,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],

            SizedBox(),

            Text(
              inquiry.createdAt,
              style: TextStyle(fontSize: 12.0, color: Colors.grey[500]),
            ),
          ],
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: Colors.grey[300]),

              // 답변
              if (inquiry.answer.content.isNotEmpty) ...[
                Text(
                  inquiry.answer.content,
                  style: const TextStyle(fontSize: 14.0),
                ),
              ] else ...[
                Text(
                  '아직 답변이 등록되지 않았습니다.',
                  style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic, color: Colors.grey[600]),
                ),
              ],

              SizedBox(height: 8,)
            ],
          ),
        ],
      )
    );
  }
}