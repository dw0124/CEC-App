import 'package:induk/common/models/author.dart';

enum InquiryType {
  RENTAL, RETURN, SYSTEM_ERROR, EQUIPMENT_BROKEN, PENALTY, ETC;

  static InquiryType fromString(String name) {
    try {
      return InquiryType.values.byName(name);
    } catch (_) {
      return InquiryType.ETC;
    }
  }

  String get displayName {
    switch (this) {
      case InquiryType.RENTAL:
        return '대여 관련';
      case InquiryType.RETURN:
        return '반납 관련';
      case InquiryType.SYSTEM_ERROR:
        return '시스템 오류';
      case InquiryType.EQUIPMENT_BROKEN:
        return '장비 파손';
      case InquiryType.PENALTY:
        return '패널티 관련';
      case InquiryType.ETC:
        return '기타 문의';
    }
  }
}

enum InquiryStatus {
  NOT_ANSWERED, ANSWERED;

  static InquiryStatus fromString(String name) {
    try {
      return InquiryStatus.values.byName(name);
    } catch (_) {
      return InquiryStatus.NOT_ANSWERED;
    }
  }

  String get displayName {
    switch (this) {
      case InquiryStatus.NOT_ANSWERED:
        return '답변 예정';
      case InquiryStatus.ANSWERED:
        return '답변 완료';
    }
  }
}

class Inquiry {
  final int id;
  final String title;
  final String content;
  final List<String> attachments;
  final InquiryType type;
  final InquiryStatus status;
  final Author author;

  Inquiry({
    required this.id,
    required this.title,
    required this.content,
    required this.attachments,
    required this.type,
    required this.status,
    required this.author,
  });

  factory Inquiry.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final title = json['title'];
    final content = json['content'];
    final attachments = (json['attachments'] as List<String>);

    final typeName = json['type'];
    final type = InquiryType.fromString(typeName);

    final statusName = json['status'];
    final status = InquiryStatus.fromString(statusName);

    final authorJson = json['author'];
    final author = Author.fromJson(authorJson);

    return Inquiry(
        id: id,
        title: title,
        content: content,
        attachments: attachments,
        type: type,
        status: status,
        author: author
    );
  }
}
