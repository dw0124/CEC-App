import 'package:induk/common/models/equipment_category.dart';

class EquipmentCategoryResponse {
  final List<EquipmentCategory> equipmentCategoryList;

  EquipmentCategoryResponse({
    required this.equipmentCategoryList,
  });

  factory EquipmentCategoryResponse.fromJson(Map<String, dynamic> json) {
    final equipmentCategoryList = (json['data'] as List)
        .map((e) => EquipmentCategory.fromJson(e))
        .toList();

    return EquipmentCategoryResponse(
      equipmentCategoryList: equipmentCategoryList,
    );
  }
}