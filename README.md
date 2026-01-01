# MealMirror

MealMirror is a Flutter app for tracking meals and basic nutrition over time, with a playful “pet” companion theme. The project is organized by feature modules and uses local persistence for offline-first storage.

## Features

- **Onboarding**: welcome + instructions flow
- **Home**: daily summary, quick actions, bottom navigation
- **Log Meal**: enter a meal and nutrition preview
- **History**: browse logged meals and summary stats
- **Profile**: goals + settings

## Tech Stack

- **Flutter** (Dart SDK constraint in `pubspec.yaml`: `^3.9.2`)
- **Routing**: `go_router`
- **Local database**: `drift` + `sqlite3_flutter_libs`
- **Preferences**: `shared_preferences`

## Project Structure

High-level layout under `lib/`:

```text
lib/
	core/
		constants/
            assets.dart
            spacing.dart
		navigation/
            app_router.dart
		theme/
            app_colors.dart
            app_text_styles.dart
            app_theme.dart
	data/
		local/
            app_database.dart
			dao/
                history_dao.dart
                meal_dao.dart
                pet_dao.dart
			preferences/
                app_preferences.dart
			tables/
                meals_table.dart
                nutrition_table.dart
                pet_state_table.dart
	features/
		history/
            history_screen.dart
                widgets/
                    history_filter_tabs.dart
                    history_stat_card.dart
                    meal_log_list.dart
		home/
            home_screen.dart
                widgets/
                    daily_summary_card.dart
                    quick_action_row.dart
		log_meal/
            log_meal_screen.dart
                widgets/
                    meal_input_card.dart
                    nutrition_selector.dart
		onboarding/
            instruction_screen.dart
            welcome_screen.dart
		profile/
            profile_screen.dart
                widgets/
                    profile_header.dart
                    profile_stat_row.dart
	shared/
		widgets/
            app_scaffold.dart
            bottom_nav.dart
            nutrtition_card.dart
            pet_avatar.dart
            primary_button.dart
            progress_ring.dart
            section_header.dart
            stat_bar.dart
	main.dart
```

## Getting Started

///

### Prerequisites

- Flutter SDK installed and on PATH
- A configured platform toolchain (Android Studio for Android, Xcode for iOS, etc.)

### Install Dependencies

```bash
flutter pub get
```

### Run

```bash
flutter run
```

To run on a specific device:

```bash
flutter devices
flutter run -d <deviceId>
```

## Local Data (Drift + SQLite)

Local database code lives in:

- `lib/data/local/app_database.dart`
- `lib/data/local/tables/`
- `lib/data/local/dao/`

## Development

///

### Analyze

```bash
flutter analyze
```

### Test

```bash
flutter test
```

## Build

```bash
flutter build apk
flutter build appbundle
flutter build ios
```
