import 'package:flutter/material.dart';

sealed class RentalEvent {}

// 카테고리 목록 패치
final class RentalCategoryListFetch extends RentalEvent {}