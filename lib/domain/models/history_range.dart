enum HistoryRange { daily, weekly }

extension HistoryRangeExt on HistoryRange {
  String get label => this == HistoryRange.daily ? 'Daily' : 'Weekly';
}
