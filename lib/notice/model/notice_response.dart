import 'package:induk/common/models/pageable.dart';
import 'package:induk/common/models/notice.dart';

class NoticeResponse {
  final List<Notice> notices;
  final Pageable pageable;

  NoticeResponse({
    required this.notices,
    required this.pageable,
  });

  factory NoticeResponse.fromJson(Map<String, dynamic> json) {
    final notices = (json['data']['content'] as List)
        .map((e) => Notice.fromJson(e))
        .toList();

    final pageable = Pageable.fromJson(json['data']['pageable']);

    return NoticeResponse(
      notices: notices,
      pageable: pageable,
    );
  }
}