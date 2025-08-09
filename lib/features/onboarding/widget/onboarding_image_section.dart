import 'package:flutter/material.dart';

class OnboardingImageSection extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final String image; 

  const OnboardingImageSection({
    required this.screenWidth,
    required this.screenHeight,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: screenHeight * 0.32,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/onboardingimages/Ellipse 7 (2).png',
            width: screenWidth * 0.5,
            height: screenWidth * 0.5,
          ),
          ClipOval(
            child: Image.asset(
              image,
              width: screenWidth * 0.45,
              height: screenWidth * 0.45,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
