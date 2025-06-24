import 'package:flutter/material.dart';
import 'package:induk/common/extensions/datetime_extensions.dart';
import 'package:induk/common/models/notice.dart';

class NoticeDetailPage extends StatelessWidget {
  final Notice notice;

  const NoticeDetailPage({super.key, required this.notice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        title: Text(
            "공지사항",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: SingleChildScrollView(
              child: Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notice.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(notice.author.imageUrl),
                        backgroundColor: Colors.grey,
                      ),
                      SizedBox(width: 8,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                  notice.author.nickname,
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "[${notice.author.role}]",
                                style: TextStyle(),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              Text(
                                notice.createdAt.toFormatted(),
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
                              ),

                              SizedBox(width: 8,),

                              Text(
                                "조회 ${notice.view.toString()}",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),

                  Divider(height: 1,),

                  Text(notice.content),
                ],
              ),
            ),
          )
      )
    );
  }
}
