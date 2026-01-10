class MealEntry {
  final String id;
  final DateTime createdAt;
  final DateTime date;
  final List<String> categories;
  final String portion;
  final String processing;
  final int points;
  final int energy;
  final int sugar;
  final int fat;
  final int protein;
  final int fiber;

  const MealEntry({
    required this.id,
    required this.createdAt,
    required this.date,
    required this.categories,
    required this.portion,
    required this.processing,
    this.points = 0,
    this.energy = 0,
    this.sugar = 0,
    this.fat = 0,
    this.protein = 0,
    this.fiber = 0,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'categories': categories.join(','),
      'portion': portion,
      'processing': processing,
      'points': points,
      'energy': energy,
      'sugar': sugar,
      'fat': fat,
      'protein': protein,
      'fiber': fiber,
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
      energy: int.tryParse(map['energy']?.toString() ?? '') ?? 0,
      sugar: int.tryParse(map['sugar']?.toString() ?? '') ?? 0,
      fat: int.tryParse(map['fat']?.toString() ?? '') ?? 0,
      protein: int.tryParse(map['protein']?.toString() ?? '') ?? 0,
      fiber: int.tryParse(map['fiber']?.toString() ?? '') ?? 0,
    );
  }
}
