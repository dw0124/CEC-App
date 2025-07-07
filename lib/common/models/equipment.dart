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
    name: '삼성 NX-1',
    englishCode: 'Samsung NX-5',
    available: true,
    categoryId: 1
  );

  static final empty2 = Equipment(
      id: 2,
      name: '삼성 NX-2',
      englishCode: 'Samsung NX-5',
      available: true,
      categoryId: 1
  );

  static final empty3 = Equipment(
      id: 3,
      name: '삼성 NX-3',
      englishCode: 'Samsung NX-5',
      available: true,
      categoryId: 1
  );

  static final empty4 = Equipment(
      id: 4,
      name: '삼성 NX-4',
      englishCode: 'Samsung NX-5',
      available: true,
      categoryId: 1
  );

  static final empty5 = Equipment(
      id: 5,
      name: '삼성 NX-5',
      englishCode: 'Samsung NX-5',
      available: true,
      categoryId: 1
  );

  static final empty6 = Equipment(
      id: 6,
      name: '삼성 NX-6',
      englishCode: 'Samsung NX-5',
      available: true,
      categoryId: 1
  );

  static final empty7 = Equipment(
      id: 7,
      name: '삼성 NX-7',
      englishCode: 'Samsung NX-5',
      available: true,
      categoryId: 1
  );

  static final empty8 = Equipment(
      id: 8,
      name: '삼성 NX-8',
      englishCode: 'Samsung NX-5',
      available: true,
      categoryId: 1
  );
}