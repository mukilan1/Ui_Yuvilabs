import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import '../utils/colors.dart';
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
  int currentPage = 0;

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
      backgroundColor: const Color(0xFFEBF3EC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopBar(),
              _buildFoodImage(),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    _buildMealInfoContent(meal),
                    _buildIngredientsSectionContent(),
                  ],
                ),
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
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                MdiIcons.chevronLeft,
                size: 32.0,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                size: AppConstants.iconSmall,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodImage() {
    return SizedBox(
      height: AppConstants.foodImageLarge * 1.6,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            itemCount: 4,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Center(
                child: Image.asset(
                  'assets/Food_Bowl.png',
                  width: AppConstants.foodImageLarge * 1.6,
                  height: AppConstants.foodImageLarge * 1.6,
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
          Positioned(bottom: 20, child: _buildPageIndicator()),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: currentPage == index ? 36 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == index
                ? const Color(0xFF8ADC97)
                : const Color(0xFFCBD6CE),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
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
                const SizedBox(height: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Warm and wholesome breakfast made from rolled oats simmered until creamy, topped with a mix of fresh berries for natural sweetness, antioxidants, and a burst of flavor',
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Divider(color: Colors.grey[300], thickness: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          // Servings Section
                          Column(
                            children: <Widget>[
                              const Text(
                                'Servings',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                    ),
                                    onPressed: () {},
                                  ),
                                  const Text(
                                    '1',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Preparation Section
                          const Column(
                            children: <Widget>[
                              Text(
                                'Preparation',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text('5 Mins', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          // Cook Section
                          const Column(
                            children: <Widget>[
                              Text(
                                'Cook',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text('20 mins', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                    ),
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
