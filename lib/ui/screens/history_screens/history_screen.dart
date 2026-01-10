import 'package:flutter/material.dart';
import 'package:mealmirror/data/meal_repository.dart';
import 'package:mealmirror/domain/models/history_range.dart';
import 'package:mealmirror/domain/models/meal_entry.dart';
import 'package:mealmirror/domain/models/history_view_model.dart';
import 'package:mealmirror/ui/theme/app_colors.dart';
import 'package:mealmirror/ui/widgets/reusable/app_scaffold.dart';
import 'package:mealmirror/ui/widgets/history_screen/history_filter_tabs.dart';
import 'package:mealmirror/ui/widgets/history_screen/history_stat_card.dart';
import 'package:mealmirror/ui/widgets/history_screen/meal_log_list.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with WidgetsBindingObserver {
  late HistoryViewModel _viewModel;
  late Future<List<MealEntry>> _futureMeals;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadMeals();
    _viewModel = const HistoryViewModel(
      meals: [],
      selectedRange: HistoryRange.daily,
      isLoading: true,
    );
  }

  void _loadMeals() {
    _futureMeals = MealRepository.getAllMeals();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) {
      setState(() {
        _loadMeals();
      });
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _loadMeals();
    });
    await _futureMeals;
  }

  void _setRange(HistoryRange range) {
    if (_viewModel.selectedRange == range) return;
    setState(() {
      _viewModel = _viewModel.copyWith(selectedRange: range);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'History',
      appBarBackgroundColor: AppColors.background,
      titleTextStyle: const TextStyle(
        color: AppColors.mealMirrorTitle,
        fontSize: 32,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        height: 1.06,
      ),
      centerTitle: false,
      body: FutureBuilder<List<MealEntry>>(
        future: _futureMeals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final meals = snapshot.data ?? const <MealEntry>[];
          _viewModel = _viewModel.copyWith(meals: meals, isLoading: false);

          if (_viewModel.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'No history yet.  Log your first meal to get started.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.mealMirrorMutedText),
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            color: AppColors.primary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HistoryFilterTabs(
                    selectedRange: _viewModel.selectedRange,
                    onRangeSelected: _setRange,
                  ),
                  const SizedBox(height: 16),
                  HistoryStatCard(
                    title: _viewModel.statsTitle,
                    totals: _viewModel.nutritionTotals,
                  ),
                  const SizedBox(height: 16),
                  MealLogList(
                    meals: _viewModel.filteredMeals,
                    now: DateTime.now(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
