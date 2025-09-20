import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import '../utils/constants.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CustomTabBar({
    Key? key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: tabs.asMap().entries.map((entry) {
        final index = entry.key;
        final label = entry.value;
        final isSelected = index == selectedIndex;

        return GestureDetector(
          onTap: () => onTabSelected(index),
          child: Column(
            children: [
              Text(
                label,
                style: isSelected
                    ? AppTextStyles.tabActive
                    : AppTextStyles.tabInactive,
              ),
              const SizedBox(height: 4),
              Container(
                height: 2,
                width: 40,
                color: isSelected ? AppColors.black : Colors.transparent,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class NutritionBarChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;
  final double maxValue;

  const NutritionBarChart({
    Key? key,
    required this.values,
    required this.labels,
    this.maxValue = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.chartHeight,
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: values.asMap().entries.map((entry) {
          final index = entry.key;
          final value = entry.value;
          final label = labels[index];
          final heightPercentage = value / maxValue;

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: AppConstants.chartBarWidth,
                height: (AppConstants.chartHeight - 40) * heightPercentage,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [AppColors.successGreen, AppColors.carbsBlue],
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: AppConstants.paddingSmall),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.mutedText,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class BodyFatLineChart extends StatelessWidget {
  final List<double> values;
  final List<String> labels;
  final double currentValue;

  const BodyFatLineChart({
    Key? key,
    required this.values,
    required this.labels,
    required this.currentValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.lineChartHeight,
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: CustomPaint(
        size: const Size(double.infinity, AppConstants.lineChartHeight),
        painter: LineChartPainter(
          values: values,
          labels: labels,
          currentValue: currentValue,
        ),
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  final List<double> values;
  final List<String> labels;
  final double currentValue;

  LineChartPainter({
    required this.values,
    required this.labels,
    required this.currentValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryPurple
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final pointPaint = Paint()
      ..color = AppColors.primaryPurple
      ..style = PaintingStyle.fill;

    final path = Path();
    final stepX = size.width / (values.length - 1);

    for (int i = 0; i < values.length; i++) {
      final x = i * stepX;
      final y = size.height - (values[i] / 100 * size.height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      if (values[i] == currentValue) {
        canvas.drawCircle(Offset(x, y), 4, pointPaint);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Widget? chart;

  const StatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.subtitle,
    this.chart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.paddingSmall),
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        boxShadow: const [AppShadows.cardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTextStyles.headerSmall),
              Text(subtitle, style: AppTextStyles.bodySmall),
            ],
          ),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(value, style: AppTextStyles.caloriesLarge),
          if (chart != null) ...[
            const SizedBox(height: AppConstants.paddingMedium),
            chart!,
          ],
        ],
      ),
    );
  }
}

class AnalyticsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AnalyticsButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppConstants.buttonHeight,
      margin: const EdgeInsets.all(AppConstants.paddingMedium),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Start analytic with AI',
          style: AppTextStyles.buttonText,
        ),
      ),
    );
  }
}
