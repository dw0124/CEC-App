class Author {
  final int id;
  final String nickname;
  final String imageUrl;
  final String role;

  Author({
    required this.id,
    required this.nickname,
    required this.imageUrl,
    required this.role
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    final int id = json["id"];
    final String nickname = json['nickname'];
    final String imageUrl = json['imageUrl'];
    final String role = json['role'];

    return Author(
      id: id,
      nickname: nickname,
      imageUrl: imageUrl,
      role: role,
    );
  }

  static final empty = Author(
    id: 0,
    nickname: 'nickname',
    imageUrl: 'empty imageUrl',
    role: 'role',
  );
}