import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:induk/common/models/notice.dart';
import 'package:induk/common/widgets/custom_search_bar.dart';
import 'package:induk/notice/bloc/notice_bloc.dart';
import 'package:induk/notice/bloc/notice_state.dart';
import 'package:induk/notice/view/widget/notice_list_item.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
          child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24,
                children: [
                  SizedBox(height: 1,),

                  DropdownSearchBar(
                      categories: ["전체", "제목", "내용"],
                      onSearch: (category, query) {
                        print('카테고리: $category / 검색어: $query');
                      }
                  ),

                  Text(
                      "공지사항 ${context.watch<NoticeBloc>().state.notices.length}개",
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)
                  ),

                  Container(
                    child: BlocSelector<NoticeBloc, NoticeState, List<Notice>>(
                        selector: (state) => state.notices,
                        builder: (context, noticeList) {
                          return ListView.separated(
                            itemCount: noticeList.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) {
                              return NoticeListItem(
                                key: ValueKey(noticeList[index].id),
                                notice: noticeList[index],
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => Divider(
                              color: Colors.black.withValues(alpha: 0.3),
                              height: 12,
                            ),);
                        }
                    ),
                  )
                ],
              ),
            ),
        ),
        ),
    );
  }
}
