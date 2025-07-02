import 'package:induk/common/models/equipment.dart';

class CartItem {
  final Equipment equipment;
  final DateTime startDate;
  final DateTime endDate;

  CartItem({
    required this.equipment,
    required this.startDate,
    required this.endDate,
  });
}