import 'package:equatable/equatable.dart';
import 'package:induk/common/models/equipment.dart';

enum RentalApplyStatus { initial, loading, success, failure }

extension RentalApplyStatusX on RentalApplyStatus {
  bool get isInitial => this == RentalApplyStatus.initial;
  bool get isLoading => this == RentalApplyStatus.loading;
  bool get isSuccess => this == RentalApplyStatus.success;
  bool get isFailure => this == RentalApplyStatus.failure;
}

class RentalApplyState extends Equatable {

  final Equipment equipment;
  final DateTime startAt;
  final DateTime endAt;


  const RentalApplyState({
    required this.equipment,
    required this.startAt,
    required this.endAt,
  });

  factory RentalApplyState.initial({required Equipment equipment}) {
    final now = DateTime.now();
    return RentalApplyState(
      equipment: equipment,
      startAt: now,
      endAt: now.add(Duration(hours: 1)),
    );
  }

  RentalApplyState copyWith({
    Equipment? equipment,
    DateTime? startAt,
    DateTime? endAt,
  }) {
    return RentalApplyState(
      equipment: equipment ?? this.equipment,
      startAt: startAt ?? this.startAt,
      endAt: endAt ?? this.endAt,
    );
  }

  @override
  List<Object?> get props => [equipment, startAt, endAt];
}

