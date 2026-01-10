class MealEntry {
  final String id;
  final DateTime createdAt;
  final DateTime date;
  final List<String> categories;
  final String portion;
  final String processing;
  final int points;

  const MealEntry({
    required this.id,
    required this.createdAt,
    required this.date,
    required this.categories,
    required this.portion,
    required this.processing,
    this.points = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'categories': categories.join(','),
      'portion': portion,
      'processing': processing,
      'points': points,
    };
  }

  factory MealEntry.fromMap(Map<String, dynamic> map) {
    return MealEntry(
      id: map['id'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      date: DateTime.parse(map['createdAt'] as String),
      categories: (map['categories'] as String?)?.split(',') ?? [],
      portion: map['portion'] as String? ?? '',
      processing: map['processing'] as String? ?? '',
      points: int.tryParse(map['points']?.toString() ?? '') ?? 0,
    );
  }
}
