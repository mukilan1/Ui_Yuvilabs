import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import '../utils/constants.dart';
import '../widgets/meal_detail_widgets.dart';

class MealDetailPage extends StatefulWidget {
  final Map<String, dynamic>? mealData;

  const MealDetailPage({Key? key, this.mealData}) : super(key: key);

  @override
  State<MealDetailPage> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  bool isFavorite = false;
  int servingCount = 1;

  @override
  Widget build(BuildContext context) {
    final meal =
        widget.mealData ??
        {
          'name': 'Oatmeal with Berries',
          'calories': '280 cal',
          'carbs': '45g',
          'protein': '8g',
          'fat': '6g',
        };

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopBar(),
              const SizedBox(height: AppConstants.spacingLarge),
              _buildFoodImage(),
              const SizedBox(height: AppConstants.spacingLarge),
              _buildMealInfo(meal),
              const SizedBox(height: AppConstants.spacingLarge),
              _buildServingAndPreparation(),
              const SizedBox(height: AppConstants.spacingLarge),
              _buildIngredientsSection(),
              const SizedBox(height: AppConstants.spacingLarge),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              size: AppConstants.iconSmall,
              color: AppColors.darkText,
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: AppConstants.iconSmall,
                  color: AppColors.favoriteRed,
                ),
              ),
              const SizedBox(width: AppConstants.spacingMedium),
              const Icon(
                Icons.share,
                size: AppConstants.iconSmall,
                color: AppColors.darkText,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFoodImage() {
    return Container(
      width: AppConstants.foodImageLarge,
      height: AppConstants.foodImageLarge,
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        boxShadow: const [AppShadows.imageShadow],
      ),
      child: const Center(
        child: Icon(Icons.fastfood, size: 80, color: AppColors.mutedText),
      ),
    );
  }

  Widget _buildMealInfo(Map<String, dynamic> meal) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
      ),
      child: Column(
        children: [
          Text(
            meal['name'],
            style: AppTextStyles.mealTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.spacingMedium),
          Text(meal['calories'], style: AppTextStyles.caloriesLarge),
          const SizedBox(height: AppConstants.spacingMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MacroBadge(
                label: 'Carbs',
                value: meal['carbs'],
                color: AppColors.primaryBlue,
              ),
              const SizedBox(width: AppConstants.spacingSmall),
              MacroBadge(
                label: 'Protein',
                value: meal['protein'],
                color: AppColors.primaryPurple,
              ),
              const SizedBox(width: AppConstants.spacingSmall),
              MacroBadge(
                label: 'Fat',
                value: meal['fat'],
                color: AppColors.primaryPink,
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMedium),
          const Text(
            'A wholesome breakfast combining creamy oats with fresh berries, providing sustained energy and essential nutrients to start your day right.',
            style: AppTextStyles.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildServingAndPreparation() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          boxShadow: const [AppShadows.cardShadow],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text(
                  'Serving',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.bodyText,
                  ),
                ),
                const SizedBox(height: AppConstants.spacingSmall),
                ServingCounter(
                  initialValue: servingCount,
                  onChanged: (value) {
                    setState(() {
                      servingCount = value;
                    });
                  },
                ),
              ],
            ),
            const PrepInfoItem(
              icon: Icons.timer,
              label: 'Prep',
              value: '5 min',
            ),
            const PrepInfoItem(
              icon: Icons.local_fire_department,
              label: 'Cook',
              value: '3 min',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
      ),
      child: ExpandableSection(
        title: 'Ingredients',
        children: const [
          IngredientItem(
            name: 'Rolled Oats',
            amount: '1/2 cup',
            icon: Icons.grass,
          ),
          IngredientItem(
            name: 'Mixed Berries',
            amount: '120g',
            icon: Icons.circle,
          ),
          IngredientItem(name: 'Honey', amount: '10g', icon: Icons.water_drop),
          IngredientItem(
            name: 'Almond Milk',
            amount: '1 cup',
            icon: Icons.opacity,
          ),
          IngredientItem(
            name: 'Chia Seeds',
            amount: '1 tbsp',
            icon: Icons.circle_outlined,
          ),
        ],
      ),
    );
  }
}
