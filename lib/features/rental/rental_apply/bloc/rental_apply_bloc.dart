import 'package:bloc/bloc.dart';
import 'package:induk/common/models/equipment.dart';
import 'package:induk/common/models/result.dart';
import 'package:induk/features/rental/rental_apply/bloc/rental_apply_event.dart';
import 'package:induk/features/rental/rental_apply/bloc/rental_apply_state.dart';
import 'package:induk/features/rental/repository/rental_repository.dart';

class RentalApplyBloc extends Bloc<RentalApplyEvent, RentalApplyState> {

  final RentalRepository _rentalRepository;

  RentalApplyBloc(this._rentalRepository, Equipment equipment) : super(RentalApplyState.initial(equipment: equipment)) {
    //on<RentalApplyFetch>((event, emit) async => await () {});

    on<RentalApplyAddToCart>((event, emit) async => await addToCart(event, emit));
  }

  Future<void> addToCart(RentalApplyAddToCart event, Emitter<RentalApplyState> emit) async {
    final id = state.equipment.id;
    final result = await _rentalRepository.requestAddToCart(id: id);

    switch (result) {
      case Success(:final value):
        emit(state.copyWith(addCartResult: result));
        break;
      case Failure(:final error):
        emit(state.copyWith(addCartResult: Failure(error)));
        break;
    }
  }
}