import 'package:induk/common/models/api_response.dart';
import 'package:induk/common/models/equipment.dart';
import 'package:induk/common/models/equipment_category.dart';
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

    final apiResponse = ApiResponse<List<Equipment>>.fromJson(
      json: equipmentModelsJson,
      fromDataJson: (data) {
          return (data as List).map((e) => Equipment.fromJson(e)).toList();
        },
    );

    final equipmentList = apiResponse.data;

    return equipmentList ?? [];
  }

  /// 장바구니 추가
  void requestAddToCart({required int id}) async {
    final List<int> equipmentId = [id];

    final json = await _rentalApiProvider.requestAddToCart(id: equipmentId);

    final apiResponse = ApiResponse.fromJson(json: json);

  }

  /// 장비 대여
  void rentCartItems({
    required List<int> cartItemIds,
    required DateTime startAt,
    required DateTime endAt,
  }) async {
    final startAtString = startAt.toIso8601String();
    final endAtString = endAt.toIso8601String();
  }

  void dispose() {
    _rentalApiProvider.close();
  }
}