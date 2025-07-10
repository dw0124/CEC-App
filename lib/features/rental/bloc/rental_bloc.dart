import 'package:bloc/bloc.dart';
import 'package:induk/common/models/equipment.dart';
import 'package:induk/features/rental/bloc/rental_event.dart';
import 'package:induk/features/rental/bloc/rental_state.dart';
import 'package:induk/features/rental/repository/rental_repository.dart';

class RentalBloc extends Bloc<RentalEvent, RentalState> {

  final RentalRepository _rentalRepository;

  RentalBloc(this._rentalRepository) : super(RentalState()) {
    on<RentalCategoryListFetch>((event, emit) async => await _rentalCategoryListFetch(event, emit));
    on<RentalItemListFetch>((event, emit) async => await _rentalItemListFetch(event, emit));
  }

  Future<void> _rentalCategoryListFetch(RentalCategoryListFetch event, Emitter<RentalState> emit) async {
    await _rentalRepository.fetchEquipmentCategories();
  }

  Future<void> _rentalItemListFetch(RentalItemListFetch event, Emitter<RentalState> emit) async {
    final categoryId = event.categoryId;

    final equipmentList = await _rentalRepository.fetchEquipmentModels(page: 0, categoryId: "$categoryId");

    final updatedRentItemList = Map<int, List<Equipment>>.from(state.rentalItemList);
    updatedRentItemList[categoryId] = equipmentList;

    state.copyWith(
        rentalItemList: {
        categoryId: equipmentList,
      }
    );

    final updatedState = state.copyWith(rentalItemList: updatedRentItemList);

    emit(updatedState);
  }
}