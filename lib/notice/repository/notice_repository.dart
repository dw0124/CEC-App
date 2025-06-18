import 'package:induk/notice/provider/notice_api_provider.dart';

class NoticeRepository {
  NoticeRepository({NoticeApiProvider? loginApiProvider})
      : _noticeApiProvider = loginApiProvider ?? NoticeApiProvider();

  final NoticeApiProvider _noticeApiProvider;

  Future<bool> fetchNotices({required int page}) async {
    try {
      final json = await _noticeApiProvider.fetchNotices(page: page);

      print(json);

      return true;
    } catch (error) {
      throw Exception("공지사항 불러오기 실패: $error");
    }
  }

  void dispose() {
    _noticeApiProvider.close();
  }
}