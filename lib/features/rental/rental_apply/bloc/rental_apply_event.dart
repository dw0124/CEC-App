import 'package:flutter/material.dart';

sealed class RentalApplyEvent {}

final class RentalApplyFetch extends RentalApplyEvent {}

final class RentalApplyAddToCart extends RentalApplyEvent {}

/// 장비 대여하기 이벤트
final class RentalApplyRentRequested extends RentalApplyEvent {}

/// 대여시간 입력 받는 이벤트
class RentalApplyDateTimeUpdated extends RentalApplyEvent {
  final DateTime? date;
  final TimeOfDay? time;
  final bool isStart; // true면 startAt, false면 endAt

  RentalApplyDateTimeUpdated({
    this.date,
    this.time,
    required this.isStart,
  });
}
