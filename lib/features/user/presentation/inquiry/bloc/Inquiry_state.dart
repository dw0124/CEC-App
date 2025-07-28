import 'package:equatable/equatable.dart';
import 'package:induk/features/user/model/inquiry.dart';

sealed class InquiryState extends Equatable {
  const InquiryState();

  @override
  List<Object?> get props => [];
}

// 초기 상태
class InquiryInitial extends InquiryState {
  const InquiryInitial();
}

// 로딩 상태
class InquiryLoading extends InquiryState {
  const InquiryLoading();
}

// 성공 상태
class InquiryLoaded extends InquiryState {
  final List<Inquiry> inquiryList;
  final int page;

  const InquiryLoaded({
    required this.inquiryList,
    this.page = 0,
  });

  InquiryLoaded copyWith({
    List<Inquiry>? inquiryList,
    int? page,
  }) {
    return InquiryLoaded(
      inquiryList: inquiryList ?? this.inquiryList,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [inquiryList, page];
}

// 실패 상태 (에러 메시지)
class InquiryError extends InquiryState {
  final String message;
  const InquiryError({required this.message});

  @override
  List<Object?> get props => [message];
}