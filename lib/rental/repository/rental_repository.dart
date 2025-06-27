import 'package:induk/common/models/equipment_category.dart';
import 'package:induk/rental/provider/rental_api_provider.dart';

class RentalRepository {
  RentalRepository({RentalApiProvider? rentalApiProvider})
      : _rentalApiProvider = rentalApiProvider ?? RentalApiProvider();

  final RentalApiProvider _rentalApiProvider;

  Future<List<EquipmentCategory>> fetchEquipmentCategories() async {
    final categoryListJson = await _rentalApiProvider.fetchEquipmentCategories();


    return List.empty();
  }

  void dispose() {
    _rentalApiProvider.close();
  }
}