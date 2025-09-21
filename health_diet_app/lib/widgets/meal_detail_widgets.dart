// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/styles.dart';
import '../utils/constants.dart';

class ServingCounter extends StatefulWidget {
  final int initialValue;
  final Function(int) onChanged;

  const ServingCounter({
    super.key,
    this.initialValue = 1,
    required this.onChanged,
  });

  @override
  State<ServingCounter> createState() => _ServingCounterState();
}

class _ServingCounterState extends State<ServingCounter> {
  late int servingCount;

  @override
  void initState() {
    super.initState();
    servingCount = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            if (servingCount > 1) {
              setState(() {
                servingCount--;
              });
              widget.onChanged(servingCount);
            }
          },
          child: Container(
            width: AppConstants.counterButtonSize,
            height: AppConstants.counterButtonSize,
            decoration: const BoxDecoration(
              color: AppColors.lightGrey,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.remove,
              size: 16,
              color: AppColors.darkText,
            ),
          ),
        ),
        const SizedBox(width: AppConstants.spacingMedium),
        Text('$servingCount', style: AppTextStyles.bodyMedium),
        const SizedBox(width: AppConstants.spacingMedium),
        GestureDetector(
          onTap: () {
            setState(() {
              servingCount++;
            });
            widget.onChanged(servingCount);
          },
          child: Container(
            width: AppConstants.counterButtonSize,
            height: AppConstants.counterButtonSize,
            decoration: const BoxDecoration(
              color: AppColors.lightGrey,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, size: 16, color: AppColors.darkText),
          ),
        ),
      ],
    );
  }
}

class MacroBadge extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const MacroBadge({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: AppConstants.servingBadgeHeight,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
      ),
      child: Center(
        child: Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ),
    );
  }
}

class PrepInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const PrepInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: AppConstants.iconSmall, color: AppColors.bodyText),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.bodyText,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.darkText,
          ),
        ),
      ],
    );
  }
}

class IngredientItem extends StatelessWidget {
  final String name;
  final String amount;
  final IconData icon;

  const IngredientItem({
    super.key,
    required this.name,
    required this.amount,
    this.icon = Icons.circle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.mutedText),
          const SizedBox(width: AppConstants.spacingMedium),
          Expanded(child: Text(name, style: AppTextStyles.bodyRegular)),
          Text(
            amount,
            style: AppTextStyles.bodyRegular.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandableSection extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final bool initiallyExpanded;

  const ExpandableSection({
    super.key,
    required this.title,
    required this.children,
    this.initiallyExpanded = true,
  });

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.paddingSmall),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        boxShadow: const [AppShadows.cardShadow],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title, style: AppTextStyles.headerSmall),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.mutedText,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Column(children: widget.children),
            ),
        ],
      ),
    );
  }
}
