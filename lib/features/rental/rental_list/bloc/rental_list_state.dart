import 'package:equatable/equatable.dart';
import 'package:induk/common/models/equipment.dart';

enum RentalListStatus { initial, loading, success, failure }

extension RentalListStatusX on RentalListStatus {
  bool get isInitial => this == RentalListStatus.initial;
  bool get isLoading => this == RentalListStatus.loading;
  bool get isSuccess => this == RentalListStatus.success;
  bool get isFailure => this == RentalListStatus.failure;
}

class RentalListState extends Equatable {

  final RentalListStatus status;
  final int categoryId;
  final List<Equipment> rentalItemList;
  final int page;

  const RentalListState({
    this.status = RentalListStatus.initial,
    required this.categoryId,
    this.rentalItemList = const [],
    this.page = 0,
  });

  RentalListState copyWith({
    RentalListStatus? status,
    int? categoryId,
    List<Equipment>? rentalItemList,
    int? page,
  }) {
    return RentalListState(
      status: status ?? this.status,
      categoryId: categoryId ?? this.categoryId,
      rentalItemList: rentalItemList ?? this.rentalItemList,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [status, categoryId, rentalItemList];
}

