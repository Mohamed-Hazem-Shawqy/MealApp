import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';

class OnboardingTextSection extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const OnboardingTextSection({
    required this.screenWidth,
    required this.screenHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'like in a Restaurant but at home',
          style: TextStyle(
            fontSize: screenWidth * 0.055,
            fontWeight: FontWeight.bold,
            color: appBlueColor,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: screenHeight * 0.02),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
          child: Text(
            'consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea qui officia deserunt mollit anim id est laborum.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              color: appBlueColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
