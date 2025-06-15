class Pageable {
  final int pageNumber;
  final int pageSize;
  final int totalPages;
  final int totalElements;

  Pageable({
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
    required this.totalElements
  });

  factory Pageable.fromJson(Map<String, dynamic> json) {
    final int pageNumber = json["pageNumber"];
    final int pageSize = json["pageSize"];
    final int totalPages = json["totalPages"];
    final int totalElements = json["totalElements"];

    return Pageable(
        pageNumber: pageNumber,
        pageSize: pageSize,
        totalPages: totalPages,
        totalElements: totalElements
    );
  }

  static final empty = Pageable(
      pageNumber: 0,
      pageSize: 0,
      totalPages: 0,
      totalElements: 0
  );
}