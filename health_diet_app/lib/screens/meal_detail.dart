// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

class MealDetailPage extends StatefulWidget {
  final Map<String, dynamic>? mealData;

  const MealDetailPage({super.key, this.mealData});

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
                color: const Color(0xFFF6F6F6),
                child: Column(children: [_buildMealInfoContent(meal)]),
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
      padding: const EdgeInsets.only(left: 16.0, top: 20, right: 16.0),
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
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Oatmeal with Berries ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.darkText,
                              ),
                            ),
                            WidgetSpan(
                              child: Image.asset(
                                'assets/Berries_1.png',
                                width: 16,
                                height: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/Download.png',
                          width: 17,
                          height: 17,
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/Share.png',
                          width: 17,
                          height: 17,
                        ),
                      ),
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
                    _buildMacroBadgeWithIcon(
                      Icons.water_drop,
                      AppColors.carbsBlue,
                      '40',
                    ),
                    const SizedBox(width: 8),
                    _buildMacroBadgeWithIcon(
                      Icons.restaurant_menu,
                      AppColors.proteinPurple,
                      '10',
                    ),
                    const SizedBox(width: 8),
                    _buildMacroBadgeWithIcon(
                      Icons.waves,
                      AppColors.fatPink,
                      '5',
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          'Warm and wholesome breakfast made from rolled oats simmered until creamy, topped with a mix of fresh berries for natural sweetness, antioxidants, and a burst of flavor',
                          style: TextStyle(
                            fontSize: 11.2,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4.0,
                          vertical: 8.0,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Servings',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 0),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.remove_circle_outline,
                                            weight: 200,
                                          ),
                                          onPressed: () {},
                                        ),
                                        Text(
                                          '1',
                                          style: TextStyle(fontSize: 11),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.add_circle_outline,
                                            weight: 200,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),

                                Container(
                                  height: 50,
                                  width: 1,
                                  color: Colors.grey[300],
                                ),
                                SizedBox(width: 10),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Preparation',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      '5 Mins',
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Container(
                                  height: 50,
                                  width: 1,
                                  color: Colors.grey[300],
                                ),
                                SizedBox(width: 10),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Cook',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      '20 mins',
                                      style: TextStyle(fontSize: 11),
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
                SizedBox(height: 20),
                SizedBox(
                  height: 300,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Card(
                          color: Color(0xFFFEC777),
                          margin: EdgeInsets.all(8.0),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Directions',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 0,
                        right: 0,
                        child: Card(
                          color: Color(0xFFDAD8FF),
                          margin: EdgeInsets.symmetric(
                            horizontal: 2.0,
                            vertical: 8.0,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Ingredients',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_up,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.0,
                                    horizontal: 0.0,
                                  ),
                                  title: Row(
                                    children: [
                                      Image.asset(
                                        'assets/Honey.png',
                                        width: 28,
                                        height: 28,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Honey',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Text(
                                    '10 gr',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 0.0,
                                  ),
                                  child: Divider(
                                    color: Color(0xFF9593BB),
                                    height: 0.5,
                                    thickness: 1,
                                  ),
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.0,
                                    horizontal: 0.0,
                                  ),
                                  title: Row(
                                    children: [
                                      Image.asset(
                                        'assets/Berries.png',
                                        width: 29,
                                        height: 29,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Berries',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Text(
                                    '120 gr',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 0.0,
                                  ),
                                  child: Divider(
                                    color: Color(0xFF9593BB),
                                    height: 0.5,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacroBadgeWithIcon(IconData icon, Color color, String value) {
    String imagePath;
    BoxDecoration? decoration;

    if (icon == Icons.water_drop) {
      imagePath = 'assets/Chicken_g.png';
      decoration = BoxDecoration(
        color: const Color(0xFFE2F4FF),
        borderRadius: BorderRadius.circular(12),
      );
    } else if (icon == Icons.restaurant_menu) {
      imagePath = 'assets/Leaf_g.png';
      decoration = BoxDecoration(
        color: const Color(0xFFFFEBFF),
        borderRadius: BorderRadius.circular(12),
      );
    } else if (icon == Icons.waves) {
      imagePath = 'assets/Vapour_g.png';
      decoration = BoxDecoration(
        color: const Color(0xFFFEF0F0),
        borderRadius: BorderRadius.circular(12),
      );
    } else {
      // fallback
      return Icon(icon, size: 12, color: color);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: decoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imagePath, width: 13, height: 13, fit: BoxFit.contain),
          const SizedBox(width: 2),
          Text(
            '${value}g',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
