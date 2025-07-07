import 'package:induk/features/notice/model/notice_response.dart';
import 'package:induk/features/notice/provider/notice_api_provider.dart';

class NoticeRepository {
  NoticeRepository({NoticeApiProvider? loginApiProvider})
      : _noticeApiProvider = loginApiProvider ?? NoticeApiProvider();

  final NoticeApiProvider _noticeApiProvider;

  Future<NoticeResponse> fetchNotices({
    required int page,
    required String searchType,
    required String? keyword,
    required String sortDirection
  }) async {
    try {
      final json = await _noticeApiProvider.fetchNotices(
        page: page,
        searchType: searchType,
        keyword: keyword,
        sortDirection: sortDirection,
      );

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