import 'package:induk/notice/model/notice_response.dart';
import 'package:induk/notice/provider/notice_api_provider.dart';

class NoticeRepository {
  NoticeRepository({NoticeApiProvider? loginApiProvider})
      : _noticeApiProvider = loginApiProvider ?? NoticeApiProvider();

  final NoticeApiProvider _noticeApiProvider;

  Future<NoticeResponse> fetchNotices({required int page}) async {
    try {
      final json = await _noticeApiProvider.fetchNotices(page: page);
      final noticeResponse = NoticeResponse.fromJson(json);
      return noticeResponse;
    } catch (error) {
      throw Exception("NoticeRepository fetchNotices - 공지사항 불러오기 실패: $error");
    }
  }

  void dispose() {
    _noticeApiProvider.close();
  }
}