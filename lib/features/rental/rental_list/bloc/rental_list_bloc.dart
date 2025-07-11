import 'package:bloc/bloc.dart';
import 'package:induk/features/rental/rental_list/bloc/rental_list_event.dart';
import 'package:induk/features/rental/rental_list/bloc/rental_list_state.dart';
import 'package:induk/features/rental/repository/rental_repository.dart';

class RentalListBloc extends Bloc<RentalListEvent, RentalListState> {

  final RentalRepository _rentalRepository;

  RentalListBloc(this._rentalRepository, int categoryId) : super(RentalListState(categoryId: categoryId)) {
    on<RentalItemListFetch>((event, emit) async => await _rentalItemListFetch(event, emit));
  }

  Future<void> _rentalItemListFetch(RentalItemListFetch event, Emitter<RentalListState> emit) async {
    final page = state.page;
    final categoryId = state.categoryId;

    final equipmentList = await _rentalRepository.fetchEquipmentModels(page: page, categoryId: "$categoryId");

    final updatedState = state.copyWith(
      rentalItemList: [...state.rentalItemList, ...equipmentList],
      page: page + 1
    );

    emit(updatedState);
  }
}