class NutriScoreService {
  /// Returns Nutri-Score letter (A = best, E = worst).
  static String calculateNutriScore({
    required int energy,
    required int sugar,
    required int fat,
    required int protein,
    required int fiber,
  }) {
    int score = 0;

    // Negative points
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

    // Positive points
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

    score = score.clamp(0, 40);

    if (score <= 8) return 'A';
    if (score <= 16) return 'B';
    if (score <= 24) return 'C';
    if (score <= 32) return 'D';
    return 'E';
  }

  /// Hex color for Nutri-Score letter.
  static String getColorCode(String letter) {
    return switch (letter) {
      'A' => '#7FB069',
      'B' => '#D4AF37',
      'C' => '#F5A623',
      'D' => '#E74C3C',
      'E' => '#C0392B',
      _ => '#95A5A6',
    };
  }
}
