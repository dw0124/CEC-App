import 'package:equatable/equatable.dart';
import 'package:induk/common/models/equipment.dart';

enum RentalStatus { initial, loading, success, failure }

extension RentalStatusX on RentalStatus {
  bool get isInitial => this == RentalStatus.initial;
  bool get isLoading => this == RentalStatus.loading;
  bool get isSuccess => this == RentalStatus.success;
  bool get isFailure => this == RentalStatus.failure;
}

class RentalState extends Equatable {

  final RentalStatus status;
  final Map<int, List<Equipment>> rentalItemList;

  const RentalState({
    this.status = RentalStatus.initial,
    this.rentalItemList = const {},
  });

RentalState copyWith({
  RentalStatus? status,
  Map<int, List<Equipment>>? rentalItemList,
}) {
  return RentalState(
    status: status ?? this.status,
    rentalItemList: rentalItemList ?? this.rentalItemList,
  );
}

  @override
  List<Object?> get props => [status, rentalItemList];
}

