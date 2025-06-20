import 'package:bloc/bloc.dart';
import 'package:induk/notice/bloc/notice_state.dart';
import 'package:induk/notice/repository/notice_repository.dart';

sealed class NoticeEvent {}

final class NoticeFetchEvent extends NoticeEvent {
  final String searchType;
  final String? keyword;
  final String sortDirection;
  final bool isLoadMore;

  NoticeFetchEvent({
    this.searchType = "ALL",
    this.keyword,
    this.sortDirection = "DESC",
    this.isLoadMore = false,
  });
}

class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {

  final NoticeRepository _noticeRepository;

  NoticeBloc(this._noticeRepository) : super(NoticeState()) {
    // NoticeFetchEvent 이벤트를 관리하는 EventHandler
    on<NoticeFetchEvent>((event, emit) {
      fetchNotice(event, emit);
    });
  }

  Future<void> fetchNotice(NoticeFetchEvent event, Emitter<NoticeState> emit) async {
    try {
      final page = event.isLoadMore ? state.pageable.pageNumber + 1 : 0;
      final searchType = event.searchType;
      final keyword = event.keyword;
      final sortDirection = event.sortDirection;

      final noticeResponse = await _noticeRepository.fetchNotices(
        page: page,
        searchType: searchType,
        keyword: keyword,
        sortDirection: sortDirection,
      );

      final notices = noticeResponse.notices;
      final pageable = noticeResponse.pageable;

      final newState = state.copyWith(
          noticeStatus: NoticeStatus.success,
          notices: notices,
          pageable: pageable
      );

      emit(newState);
    } catch(error) {
      emit(state.copyWith(noticeStatus: NoticeStatus.failure));
    }
  }
}