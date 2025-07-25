import 'package:flutter/material.dart';
import 'package:induk/features/user/model/inquiry.dart';

class InquiryListItem extends StatelessWidget {

  final Inquiry inquiry;

  const InquiryListItem({super.key, required this.inquiry});

  @override
  Widget build(BuildContext context) {
    final imagesUrl = inquiry.attachments;

    return ExpansionTile(
      initiallyExpanded: false,
      title: Column(
        children: [
          Text(inquiry.status.displayName),

          Row(
            children: [
              Text('[${inquiry.type.displayName}]'),
              Text(inquiry.title),
            ],
          ),

          Text(inquiry.content),

          Container(
            width: double.infinity,
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imagesUrl.length,
              itemBuilder: (BuildContext context, int index) {
                final imageUrl = imagesUrl[index];
                return Image.network(imageUrl);
              },
            ),
          ),

          Text(inquiry.createdAt),
        ],
      ),
      children: <Widget>[
        const Divider(height: 1.0, indent: 16.0, endIndent: 16.0),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                inquiry.content,
                style: const TextStyle(fontSize: 14.0, color: Colors.black87),
              ),
              const SizedBox(height: 16.0),

              if (inquiry.attachments.isNotEmpty) ...[
                Container(
                  height: 110,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: inquiry.attachments.length,
                    itemBuilder: (BuildContext context, int index) {
                      final imageUrl = inquiry.attachments[index];
                      return Image.network(imageUrl);
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
              ],

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
            ],
          ),
        ),
      ],
    );
  }
}