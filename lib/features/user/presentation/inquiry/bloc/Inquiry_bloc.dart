import 'package:bloc/bloc.dart';
import 'package:induk/common/models/result.dart';
import 'package:induk/features/user/presentation/inquiry/bloc/Inquiry_event.dart';
import 'package:induk/features/user/presentation/inquiry/bloc/Inquiry_state.dart';
import 'package:induk/features/user/repository/inquiry_repository.dart';

class InquiryBloc extends Bloc<InquiryEvent, InquiryState> {

  final InquiryRepository _inquiryRepository;

  InquiryBloc(this._inquiryRepository) : super(InquiryInitial()) {
    on<InquiryListRequest>((event, emit) async => await _requestInquiryList(event, emit));
    on<InquiryListMoreRequest>((event, emit) async => await _requestMoreInquiryList(event, emit));
  }

  /// 1:1 문의 목록 불러오기 (처음 한번)
  Future<void> _requestInquiryList(InquiryListRequest event, Emitter<InquiryState> emit) async {
    if (state is InquiryLoading) return;

    emit(const InquiryLoading());

    final result = await _inquiryRepository.requestInquiryList(page: 0);

    switch (result) {
      case Success(:final value):
        final updatedState = InquiryLoaded(inquiryList: value);
        emit(updatedState);
        break;
      case Failure(:final message):
        final updatedState = InquiryError(message: message ?? "알 수 없는 오류가 발생했습니다.");
        emit(updatedState);
        break;
    }
  }

  /// 1:1 문의 목록 불러오기 (반복)
  Future<void> _requestMoreInquiryList(InquiryListMoreRequest event, Emitter<InquiryState> emit) async {
    if (state is! InquiryLoaded) return;

    final loadedState = state as InquiryLoaded;
    final updatedPage = loadedState.page + 1;

    final result = await _inquiryRepository.requestInquiryList(page: updatedPage);

    switch (result) {
      case Success(:final value):
        final inquiryList = [...loadedState.inquiryList, ...value];
        final updatedState = loadedState.copyWith(
            inquiryList: inquiryList,
            page: updatedPage
        );
        emit(updatedState);
        break;
      case Failure(:final message):
        final updatedState = InquiryError(message: message ?? "알 수 없는 오류가 발생했습니다.");
        emit(updatedState);
        break;
    }
  }
}