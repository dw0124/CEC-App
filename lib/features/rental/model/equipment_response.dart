import 'package:induk/common/models/equipment.dart';

class EquipmentResponse {
  final List<Equipment> equipmentList;

  EquipmentResponse({
    required this.equipmentList,
  });

  factory EquipmentResponse.fromJson(Map<String, dynamic> json) {
    final equipmentList = (json['data']['content'] as List)
        .map((e) => Equipment.fromJson(e))
        .toList();

    return EquipmentResponse(
      equipmentList: equipmentList,
    );
  }
}