import 'package:induk/common/models/author.dart';

class Notice {
  final int id;
  final String title;
  final String content;
  final bool important;
  final String? attachmentUrl;
  final int view;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Author author;

  Notice({
    required this.id,
    required this.title,
    required this.content,
    required this.important,
    required this.attachmentUrl,
    required this.view,
    required this.createdAt,
    required this.updatedAt,
    required this.author,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    final int id = json['id'];
    final String title = json['title'];
    final String content = json['content'];
    final bool important = json['important'];
    final String? attachmentUrl = json['attachmentUrl'];
    final int view = json['view'];
    final DateTime createdAt = DateTime.parse(json['createdAt']);
    final DateTime updatedAt = DateTime.parse(json['updatedAt']);
    final Author author = Author.fromJson(json['author']);

    return Notice(
      id: id,
      title: title,
      content: content,
      important: important,
      attachmentUrl: attachmentUrl,
      view: view,
      createdAt: createdAt,
      updatedAt: updatedAt,
      author: author,
    );
  }

  static final empty = Notice(
    id: 0,
    title: 'title',
    content: 'content',
    important: false,
    attachmentUrl: 'https://example.com/files/manual.pdf',
    view: 0,
    createdAt: DateTime.parse("2025-06-15T14:55:51.585Z"),
    updatedAt: DateTime.parse("2025-06-15T14:55:51.585Z"),
    author: Author.empty,
  );
}