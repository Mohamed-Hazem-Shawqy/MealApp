import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/onboarding/widget/blue_curve_clipper.dart';
import 'package:meal_app/features/onboarding/widget/onboarding_header.dart';
import 'package:meal_app/features/onboarding/widget/onboarding_image_section.dart';
import 'package:meal_app/features/onboarding/widget/onboarding_navigation.dart';
import 'package:meal_app/features/onboarding/widget/onboarding_text_section.dart';

class OnboardingScreenOne extends StatelessWidget {
  const OnboardingScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: appWhiteColor,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          ClipPath(
            clipper: BlueCurveClipper(),
            child: Container(height: screenHeight * 0.5, color: appBlueColor),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.03),
                  OnboardingHeader(screenWidth: screenWidth),
                  const Spacer(flex: 10),
                  OnboardingTextSection(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  const Spacer(flex: 2),
                  OnboardingNavigation(currentPage: 0),
                ],
              ),
            ),
          ),
          OnboardingImageSection(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            image:
                'assets/images/onboardingimages/well-done-steak-homemade-potatoes 1@2x.png',
          ),
        ],
      ),
    );
  }
}
