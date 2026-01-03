import 'package:flutter/material.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/primary_button.dart';
import 'widgets/meal_input_card.dart';
import 'widgets/nutrition_selector.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class LogMealScreen extends StatefulWidget {
  const LogMealScreen({Key? key}) : super(key: key);

  @override
  State<LogMealScreen> createState() => _LogMealScreenState();
}

class _LogMealScreenState extends State<LogMealScreen> {
  int _step = 0; // 0=category,1=portion,2=processing
  String? _selectedCategory;
  String _portion = 'Normal';
  String _processing = 'Whole';

  void _next() {
    if (_step < 2) {
      setState(() => _step++);
    } else {
      // Add meal (prototype) — show confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Meal added: $_selectedCategory, $_portion, $_processing',
          ),
        ),
      );
      Navigator.of(context).maybePop();
    }
  }

  void _back() {
    if (_step > 0) setState(() => _step--);
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    String title;
    String actionText = 'Continue';

    switch (_step) {
      case 0:
        title = 'Log a Meal';
        content = MealInputCard(
          selected: _selectedCategory,
          onSelect: (cat) => setState(() => _selectedCategory = cat),
        );
        break;
      case 1:
        title = 'Portion Size';
        content = PortionSelector(
          value: _portion,
          onChanged: (v) => setState(() => _portion = v),
        );
        break;
      default:
        title = 'Processing Levels';
        content = ProcessingSelector(
          value: _processing,
          onChanged: (v) => setState(() => _processing = v),
        );
        actionText = 'Add Meal';
    }

    return AppScaffold(
      title: title,
      body: Column(
        children: [
          const SizedBox(height: 8),
          Expanded(child: content),
          const SizedBox(height: 8),
          Row(
            children: [
              if (_step > 0)
                TextButton(onPressed: _back, child: const Text('Back')),
              const Spacer(),
              PrimaryButton(
                text: actionText,
                onPressed: () {
                  if (_step == 0 && _selectedCategory == null) return;
                  _next();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
