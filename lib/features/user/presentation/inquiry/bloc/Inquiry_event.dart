sealed class InquiryEvent {}

/// 1:1 문의 목록 불러오기 (처음 한번)
final class InquiryListRequest extends InquiryEvent {}

/// 1:1 문의 목록 불러오기 (반복)
final class InquiryListMoreRequest extends InquiryEvent {}

