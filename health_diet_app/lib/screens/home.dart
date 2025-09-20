import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import '../utils/constants.dart';
import '../widgets/dashboard_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedDayIndex = 3; // 16 selected by default (index 3 = 16)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: AppConstants.spacingLarge),
              _buildCalendarRow(),
              const SizedBox(height: AppConstants.spacingLarge),
              _buildDailyOverviewSection(),
              const SizedBox(height: AppConstants.spacingLarge),
              _buildRecentlyLoggedSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: AppConstants.profileImageSize,
          height: AppConstants.profileImageSize,
          decoration: const BoxDecoration(
            color: AppColors.lightGrey,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.person, color: AppColors.mutedText, size: 24),
        ),
        const SizedBox(width: AppConstants.paddingSmall),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Good Morning 👋',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: AppColors.mutedText,
                ),
              ),
              const Text(
                'Maria Joyce',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkText,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.search,
                color: AppColors.darkText,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.notifications_outlined,
                color: AppColors.darkText,
                size: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCalendarRow() {
    return Column(
      children: [
        // Week day labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) {
            return SizedBox(
              width: AppConstants.calendarItemSize,
              child: Text(
                day,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mutedText,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        // Day numbers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(7, (index) {
            final dayNumbers = ['13', '14', '15', '16', '17', '18', '19'];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedDayIndex = index;
                });
              },
              child: CalendarDayItem(
                day: dayNumbers[index],
                isActive: selectedDayIndex == index,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildDailyOverviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Daily Overview', style: AppTextStyles.headerSmall),
        const SizedBox(height: AppConstants.paddingSmall),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: AppConstants.spacingMedium,
          crossAxisSpacing: AppConstants.spacingMedium,
          childAspectRatio: AppConstants.dailyCardWidth / AppConstants.dailyCardHeight,
          children: [
            DailyOverviewCard(
              title: 'Carbs',
              value: '120 g / 250 g',
              backgroundColor: AppColors.carbsBackground,
              iconColor: AppColors.primaryBlue,
              icon: Icons.bakery_dining,
            ),
            DailyOverviewCard(
              title: 'Protein',
              value: '65 g / 100 g',
              backgroundColor: AppColors.proteinBackground,
              iconColor: AppColors.primaryPink,
              icon: Icons.fitness_center,
            ),
            DailyOverviewCard(
              title: 'Fat',
              value: '40 g / 70 g',
              backgroundColor: AppColors.fatBackground,
              iconColor: AppColors.primaryOrange,
              icon: Icons.opacity,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentlyLoggedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recently Logged', style: AppTextStyles.headerSmall),
        const SizedBox(height: AppConstants.paddingSmall),
        Column(
          children: AppConstants.sampleMeals.map((meal) {
            return Container(
              margin: const EdgeInsets.only(bottom: AppConstants.spacingMedium),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/meal-detail', arguments: meal);
                },
                child: MealItemCard(
                  foodName: meal['name'],
                  calories: meal['calories'],
                  carbs: meal['carbs'],
                  protein: meal['protein'],
                  fat: meal['fat'],
                  imagePlaceholder: meal['image'],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
