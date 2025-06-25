class Equipment {
  final int id;
  final String name;
  final String englishCode;
  final bool available;
  final int categoryId;

  Equipment({
    required this.id,
    required this.name,
    required this.englishCode,
    required this.available,
    required this.categoryId
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    final int id = json["id"];
    final String name = json["name"];
    final String englishCode = json["englishCode"];
    final bool available = json["available"];
    final int categoryId = json["categoryId"];

    return Equipment(
      id: id,
      name: name,
      englishCode: englishCode,
      available: available,
      categoryId: categoryId
    );
  }

  static final empty = Equipment(
    id: 1,
    name: '삼성 NX-5',
    englishCode: 'Samsung NX-5',
    available: true,
    categoryId: 1
  );
}