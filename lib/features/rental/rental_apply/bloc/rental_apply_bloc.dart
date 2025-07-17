import 'package:bloc/bloc.dart';
import 'package:induk/common/models/equipment.dart';
import 'package:induk/common/models/result.dart';
import 'package:induk/features/rental/rental_apply/bloc/rental_apply_event.dart';
import 'package:induk/features/rental/rental_apply/bloc/rental_apply_state.dart';
import 'package:induk/features/rental/repository/rental_repository.dart';

class RentalApplyBloc extends Bloc<RentalApplyEvent, RentalApplyState> {

  final RentalRepository _rentalRepository;

  RentalApplyBloc(this._rentalRepository, Equipment equipment) : super(RentalApplyState.initial(equipment: equipment)) {
    on<RentalApplyAddToCart>((event, emit) async => await addToCart(event, emit));
    on<RentalApplyRentRequested>((event, emit) async => await _rentItem(event, emit));
    on<RentalApplyDateTimeUpdated>((event, emit) async => await _dateTimeUpdated(event, emit));
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

  Future<void> _rentItem(RentalApplyRentRequested event, Emitter<RentalApplyState> emit) async {
    final rentItemId = state.equipment.id;
    final startAt = state.startAt;
    final endAt = state.endAt;

    _rentalRepository.rentCartItems(cartItemIds: [rentItemId], startAt: startAt, endAt: endAt);
  }

  Future<void> _dateTimeUpdated(RentalApplyDateTimeUpdated event, Emitter<RentalApplyState> emit) async {
    final update = event.isStart ? state.startAt : state.endAt;

    final date = event.date;
    final time = event.time;

    final updated = DateTime(
      date?.year ?? update.year,
      date?.month ?? update.month,
      date?.day ?? update.day,
      time?.hour ?? update.hour,
      time?.minute ?? update.minute,
    );

    if (event.isStart) {
      emit(state.copyWith(startAt: updated));
    } else {
      emit(state.copyWith(endAt: updated));
    }
  }
}