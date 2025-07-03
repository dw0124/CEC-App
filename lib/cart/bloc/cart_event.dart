sealed class CartEvent {}

/// 장바구니 불러오기
final class CartFetch extends CartEvent {}

/// 상단 버튼 - 장바구니에서 장비 전체 선택
final class CartSelectAll extends CartEvent {}

/// 상단 버튼 - 장바구니에서 선택된 장비 삭제
final class CartDeleteSelectedItems extends CartEvent {}

/// 장바구니에서 장비 선택
final class CartSelectItem extends CartEvent {
  final String selectedItemId;

  CartSelectItem({required this.selectedItemId});
}

/// 장바구니에서 단일 삭제
final class CartDeleteItem extends CartEvent {
  final String selectedItemId;

  CartDeleteItem({required this.selectedItemId});
}

/// 선택된 장비 대여하기 이벤트
final class CartRentSelectedRequested extends CartEvent {}
