import 'package:bloc/bloc.dart';
import 'package:induk/features/rental/rental_main/bloc/rental_event.dart';
import 'package:induk/features/rental/rental_main/bloc/rental_state.dart';
import 'package:induk/features/rental/repository/rental_repository.dart';

class RentalBloc extends Bloc<RentalEvent, RentalState> {

  final RentalRepository _rentalRepository;

  RentalBloc(this._rentalRepository) : super(RentalState()) {
    on<RentalCategoryListFetch>((event, emit) async => await _rentalCategoryListFetch(event, emit));
  }

  Future<void> _rentalCategoryListFetch(RentalCategoryListFetch event, Emitter<RentalState> emit) async {
    await _rentalRepository.fetchEquipmentCategories();
  }
}