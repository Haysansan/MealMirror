import '../models/history_range.dart';

class HistoryService {
  static String dateKey(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  static DateTime startOfWeek(DateTime now) {
    final int delta = now.weekday - DateTime.monday;
    return DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: delta));
  }

  /// Filters `meals` by `range` using the provided accessors.
  /// - Daily: matches `getDate(item)` to today's `dateKey(now)`
  /// - Weekly: `getCreatedAt(item)` within [startOfWeek(now), endOfToday)
  static List<T> filterMealsForRange<T>(
    List<T> meals,
    DateTime now,
    HistoryRange range, {
    required String? Function(T item) getDate,
    required DateTime? Function(T item) getCreatedAt,
  }) {
    if (range == HistoryRange.daily) {
      final today = dateKey(now);
      return meals.where((m) => getDate(m) == today).toList(growable: false);
    }

    final start = startOfWeek(now);
    final endExclusive = DateTime(
      now.year,
      now.month,
      now.day,
    ).add(const Duration(days: 1));
    return meals
        .where((m) {
          final created = getCreatedAt(m);
          return created != null &&
              !created.isBefore(start) &&
              created.isBefore(endExclusive);
        })
        .toList(growable: false);
  }
}
