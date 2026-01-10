import '../models/history_range.dart';

class HistoryService {
  static List<T> filterMealsForRange<T>(
    List<T> meals,
    DateTime now,
    HistoryRange range, {
    required DateTime Function(T) getDate,
    required DateTime Function(T) getCreatedAt,
  }) {
    if (range == HistoryRange.daily) {
      return meals.where((m) {
        final date = getDate(m);
        return date.year == now.year &&
            date.month == now.month &&
            date.day == now.day;
      }).toList();
    } else {
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      return meals.where((m) {
        final date = getDate(m);
        return date.isAfter(startOfWeek) &&
            date.isBefore(now.add(const Duration(days: 1)));
      }).toList();
    }
  }
}
