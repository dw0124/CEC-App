import 'package:bloc/bloc.dart';
import 'package:induk/notice/bloc/notice_state.dart';

sealed class NoticeEvent {}

final class NoticeFetchEvent extends NoticeEvent {}
final class CounterErrorPressed extends NoticeEvent {}

class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  NoticeBloc() : super(NoticeState()) {
    // CounterIncrementPressed 이벤트를 관리하는 EventHandler
    on<NoticeFetchEvent>((event, emit) => emit(state));
    on<CounterErrorPressed>((event, emit) {
      addError(Exception('error!'), StackTrace.current);
    });
  }

  @override
  void onEvent(NoticeEvent event) {
    // 이벤트 발생 시 호출됨
    super.onEvent(event);
    print(event);
  }

  @override
  void onChange(Change<NoticeState> change) {
    // State가 변경될 때 호출됨
    super.onChange(change);
    print(change);
  }

  @override
  void onTransition(Transition<NoticeEvent, NoticeState> transition) {
    // State가 변경될 때 호출됨 (이벤트 정보를 포함)
    super.onTransition(transition);
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }
}