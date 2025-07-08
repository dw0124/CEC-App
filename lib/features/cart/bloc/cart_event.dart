import 'package:flutter/material.dart';

sealed class CartEvent {}

/// 장바구니 불러오기
final class CartFetch extends CartEvent {}

/// 상단 버튼 - 장바구니에서 장비 전체 선택
final class CartSelectAll extends CartEvent {
  final bool isSelected;

  CartSelectAll({required this.isSelected});
}

/// 상단 버튼 - 장바구니에서 선택된 장비 삭제
final class CartDeleteSelectedItems extends CartEvent {}

/// 장바구니에서 장비 선택
final class CartSelectItem extends CartEvent {
  final int selectedItemId;

  CartSelectItem({required this.selectedItemId});
}

/// 장바구니에서 단일 삭제
final class CartDeleteItem extends CartEvent {
  final int selectedItemId;

  CartDeleteItem({required this.selectedItemId});
}

/// 선택된 장비 대여하기 이벤트
final class CartRentSelectedRequested extends CartEvent {}

/// 대여시간 입력 받는 이벤트
class CartDateTimeUpdated extends CartEvent {
  final DateTime? date;
  final TimeOfDay? time;
  final bool isStart; // true면 startAt, false면 endAt

  CartDateTimeUpdated({
    this.date,
    this.time,
    required this.isStart,
  });
}

