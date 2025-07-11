import 'package:bloc/bloc.dart';
import 'package:induk/common/models/equipment.dart';
import 'package:induk/features/rental/rental_apply/bloc/rental_apply_event.dart';
import 'package:induk/features/rental/rental_apply/bloc/rental_apply_state.dart';
import 'package:induk/features/rental/repository/rental_repository.dart';

class RentalApplyBloc extends Bloc<RentalApplyEvent, RentalApplyState> {

  final RentalRepository _rentalRepository;

  RentalApplyBloc(this._rentalRepository, Equipment equipment) : super(RentalApplyState.initial(equipment: equipment)) {
    //on<RentalApplyFetch>((event, emit) async => await () {});
  }
}