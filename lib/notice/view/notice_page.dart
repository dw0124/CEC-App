import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:induk/common/models/notice.dart';
import 'package:induk/common/widgets/custom_search_bar.dart';
import 'package:induk/notice/bloc/notice_bloc.dart';
import 'package:induk/notice/bloc/notice_state.dart';
import 'package:induk/notice/view/notice_detail_page.dart';
import 'package:induk/notice/view/widget/notice_list_item.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  void initState() {
    super.initState();

    context.read<NoticeBloc>().add(NoticeFetchEvent());
  }

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
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: DropdownSearchBar(
                        categories: ["전체", "제목", "내용"],
                        onSearch: (category, keyword) {
                          context.read<NoticeBloc>().add(
                              NoticeFetchEvent(
                                keyword: keyword
                              )
                          );
                        }
                    ),
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
                                onTap: () {
                                  final noticeDetailPage = NoticeDetailPage(notice: noticeList[index]);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => noticeDetailPage,
                                      )
                                  );
                                }
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
