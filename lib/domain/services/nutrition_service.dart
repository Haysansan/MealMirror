class NutritionService {
  /// Converts steps to progress value in range [0..1].
  static double barProgressFromSteps(int steps, {int maxSteps = 10}) {
    if (maxSteps <= 0) return 0;

    final v = steps / maxSteps;
    if (v < 0) return 0;
    if (v > 1) return 1;
    return v;
  }
}
