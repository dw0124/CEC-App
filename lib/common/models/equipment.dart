class Equipment {
  final int id;
  final String name;
  final String englishCode;
  final bool available;
  final int categoryId;
  final String imageUrl;
  final String serialNumber;

  Equipment({
    required this.id,
    required this.name,
    required this.englishCode,
    required this.available,
    required this.categoryId,
    required this.imageUrl,
    required this.serialNumber
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    final int id = json["id"];
    final String name = json["name"];
    final String englishCode = json["englishCode"];
    final bool available = json["available"];
    final int categoryId = json["categoryId"];
    final String imageUrl = json["imageUrl"];

    return Equipment(
      id: id,
      name: name,
      englishCode: englishCode,
      available: available,
      categoryId: categoryId,
      imageUrl: imageUrl,
      serialNumber: ""
    );
  }

  static final empty = Equipment(
      id: 1,
      name: '소니 A7 IV',
      englishCode: 'SONY-A7M4',
      available: true,
      categoryId: 0,
      imageUrl: "https://img.danawa.com/prod_img/500000/023/522/img/15522023_1.jpg?shrink=500:500&_v=20250711154129",
      serialNumber: 'S-7A4-1234567'
  );

  static final empty2 = Equipment(
      id: 2,
      name: '캐논 EOS R5',
      englishCode: 'CANON-R5',
      available: true,
      categoryId: 0,
      imageUrl: "https://cdn.imweb.me/thumbnail/20241024/3131f88ee9cfb.jpg",
      serialNumber: 'C-R5-AB890123'
  );

  static final empty3 = Equipment(
      id: 3,
      name: '니콘 Z8',
      englishCode: 'NIKON-Z8',
      available: true,
      categoryId: 0,
      imageUrl: "https://img.danawa.com/prod_img/500000/762/123/img/20123762_1.jpg?_v=20250723165549&shrink=360:360",
      serialNumber: 'N-Z8-0056789'
  );

  static final empty4 = Equipment(
      id: 4,
      name: '후지필름 X-T5',
      englishCode: 'FUJI-XT5',
      available: false,
      categoryId: 0,
      imageUrl: "https://img.danawa.com/prod_img/500000/903/200/img/18200903_1.jpg?_v=20250723165522&shrink=360:360",
      serialNumber: 'F-XT5-A112233'
  );

  static final empty5 = Equipment(
      id: 5,
      name: '파나소닉 LUMIX GH6',
      englishCode: 'PANASONIC-GH6',
      available: true,
      categoryId: 0,
      imageUrl: "https://img.danawa.com/prod_img/500000/981/514/img/16514981_1.jpg?shrink=360:360&_v=20250725135830",
      serialNumber: 'P-GH6-L445566'
  );

  static final empty6 = Equipment(
      id: 6,
      name: '소니 FX3',
      englishCode: 'SONY-FX3',
      available: true,
      categoryId: 0,
      imageUrl: "https://picsum.photos/200/300?random=6",
      serialNumber: 'S-FX3-7890123'
  );

  static final empty7 = Equipment(
      id: 7,
      name: '캐논 EOS R6 Mark II',
      englishCode: 'CANON-R6M2',
      available: true,
      categoryId: 0,
      imageUrl: "https://picsum.photos/200/300?random=7",
      serialNumber: 'C-R62-Z901234'
  );

  static final empty8 = Equipment(
      id: 8,
      name: 'Blackmagic Pocket 6K Pro',
      englishCode: 'BMPCC-6K-PRO',
      available: false,
      categoryId: 0,
      imageUrl: "https://picsum.photos/200/300?random=8",
      serialNumber: 'BMP-6KP-5566778'
  );
}