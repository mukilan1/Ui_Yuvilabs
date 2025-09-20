class AppConstants {
  // Screen Sizes
  static const double screenWidth = 390;
  static const double screenHeight = 844;

  // Padding & Margins
  static const double paddingLarge = 24.0;
  static const double paddingMedium = 16.0;
  static const double paddingSmall = 12.0;
  static const double paddingXSmall = 8.0;

  // Spacing
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;

  // Border Radius
  static const double radiusSmall = 12.0;
  static const double radiusMedium = 16.0;
  static const double radiusLarge = 28.0;

  // Icon Sizes
  static const double iconSmall = 24.0;
  static const double iconMedium = 28.0;
  static const double iconLarge = 56.0;

  // Profile & Avatar Sizes
  static const double profileImageSize = 40.0;
  static const double foodImageSmall = 56.0;
  static const double foodImageLarge = 200.0;

  // Calendar
  static const double calendarItemSize = 36.0;

  // Cards
  static const double dailyCardWidth = 156.0;
  static const double dailyCardHeight = 96.0;
  static const double mealCardWidth = 358.0;
  static const double mealCardHeight = 100.0; // Increased from 80.0

  // Navigation
  static const double bottomNavHeight = 72.0;
  static const double fabSize = 56.0;

  // Buttons & Counters
  static const double counterButtonSize = 28.0;
  static const double servingBadgeHeight = 24.0;

  // Charts
  static const double chartHeight = 160.0;
  static const double lineChartHeight = 120.0;
  static const double chartBarWidth = 24.0;

  // Full Width Button
  static const double buttonHeight = 56.0;

  // Sample Data
  static const List<String> weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  static const List<Map<String, dynamic>> sampleMacros = [
    {
      'title': 'Carbs',
      'value': '120g',
      'color': 'carbs',
      'background': 'carbsBackground',
    },
    {
      'title': 'Protein',
      'value': '80g',
      'color': 'protein',
      'background': 'proteinBackground',
    },
    {
      'title': 'Fat',
      'value': '45g',
      'color': 'fat',
      'background': 'fatBackground',
    },
  ];

  static const List<Map<String, dynamic>> sampleMeals = [
    {
      'name': 'Oatmeal with Berries',
      'calories': '250 kcal',
      'image': 'placeholder_oatmeal',
      'carbs': '40g',
      'protein': '12g',
      'fat': '5g',
    },
    {
      'name': 'Grilled Chicken Salad',
      'calories': '180 kcal',
      'image': 'placeholder_salad',
      'carbs': '6g',
      'protein': '34g',
      'fat': '8g',
    },
  ];

  static const List<String> tabLabels = ['Day', 'Week', 'Month', 'Year'];
}
