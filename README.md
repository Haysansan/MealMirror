# MealMirror

MealMirror is a Flutter app for tracking meals and basic nutrition with a playful “pet” companion theme. This README now reflects the current project layout in the workspace.

## Features

✨ **Core Features:**

🍽️ **Meal Logging** - Log meals with multiple food categories (fruits, vegetables, proteins, dairy, grains, beverages, etc.)

📊 **Nutrition Tracking** - Automatically estimate and track nutrition values (energy, sugar, fat, protein, fiber) for each meal

⭐ **Points System** - Earn or lose points based on meal quality, processing level (whole, processed, ultra-processed), and portion size

🥗 **Nutri-Score Badges** - Get A-E quality ratings for each meal with color-coded visual indicators (A=green, E=red)

🐾 **Pet Companion** - Interactive pet that reflects your meal choices through mood indicators based on daily nutrition and points

👤 **User Profile** - Edit nickname, view cumulative statistics, and track your pet's personality

📅 **Meal History** - Browse all logged meals with category icons, nutrition details, and quick stats

🗑️ **Easy Management** - Swipe-to-delete meals, filter history by date, and view daily summaries


## Project Layered Structured

- `lib/` — main app code

```
lib/
  main.dart
  data/
    meal_repository.dart
    user_repository.dart
  domain/
    models/
      history_range.dart
      history_view_model.dart
      home_view_model.dart
      instruction_step.dart
      instruction_steps.dart
      instruction_view.dart
      log_meal_categories.dart
      log_meal_flow_args.dart
      meal_entry.dart
      meal_summary.dart
      pet_mood.dart
      profile_view_model.dart
      user.dart
    services/
      history_service.dart
      meal_points_service.dart
      nutri_score_service.dart
      nutrition_calculation_service.dart
      nutrition_service.dart
      summary_service.dart
  ui/
    navigation/
      app_routes.dart
      app_router.dart
    theme/
      app_colors.dart
      app_text_styles.dart
      app_theme.dart
    screens/
      home_screens/
        home_screen.dart
      history_screens/
        history_filter_tabs.dart
        history_screen.dart
        history_stat_card.dart
      logmeal_screens/
        log_meal_screen.dart
        portion_size_screen.dart
        processing_level_screen.dart
      profile_screens/
        profile_screen.dart
      welcome_screens/
        instruction_screen.dart
        signup_screen.dart
        welcome_screen.dart
    widgets/
      history_screen/
        history_filter_tabs.dart
        history_stat_card.dart
        meal_log_list.dart
      home_screen/
        daily_balance_card.dart
        home_header.dart
        pet_card.dart
        quick_action_row.dart
      logmeal_screen/
        meal_input_card.dart
        nutrition_selector.dart
        selection_pill.dart
      onBoarding/
        conversation_row.dart
        conversation_step.dart
        instruction_hero.dart
        standard_step.dart
        start_cta_step.dart
      profile_screen/
        profile_header.dart
        profile_stat_row.dart
      reusable/
        app_scaffold.dart
        bottom_nav.dart
        common_widgets.dart
        primary_button.dart
        stat_bar.dart
```

- `test/` — unit and widget tests (examples: `meal_store_test.dart`, `widget_test.dart`)

## Installation

Clone the repository:

```bash
git clone https://github.com/Haysansan/MealMirror.git
cd mealmirror
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

## Development

To run the app in debug mode on a connected device or emulator:

```bash
flutter run -v
```

To build for production:

```bash
# For Android
flutter build apk

# For iOS
flutter build ios
```

## Architecture

This project follows a 3-layer architecture pattern:

- **Models Layer** - Data structures and entities (in `lib/domain/models/`)
- **Repository Layer** - Data access and persistence logic (in `lib/data/`)
- **Service Layer** - Business logic and state management (in `lib/domain/services/`)
- **UI Layer** - Flutter widgets and screens (in `lib/ui/`)

### Key Architecture Components

**Repositories:**
- `MealRepository` - Manages meal data storage and retrieval
- `UserRepository` - Manages user profile data (single-user, local)

**Services:**
- `MealPointsService` - Calculates points based on meal processing level and portion
- `NutritionCalculationService` - Estimates nutrition values for meals
- `NutriScoreService` - Generates nutrition quality scores (A-E)
- `HistoryService` - Manages meal history filtering and retrieval
- `SummaryService` - Aggregates meal data for summaries

**Data Flow:**
1. UI layers (screens/widgets) call repositories or services
2. Services process business logic and call repositories as needed
3. Repositories manage in-memory or persistent storage
4. Models represent data structures across layers

## Common Commands

```bash
flutter pub get
flutter analyze
dart format .
flutter test
```

### Home Screen
Displays a comprehensive overview of:
- Pet companion with mood indicator based on meal quality
- Daily nutrition and points summary
- Quick access to meal logging
- Visual stat bars showing nutrition balance

### Meal Logging Flow
Multi-step meal entry process:
- Meal categories selection (fruits, vegetables, proteins, dairy, grains, beverages, etc.)
- Portion size input
- Processing level selection (raw, cooked, processed) which affects points calculation
- Real-time nutrition and points preview
- Meal summary before confirmation

### History Screen
Browse and manage logged meals:
- Meal history with category icons and visual badges
- Nutri-score display (A-E quality ratings with color codes)
- Points earned/lost for each meal
- Swipe-to-delete functionality
- Date-based filtering and statistics
- Daily nutrition summaries

### Profile Screen
User profile and settings:
- User nickname display and editing
- Pet companion avatar customization
- Cumulative statistics (total points, meals logged, average nutrition)
- Pet mood and personality display

### Onboarding & Welcome
First-time user experience:
- Welcome screen with app introduction
- Instruction screens with interactive steps
- Sign-up flow for single-user local setup
- Tutorial for meal logging and features

## Upcoming Features (Planned)

- Persistent storage across sessions (SharedPreferences/Sembast for web, SQLite for desktop)
- Meal history export (PDF/CSV)
- Advanced nutrition analytics
- Pet animations based on meal quality
- Weekly/monthly nutrition reports

## Notes about Local Storage

The app currently uses in-memory repositories (`MealRepository` and `UserRepository`) for cross-platform compatibility (including web). There are legacy/local store implementations present under `lib/data/` which can be enabled or adapted for persistent storage across sessions.

## Where to Look in the Code

**UI Entry Points:**
- `lib/main.dart` - App initialization and root widget

**Core Data Models:**
- `lib/domain/models/meal_entry.dart` - Main meal data structure
- `lib/domain/models/meal_summary.dart` - Aggregated meal summaries
- `lib/domain/models/user.dart` - User profile data

**Data Access:**
- `lib/data/meal_repository.dart` - Meal storage and retrieval
- `lib/data/user_repository.dart` - User profile storage

**Services:**
- `lib/domain/services/meal_points_service.dart` - Points calculation
- `lib/domain/services/nutrition_calculation_service.dart` - Nutrition estimation
- `lib/domain/services/nutri_score_service.dart` - Nutri-score badge generation

**UI Screens:**
- `lib/ui/screens/home_screens/home_screen.dart` - Home dashboard
- `lib/ui/screens/profile_screens/profile_screen.dart` - User profile and settings
- `lib/ui/screens/history_screens/history_screen.dart` - Meal history
- `lib/ui/screens/logmeal_screens/log_meal_screen.dart` - Meal logging flow
- `lib/ui/screens/welcome_screens/` - Onboarding screens

**Key Widgets:**
- `lib/ui/widgets/history_screen/meal_log_list.dart` - Meal history list with icons and badges
- `lib/ui/widgets/home_screen/pet_card.dart` - Pet companion display
- `lib/ui/widgets/home_screen/daily_balance_card.dart` - Daily nutrition summary

**Navigation:**
- `lib/ui/navigation/app_router.dart` - Go Router configuration
- `lib/ui/navigation/app_routes.dart` - Route definitions

**Styling:**
- `lib/ui/theme/app_theme.dart` - Theme configuration
- `lib/ui/theme/app_colors.dart` - Color palette
- `lib/ui/theme/app_text_styles.dart` - Text styles

## Technologies Used

- **Flutter** - Cross-platform mobile framework for building beautiful, natively compiled applications
- **Dart** - Programming language used by Flutter (SDK: `^3.9.2`)
- **Go Router** - Declarative, type-safe routing for Flutter
- **In-Memory Repositories** - Lightweight data access layer for cross-platform compatibility (web, mobile, desktop)
- **Local Storage** - Data persistence using in-memory storage (with legacy implementations for SharedPreferences, SQLite)

## Credits

This project was created by:

- **Eang Haysan** - Developer
- **Hak Kimly** - Developer

Special thanks to the Flutter community for excellent documentation and resources.
