import 'package:equatable/equatable.dart';
import 'package:induk/common/models/notice.dart';

enum NoticeStatus { initial, loading, success, failure }

extension NoticeStatusX on NoticeStatus {
  bool get isInitial => this == NoticeStatus.initial;
  bool get isLoading => this == NoticeStatus.loading;
  bool get isSuccess => this == NoticeStatus.success;
  bool get isFailure => this == NoticeStatus.failure;
}

class NoticeState extends Equatable {

  final Notice notice;
  final NoticeStatus noticeStatus;

  NoticeState({
    this.noticeStatus = NoticeStatus.initial,
    Notice? notice,
  }) : notice = notice ?? Notice.empty;

  NoticeState copyWith({NoticeStatus? noticeStatus, Notice? notice}) {
    return NoticeState(
      noticeStatus: noticeStatus ?? this.noticeStatus,
      notice: notice ?? this.notice,
    );
  }

  @override
  List<Object?> get props => [notice];
}

