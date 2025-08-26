import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';

class OnboardingNavigation extends StatelessWidget {
  final int currentPage;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingNavigation({
    super.key,
    required this.currentPage,
    required this.onNext,
    required this.onSkip,
  });

  Widget _buildDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? appBlueColor : Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onSkip,
            child: const Text(
              'skip',
              style: TextStyle(
                color: appBlueColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: List.generate(
              4,
              (index) => _buildDot(index == currentPage),
            ),
          ),
          GestureDetector(
            onTap: onNext,
            child: const Text(
              'next',
              style: TextStyle(
                color: appBlueColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
