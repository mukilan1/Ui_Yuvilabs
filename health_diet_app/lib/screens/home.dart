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
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: AppConstants.spacingSmall),
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
            const Icon(Icons.search, color: AppColors.darkText, size: 24),
            const SizedBox(width: 16),
            const Icon(
              Icons.notifications_outlined,
              color: AppColors.darkText,
              size: 24,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCalendarRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        border: Border.all(color: AppColors.lightGrey, width: 1),
      ),
      child: Column(
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
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkText,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          // Day numbers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(7, (index) {
              final dayNumbers = ['13', '14', '15', '16', '17', '18', '19'];
              final progressList = [0.1, 0.3, 0.5, 0.8, 0.6, 0.9, 0.2];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDayIndex = index;
                  });
                },
                child: CalendarDayItem(
                  day: dayNumbers[index],
                  isActive: selectedDayIndex == index,
                  progress: progressList[index],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyOverviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Daily Overview', style: AppTextStyles.headerSmall),
        const SizedBox(height: AppConstants.paddingSmall),
        Row(
          children: [
            // Large Carbs card on the left
            Expanded(
              flex: 3,
              child: Container(
                height: 190,
                margin: const EdgeInsets.only(right: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFC6E7FE), // New carbs color
                  borderRadius: BorderRadius.circular(
                    AppConstants.radiusMedium,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(
                        0xFFC6E7FE,
                      ).withOpacity(0.3), // Matching glow
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.bakery_dining,
                        color: Color(0xFF1976D2), // Blue color
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 8), // Reduced spacing
                    const Text(
                      'Carbs',
                      style: TextStyle(
                        fontSize: 14, // Reduced from 16
                        fontWeight: FontWeight.normal, // Changed to normal
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 2), // Reduced spacing
                    const Text(
                      '120 g / 250 g',
                      style: TextStyle(
                        fontSize: 16, // Reduced from 18
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Right side stacked cards
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  // Protein card
                  Container(
                    height: 90, // Increased by 10
                    margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                    width: 180,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFCC7FF), // New protein color
                      borderRadius: BorderRadius.circular(
                        AppConstants.radiusMedium,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFFFCC7FF,
                          ).withOpacity(0.3), // Matching glow
                          offset: const Offset(0, 4),
                          blurRadius: 12,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 3D salmon icon
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.restaurant,
                            color: Color(0xFFE91E63), // Pink color
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Protein',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight:
                                    FontWeight.normal, // Changed to normal
                                color: Colors.black,
                              ),
                            ),
                            const Text(
                              '65 g / 100 g',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Fat card
                  Container(
                    height: 90, // Increased by 10
                    width: 180,
                    margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD8DA), // New fat color
                      borderRadius: BorderRadius.circular(
                        AppConstants.radiusMedium,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFFFFD8DA,
                          ).withOpacity(0.3), // Matching glow
                          offset: const Offset(0, 4),
                          blurRadius: 12,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.egg,
                            color: Color(0xFFFF9800), // Orange color
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Fat',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight:
                                    FontWeight.normal, // Changed to normal
                                color: Colors.black,
                              ),
                            ),
                            const Text(
                              '40 g / 70 g',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
