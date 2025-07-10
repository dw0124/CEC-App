import 'package:induk/common/models/equipment.dart';
import 'package:induk/common/models/equipment_category.dart';
import 'package:induk/features/rental/model/equipment_response.dart';
import 'package:induk/features/rental/provider/rental_api_provider.dart';

class RentalRepository {
  RentalRepository({RentalApiProvider? rentalApiProvider})
      : _rentalApiProvider = rentalApiProvider ?? RentalApiProvider();

  final RentalApiProvider _rentalApiProvider;

  Future<List<EquipmentCategory>> fetchEquipmentCategories() async {
    final categoryListJson = await _rentalApiProvider.fetchEquipmentCategories();


    return List.empty();
  }

  Future<List<Equipment>> fetchEquipmentModels({
    required int page,
    required String categoryId,
    String? searchKeyword,
    String sortDirection = "ASC"
  }) async {
    final equipmentModelsJson = await _rentalApiProvider.fetchEquipmentModels(
      page: 0,
      categoryId: categoryId,
      searchKeyword: searchKeyword,
      sortDirection: sortDirection,
    );

    final equipmentResponse = EquipmentResponse.fromJson(equipmentModelsJson);
    final equipmentList = equipmentResponse.equipmentList;

    return equipmentList;
  }

  void dispose() {
    _rentalApiProvider.close();
  }
}