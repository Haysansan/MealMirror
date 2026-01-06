# MealMirror

MealMirror is a Flutter app for tracking meals and basic nutrition over time, with a playful “pet” companion theme. The project is organized by feature modules and uses simple local persistence for offline-first storage.

## Features

- **Onboarding**: welcome + instructions flow
- **Home**: daily summary + quick actions
- **Log Meal**: enter a meal and see nutrition/points
- **History**: browse logged meals and summary stats
- **Profile**: user profile + stats + logout

## Tech Stack

- **Flutter** (Dart SDK constraint in `pubspec.yaml`: `^3.9.2`)
- **Routing**: `go_router`
- **Local persistence**: `LocalJsonStore` (single JSON-backed store)
  - **Web**: browser `localStorage` key `mealmirror_store.txt`
  - **Windows/iOS/macOS/Linux**: file `mealmirror_store.txt` in app documents directory via `path_provider`

## Project Structure

Key files/folders:

```text
README.md
pubspec.yaml
analysis_options.yaml

lib/
  main.dart
  core/
    navigation/
      app_router.dart
      app_routes.dart
    theme/
      app_colors.dart
      app_text_styles.dart
      app_theme.dart
  data/
    local/
      auth_service.dart
      local_json_store.dart
      local_json_store_stub.dart
      local_json_store_io.dart
      local_json_store_web.dart
      meal_store.dart
      preferences/
        app_preferences.dart
  features/
    auth/
      signup_screen.dart
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
      log_meal_categories.dart
      log_meal_flow_args.dart
      log_meal_screen.dart
      portion_size_screen.dart
      processing_level_screen.dart
      widgets/
        meal_input_card.dart
        nutrition_selector.dart
        selection_pill.dart
    onboarding/
      instruction_screen.dart
      instruction_steps.dart
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
      primary_button.dart
      stat_bar.dart

test/
  meal_store_test.dart
  widget_test.dart
```

## Getting Started

### Prerequisites

- Flutter SDK installed and on PATH
- Platform toolchain(s) depending on your target:
  - **Web**: Chrome
  - **Windows**: Visual Studio (Desktop development with C++)
  - **iOS**: Xcode (macOS only)

### Install Dependencies

```bash
flutter pub get
```

### Run

List devices:

```bash
flutter devices
```

Run on a specific device:

```bash
flutter run -d chrome
flutter run -d windows
flutter run -d ios
```

Hot reload while running:

- Press `r` in the run terminal
- Press `R` for a full restart

## Local Data

All local data is stored in a single store named `mealmirror_store.txt`.

- **Web (Chrome)**: stored in DevTools → Application → Local Storage under key `mealmirror_store.txt`
- **Windows/iOS/macOS/Linux**: stored as a real file named `mealmirror_store.txt` in the app documents directory
  - The app prints the exact location at startup in debug mode: `MealMirror local storage: ...`

To inspect storage on **Web** quickly:

- Chrome DevTools → **Application** → **Local Storage** → your origin → `mealmirror_store.txt`
- Or run in Console: `localStorage.getItem('mealmirror_store.txt')`

## Development

### Analyze

```bash
flutter analyze
```

### Format

```bash
dart format .
```

### Test

```bash
flutter test
```

## Build

```bash
flutter build web
flutter build windows
flutter build ios
```
