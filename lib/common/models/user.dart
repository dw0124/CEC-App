class User {
  final int id;
  final String studentNumber;
  final String name;
  final String nickname;
  final String role;
  final String department;
  final String profilePicture;

  factory User.fromJson(Map<String, dynamic> json) {
    final data = json["data"];

    final int id = data["id"];
    final String studentNumber = data["studentNumber"];
    final String name = data["name"];
    final String nickname = data["nickname"];
    final String role = data["role"];
    final String department = data["department"];
    final String profilePicture = data["profilePicture"];

    return User(
      id: id,
      studentNumber: studentNumber,
      name: name,
      nickname: nickname,
      role: role,
      department: department,
      profilePicture: profilePicture,
    );
  }

  User({
    required this.id,
    required this.studentNumber,
    required this.name,
    required this.nickname,
    required this.role,
    required this.department,
    required this.profilePicture
  });
}