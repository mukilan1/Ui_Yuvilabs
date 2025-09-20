import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  // Font Family
  static const String fontFamily = 'Nunito';

  // Header Styles
  static const TextStyle headerLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.darkText,
  );

  static const TextStyle headerMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.darkText,
  );

  static const TextStyle headerSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.darkText,
  );

  // Body Text Styles
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.darkText,
  );

  static const TextStyle bodyRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.bodyText,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: AppColors.mutedText,
    height: 1.5,
  );

  // Greeting Text
  static const TextStyle greeting = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.darkText,
  );

  // Calendar Text
  static const TextStyle calendarDay = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12, // Decreased from 14 to fit smaller containers
    fontWeight: FontWeight.bold,
    color: AppColors.darkText,
  );

  // Card Text
  static const TextStyle cardTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.darkText,
  );

  static const TextStyle cardValue = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.darkText,
  );

  // Food Item Text
  static const TextStyle foodTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal, // Changed from bold to normal
    color: AppColors.darkText,
  );

  static const TextStyle foodCalories = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.mutedText,
  );

  // Meal Detail Text
  static const TextStyle mealTitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.darkText,
  );

  static const TextStyle caloriesLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.darkText,
  );

  // Tab Text
  static const TextStyle tabActive = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  static const TextStyle tabInactive = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.greyText,
  );

  // Button Text
  static const TextStyle buttonText = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
}

class AppShadows {
  static const BoxShadow cardShadow = BoxShadow(
    color: AppColors.shadowColor,
    offset: Offset(0, 2),
    blurRadius: 6,
    spreadRadius: 0,
  );

  static const BoxShadow imageShadow = BoxShadow(
    color: AppColors.shadowColor,
    offset: Offset(0, 4),
    blurRadius: 12,
    spreadRadius: 0,
  );
}
