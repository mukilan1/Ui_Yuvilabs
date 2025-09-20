import 'package:flutter/material.dart';
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
    Key? key,
    required this.title,
    required this.value,
    required this.backgroundColor,
    required this.iconColor,
    required this.icon,
  }) : super(key: key);

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

class CalendarDayItem extends StatelessWidget {
  final String day;
  final bool isActive;

  const CalendarDayItem({Key? key, required this.day, this.isActive = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.calendarItemSize,
      height: AppConstants.calendarItemSize,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryGreen : AppColors.lightGrey,
        shape: BoxShape.circle,
      ),
      child: Center(child: Text(day, style: AppTextStyles.calendarDay)),
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
    Key? key,
    required this.foodName,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.imagePlaceholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.mealCardWidth,
      height: AppConstants.mealCardHeight,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        boxShadow: const [AppShadows.cardShadow],
      ),
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Row(
        children: [
          Container(
            width: AppConstants.foodImageSmall,
            height: AppConstants.foodImageSmall,
            decoration: const BoxDecoration(
              color: AppColors.lightGrey,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: imagePlaceholder == 'placeholder_oatmeal'
                  ? Image.asset(
                      'assets/images/oatmeal.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.fastfood,
                          color: AppColors.mutedText,
                          size: 24,
                        );
                      },
                    )
                  : const Icon(
                      Icons.restaurant,
                      color: AppColors.mutedText,
                      size: 24,
                    ),
            ),
          ),
          const SizedBox(width: AppConstants.spacingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(foodName, style: AppTextStyles.foodTitle),
                const SizedBox(height: 4),
                Text(calories, style: AppTextStyles.foodCalories),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  _buildMacroIcon(AppColors.carbsBlue, carbs),
                  const SizedBox(width: 4),
                  _buildMacroIcon(AppColors.proteinPurple, protein),
                  const SizedBox(width: 4),
                  _buildMacroIcon(AppColors.fatPink, fat),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroIcon(Color color, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        value,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class MacroIcon extends StatelessWidget {
  final Color color;
  final String value;
  final double size;

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
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 20,
            spreadRadius: 0,
          ),
          BoxShadow(
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
                    _buildNavItem(Icons.home_outlined, 'Home', 0),
                    _buildNavItem(Icons.bar_chart_outlined, 'Tracker', 1),
                  ],
                ),
              ),
              // Center space for floating button
              const SizedBox(
                width: 80,
              ), // Space for center button (56px + padding)
              // Right side items
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(Icons.favorite_outline, 'Habits', 3),
                    _buildNavItem(Icons.settings_outlined, 'Settings', 4),
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
    final isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive
                  ? const Color(0xFF7BD48C)
                  : const Color(0xFF9CA3AF),
              size: 24,
              weight: 1.5, // Thin line icons
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? const Color(0xFF7BD48C)
                    : const Color(0xFF9CA3AF),
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
