class Meal {
  final String id;
  final DateTime createdAt;
  final List<String> categories;
  final String portion;
  final String processing;

  Meal({
    required this.id,
    required this.createdAt,
    required this.categories,
    required this.portion,
    required this.processing,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'categories': categories.join(','),
      'portion': portion,
      'processing': processing,
    };
  }

  static Meal fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'],
      createdAt: DateTime.parse(map['createdAt']),
      categories: map['categories'].split(','),
      portion: map['portion'],
      processing: map['processing'],
    );
  }
}
