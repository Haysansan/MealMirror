/// Service to calculate meal points based on processing level and portion size.
class MealPointsService {
  /// Calculate points based on processing level.
  /// Whole foods get positive points, processed get negative.
  static int calculatePoints({
    required String processing,
    required String portion,
  }) {
    final processingLower = processing.toLowerCase();
    final portionLower = portion.toLowerCase();

    // Base points from processing level
    int basePoints = switch (processingLower) {
      'whole' => 3,
      'processed' => 0,
      'ultra-processed' => -2,
      _ => 0,
    };

    // Portion multiplier
    double portionMultiplier = switch (portionLower) {
      'small' => 0.5,
      'medium' => 1.0,
      'large' => 1.5,
      _ => 1.0,
    };

    return (basePoints * portionMultiplier).round();
  }
}
