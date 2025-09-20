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
          'name': 'Oatmeal with Berries 🫐',
          'calories': '250 kcal',
          'carbs': '40g',
          'protein': '10g',
          'fat': '5g',
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
              // Combined content sections without container
              Column(
                children: [
                  _buildMealInfoContent(meal),
                  const SizedBox(height: AppConstants.spacingLarge),
                  _buildServingAndPreparationContent(),
                  const SizedBox(height: AppConstants.spacingLarge),
                  _buildIngredientsSectionContent(),
                ],
              ),
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

  Widget _buildMealInfoContent(Map<String, dynamic> meal) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Row(
        children: [
          // Left Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Oatmeal with Berries ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkText,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            TextSpan(
                              text: '🫐',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.download_outlined,
                      color: Colors.black,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.share_outlined,
                      color: Colors.black,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.spacingSmall),
                // Calorie Count and Macronutrient Badges in same row
                Row(
                  children: [
                    // Calorie Count
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '250',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkText,
                            ),
                          ),
                          TextSpan(
                            text: ' kcal',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: AppColors.darkText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Macronutrient Badges
                    _buildMacroBadge(
                      Icons.water_drop,
                      '40g',
                      AppColors.carbsBlue,
                    ),
                    const SizedBox(width: 8),
                    _buildMacroBadge(
                      Icons.restaurant_menu,
                      '10g',
                      AppColors.proteinPurple,
                    ),
                    const SizedBox(width: 8),
                    _buildMacroBadge(Icons.waves, '5g', AppColors.fatPink),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroBadge(IconData icon, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServingAndPreparationContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
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
          const PrepInfoItem(icon: Icons.timer, label: 'Prep', value: '5 min'),
          const PrepInfoItem(
            icon: Icons.local_fire_department,
            label: 'Cook',
            value: '3 min',
          ),
        ],
      ),
    );
  }

  Widget _buildIngredientsSectionContent() {
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
