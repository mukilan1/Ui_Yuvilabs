import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import '../utils/constants.dart';
import '../widgets/statistics_widgets.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: AppConstants.spacingLarge),
              _buildTabBar(),
              const SizedBox(height: AppConstants.spacingLarge),
              _buildNutritionSection(),
              const SizedBox(height: AppConstants.spacingLarge),
              _buildBodyFatSection(),
              const SizedBox(height: AppConstants.spacingLarge),
              _buildAnalyticsButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Text('Statistic', style: AppTextStyles.headerMedium)],
      ),
    );
  }

  Widget _buildTabBar() {
    return CustomTabBar(
      tabs: AppConstants.tabLabels,
      selectedIndex: selectedTabIndex,
      onTabSelected: (index) {
        setState(() {
          selectedTabIndex = index;
        });
      },
    );
  }

  Widget _buildNutritionSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
      ),
      child: StatCard(
        title: 'Nutrition',
        value: '2,840',
        subtitle: 'Daily Average: 2,100 cal',
        chart: NutritionBarChart(
          values: const [80, 95, 70, 85, 90, 75, 100],
          labels: AppConstants.weekDays,
          maxValue: 100,
        ),
      ),
    );
  }

  Widget _buildBodyFatSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
      ),
      child: StatCard(
        title: 'Body Fat',
        value: '83 kg',
        subtitle: '–1 kg this week',
        chart: BodyFatLineChart(
          values: const [85, 84.5, 84, 83.5, 83, 82.8, 83],
          labels: const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
          currentValue: 83,
        ),
      ),
    );
  }

  Widget _buildAnalyticsButton() {
    return AnalyticsButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Starting AI Analytics...'),
            backgroundColor: AppColors.primaryGreen,
          ),
        );
      },
    );
  }
}
