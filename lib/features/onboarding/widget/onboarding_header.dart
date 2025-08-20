import 'package:flutter/material.dart';

class OnboardingHeader extends StatelessWidget {
  final double screenWidth;

  const OnboardingHeader({required this.screenWidth, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/onboardingimages/Ellipse 39.png',
          width: screenWidth * 0.18,
          height: screenWidth * 0.18,
        ),
        Image.asset(
          'assets/images/onboardingimages/Chef Hat.png',
          width: screenWidth * 0.09,
          height: screenWidth * 0.09,
        ),
      ],
    );
  }
}
