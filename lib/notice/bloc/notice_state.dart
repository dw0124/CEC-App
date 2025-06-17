import 'package:equatable/equatable.dart';
import 'package:induk/common/models/author.dart';
import 'package:induk/common/models/notice.dart';
import 'package:induk/common/models/pageable.dart';

enum NoticeStatus { initial, loading, success, failure }

extension NoticeStatusX on NoticeStatus {
  bool get isInitial => this == NoticeStatus.initial;
  bool get isLoading => this == NoticeStatus.loading;
  bool get isSuccess => this == NoticeStatus.success;
  bool get isFailure => this == NoticeStatus.failure;
}

class NoticeState extends Equatable {

  final NoticeStatus noticeStatus;
  final List<Notice> notices;
  final Author author;
  final Pageable pageable;

  NoticeState({
    this.noticeStatus = NoticeStatus.initial,
    List<Notice>? notices,
    Author? author,
    Pageable? pageable,
  }) : notices = notices ?? [Notice.empty, Notice.empty, Notice.empty, Notice.empty, Notice.empty, Notice.empty, Notice.empty, Notice.empty, Notice.empty, Notice.empty],
    author = author ?? Author.empty,
    pageable = pageable ?? Pageable.empty;

  NoticeState copyWith({
    NoticeStatus? noticeStatus,
    List<Notice>? notices,
    Author? author,
    Pageable? pageable
  }) {
    return NoticeState(
      noticeStatus: noticeStatus ?? this.noticeStatus,
      notices: notices ?? this.notices,
      author: author ?? this.author,
      pageable: pageable ?? this.pageable,
    );
  }

  @override
  List<Object?> get props => [notices, author, pageable];
}

