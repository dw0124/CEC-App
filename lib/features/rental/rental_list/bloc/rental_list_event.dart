import 'package:flutter/material.dart';

sealed class RentalListEvent {}

// 카테고리 아이디에 해당하는 장비 목록 패치
final class RentalItemListFetch extends RentalListEvent {}