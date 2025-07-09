import 'package:induk/common/models/equipment.dart';

class CartItem {
  final int id;
  final String? startRentAt;
  final String? endRentAt;
  final String? renterName;
  final String status;
  final String createdAt;
  final Equipment equipment;

  CartItem({
    required this.id,
    this.startRentAt,
    this.endRentAt,
    this.renterName,
    required this.status,
    required this.createdAt,
    required this.equipment,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final startRentAt = json['startRentAt'];
    final endRentAt = json['endRentAt'];
    final status = json['status'];
    final createdAt = json['createdAt'];
    final equipment = Equipment.fromJson(json['model']);

    return CartItem(
        id: id,
        startRentAt: startRentAt,
        endRentAt: endRentAt,
        status: status,
        createdAt: createdAt,
        equipment: equipment
    );
  }
}