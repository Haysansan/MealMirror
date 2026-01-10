class NutritionService {
  /// Converts a step count (e.g., points or units) to progress [0..1].
  /// Uses a simple linear scale with maxSteps=10 and clamps.
  static double barProgressFromSteps(int steps, {int maxSteps = 10}) {
    if (maxSteps <= 0) return 0;
    final v = steps / maxSteps;
    if (v < 0) return 0;
    if (v > 1) return 1;
    return v;
  }
}
