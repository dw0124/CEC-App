class EquipmentCategory {
  final int id;
  final String name;
  final String englishCode;
  final int totalCount;
  final bool available;
  final int maxRentalCount;
  final int brokenCount;

  EquipmentCategory({
    required this.id,
    required this.name,
    required this.englishCode,
    required this.totalCount,
    required this.available,
    required this.maxRentalCount,
    required this.brokenCount,
  });

  factory EquipmentCategory.fromJson(Map<String, dynamic> json) {
    final int id = json["id"];
    final String name = json["name"];
    final String englishCode = json["englishCode"];
    final int totalCount = json["totalCount"];
    final bool available = json["available"];
    final int maxRentalCount = json["maxRentalCount"];
    final int brokenCount = json["brokenCount"];

    return EquipmentCategory(
        id: id,
        name: name,
        englishCode: englishCode,
        totalCount: totalCount,
        available: available,
        maxRentalCount: maxRentalCount,
        brokenCount: brokenCount
    );
  }

  static final empty = EquipmentCategory(
      id: 1,
      name: '카메라',
      englishCode: 'SON',
      available: true,
      totalCount: 20,
      maxRentalCount: 2,
      brokenCount: 3
  );
}