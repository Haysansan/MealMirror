class PortionSizeArgs {
  const PortionSizeArgs({required this.selectedCategories});

  final List<String> selectedCategories;
}

class ProcessingLevelArgs {
  const ProcessingLevelArgs({
    required this.selectedCategories,
    required this.selectedPortion,
  });

  final List<String> selectedCategories;
  final String selectedPortion;
}
