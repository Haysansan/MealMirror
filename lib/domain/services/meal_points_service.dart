class MealPointsService {
  static int calculatePoints({
    required String processing,
    required String portion,
  }) {
    final processingLower = processing.toLowerCase();
    final portionLower = portion.toLowerCase();

    int basePoints = switch (processingLower) {
      'whole' => 3,
      'processed' => 0,
      'ultra-processed' => -2,
      _ => 0,
    };

    double portionMultiplier = switch (portionLower) {
      'small' => 0.5,
      'medium' => 1.0,
      'large' => 1.5,
      _ => 1.0,
    };

    return (basePoints * portionMultiplier).round();
  }
}
