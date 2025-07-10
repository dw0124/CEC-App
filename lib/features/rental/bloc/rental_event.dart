import 'package:flutter/material.dart';

sealed class RentalEvent {}

// 카테고리 목록 패치
final class RentalCategoryListFetch extends RentalEvent {}

// 카테고리에 해당하는 장비 목록 패치
final class RentalItemListFetch extends RentalEvent {
  final int categoryId;

  RentalItemListFetch({
    required this.categoryId
  });
}