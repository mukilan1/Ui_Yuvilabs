import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'dart:math';
import '../utils/colors.dart';
import '../utils/styles.dart';
import '../utils/constants.dart';

class DailyOverviewCard extends StatelessWidget {
  final String title;
  final String value;
  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;

  const DailyOverviewCard({
    super.key,
    required this.title,
    required this.value,
    required this.backgroundColor,
    required this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.dailyCardWidth,
      height: AppConstants.dailyCardHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
      ),
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: AppConstants.iconSmall),
          const Spacer(),
          Text(title, style: AppTextStyles.cardTitle),
          Text(value, style: AppTextStyles.cardValue),
        ],
      ),
    );
  }
}

class ArcBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw top arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // start angle (top)
      pi, // sweep angle (180 degrees)
      false,
      paint,
    );

    // Draw bottom arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi / 2, // start angle (bottom)
      pi, // sweep angle (180 degrees)
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CalendarDayItem extends StatelessWidget {
  final String day;
  final bool isActive;
  final double progress;

  const CalendarDayItem({
    super.key,
    required this.day,
    this.isActive = false,
    this.progress = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: AppConstants.calendarItemSize + 10,
          height: AppConstants.calendarItemSize + 10,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 1, // Made thinner
            backgroundColor:
                AppColors.white, // Changed from grey[300] to match background
            valueColor: AlwaysStoppedAnimation<Color>(
              isActive ? AppColors.primaryGreen : Colors.black,
            ),
          ),
        ),
        Container(
          width: isActive
              ? AppConstants.calendarItemSize + 6
              : AppConstants.calendarItemSize,
          height: isActive
              ? AppConstants.calendarItemSize + 6
              : AppConstants.calendarItemSize,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryGreen : AppColors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              day,
              style: AppTextStyles.calendarDay.copyWith(
                color: isActive ? AppColors.white : AppColors.darkText,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MealItemCard extends StatelessWidget {
  final String foodName;
  final String calories;
  final String carbs;
  final String protein;
  final String fat;
  final String imagePlaceholder;

  const MealItemCard({
    super.key,
    required this.foodName,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.imagePlaceholder,
  });

  @override
  Widget build(BuildContext context) {
    // Add emoji based on food name
    String emoji = '';

    // Special handling for Grilled Chicken Salad and Oatmeal
    Widget titleWidget;
    if (foodName.contains('Grilled Chicken Salad')) {
      titleWidget = Row(
        children: [
          Text(
            foodName,
            style: AppTextStyles.foodTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: 4),
          Image.asset(
            'assets/Grilled_Chicken_Salad_1.png',
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
        ],
      );
    } else if (foodName.contains('Oatmeal')) {
      titleWidget = Row(
        children: [
          Text(
            foodName,
            style: AppTextStyles.foodTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: 4),
          Image.asset(
            'assets/Berries_1.png',
            width: 20,
            height: 20,
            fit: BoxFit.contain,
          ),
        ],
      );
    } else {
      titleWidget = Text(
        '$foodName$emoji',
        style: AppTextStyles.foodTitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    return Container(
      width: AppConstants.mealCardWidth + 20,
      height: AppConstants.mealCardHeight,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
      ),
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            // 3D icon with shadow
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: imagePlaceholder == 'placeholder_oatmeal'
                  ? Image.asset(
                      'assets/Food_Bowl_1.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.bakery_dining,
                          color: Color(0xFF8D6E63),
                          size: 12,
                        );
                      },
                    )
                  : imagePlaceholder == 'placeholder_salad'
                  ? Image.asset(
                      'assets/Garlic_chicken.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.restaurant,
                          color: Color(0xFF8D6E63),
                          size: 12,
                        );
                      },
                    )
                  : const Icon(
                      Icons.restaurant,
                      color: Color(0xFF8D6E63),
                      size: 12,
                    ),
            ),
            const SizedBox(width: AppConstants.spacingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title with emoji or image
                  titleWidget,
                  const SizedBox(height: 4),
                  // Calories and macros in the same line
                  Row(
                    children: [
                      // Larger calorie count
                      Text(
                        calories,
                        style: const TextStyle(
                          fontSize: 18, // Increased from 16
                          fontWeight: FontWeight.bold, // Reverted to bold
                          color: Color(0xFF333333),
                        ),
                      ),
                      const Spacer(),
                      // Macronutrient badges inline
                      Row(
                        children: [
                          _buildMacroBadgeWithIcon(
                            Icons.water_drop,
                            AppColors.carbsBlue,
                            carbs,
                          ),
                          const SizedBox(width: 4),
                          _buildMacroBadgeWithIcon(
                            Icons.restaurant_menu,
                            AppColors.proteinPurple,
                            protein,
                          ),
                          const SizedBox(width: 4),
                          _buildMacroBadgeWithIcon(
                            Icons.waves,
                            AppColors.fatPink,
                            fat,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroBadgeWithIcon(IconData icon, Color color, String value) {
    String imagePath;
    if (icon == Icons.water_drop) {
      imagePath = 'assets/Chicken_g.png';
    } else if (icon == Icons.restaurant_menu) {
      imagePath = 'assets/Leaf_g.png';
    } else if (icon == Icons.waves) {
      imagePath = 'assets/Vapour_g.png';
    } else {
      // fallback
      return Icon(icon, size: 12, color: color);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: icon == Icons.water_drop
            ? color.withOpacity(0.15)
            : icon == Icons.restaurant_menu
            ? const Color(0xFFFDEDFD)
            : icon == Icons.waves
            ? const Color(0xFFFFEFF0)
            : color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imagePath, width: 12, height: 12, fit: BoxFit.contain),
          const SizedBox(width: 2),
          Text(
            '${value}g',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.normal, // Changed from w600 to normal
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class MacroIcon extends StatelessWidget {
  final Color color;
  final String value;
  final double size;

  // ignore: use_super_parameters
  const MacroIcon({
    Key? key,
    required this.color,
    required this.value,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(size),
      ),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 20,
            spreadRadius: 0,
          ),
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 8),
            blurRadius: 32,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              // Left side items
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(MdiIcons.homeOutline, 'Home', 0),
                    _buildNavItem(MdiIcons.chartBar, 'Tracker', 1),
                  ],
                ),
              ),
              // Center space for floating button
              const SizedBox(
                width: 78,
              ), // Space for center button (54px + padding)
              // Right side items
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(MdiIcons.foodAppleOutline, 'Habits', 3),
                    _buildNavItem(MdiIcons.cogOutline, 'Settings', 4),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    String imagePath = '';
    if (label == 'Home') {
      imagePath = 'assets/Home.png';
    } else if (label == 'Tracker')
      // ignore: curly_braces_in_flow_control_structures
      imagePath = 'assets/Tracker.png';
    else if (label == 'Habits')
      // ignore: curly_braces_in_flow_control_structures
      imagePath = 'assets/Habits.png';
    else if (label == 'Settings')
      // ignore: curly_braces_in_flow_control_structures
      imagePath = 'assets/Settings.png';

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath, width: 22, height: 22, fit: BoxFit.contain),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Colors.black, // All navigation text black
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
