/// Service to calculate Nutri-Score (A-E) based on nutrition values.
class NutriScoreService {
  /// Calculate Nutri-Score letter (A-E) based on nutrition totals.
  /// A = best, E = worst
  /// This is a simplified version of the official Nutri-Score formula
  static String calculateNutriScore({
    required int energy,
    required int sugar,
    required int fat,
    required int protein,
    required int fiber,
  }) {
    // Simplified scoring system (0-40 points, lower is better = A, higher is worse = E)
    int score = 0;

    // Energy (per 100g): 0-3375 kJ
    if (energy > 3000) {
      score += 10;
    } else if (energy > 2250) {
      score += 8;
    } else if (energy > 1500) {
      score += 6;
    } else if (energy > 750) {
      score += 4;
    } else if (energy > 375) {
      score += 2;
    }

    // Sugar (per 100g): 0-45g
    if (sugar > 36) {
      score += 10;
    } else if (sugar > 27) {
      score += 8;
    } else if (sugar > 18) {
      score += 6;
    } else if (sugar > 9) {
      score += 4;
    } else if (sugar > 4) {
      score += 2;
    }

    // Fat (per 100g): 0-40g
    if (fat > 32) {
      score += 10;
    } else if (fat > 24) {
      score += 8;
    } else if (fat > 16) {
      score += 6;
    } else if (fat > 8) {
      score += 4;
    } else if (fat > 4) {
      score += 2;
    }

    // Positive points for protein and fiber (these reduce the score)
    if (protein > 15) {
      score -= 2;
    } else if (protein > 10) {
      score -= 1;
    }

    if (fiber > 4) {
      score -= 2;
    } else if (fiber > 2) {
      score -= 1;
    }

    // Ensure score is within bounds
    score = score.clamp(0, 40);

    // Convert to letter grade (A-E)
    if (score <= 8) return 'A';
    if (score <= 16) return 'B';
    if (score <= 24) return 'C';
    if (score <= 32) return 'D';
    return 'E';
  }

  /// Get color for nutri-score letter
  static String getColorCode(String letter) {
    return switch (letter) {
      'A' => '#7FB069', // Green
      'B' => '#D4AF37', // Gold
      'C' => '#F5A623', // Orange
      'D' => '#E74C3C', // Red-Orange
      'E' => '#C0392B', // Dark Red
      _ => '#95A5A6', // Gray
    };
  }
}
