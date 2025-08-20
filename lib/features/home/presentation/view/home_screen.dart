import 'package:flutter/material.dart';
import 'package:meal_app/features/home/presentation/view/widget/custom_button.dart';
import 'package:meal_app/features/home/presentation/view/widget/custom_card.dart';
import 'package:meal_app/features/home/presentation/view/widget/search.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';

class HomeScreen extends StatelessWidget {
  
  final SearchController _searchController = SearchController();

  final List<Product> products = [
    Product("Pizza"),
    Product("Burger"),
    Product("Pasta"),
    Product("Salad"),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomSearch(
                products: products,
                searchController: _searchController,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 145.0),
                child: CustomButton(
                  text: 'add your ingrediantes',
                  onPressed: () {},
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Top Recipes", style: AppFonts.textStyle18),
                  TextButton(
                    onPressed: () {},
                    child: Text("see all", style: AppFonts.textStyle16),
                  ),
                ],
              ),
              CustomCard(
                imagePath:
                    'assets/images/onboardingimages/pizza-pizza-filled-with-tomatoes-salami-olives 1.png',
                foodKind: 'vegan',
                foodName: 'italian pizza',
                ingredients: '12 ingrediantes',
                time: '30',
              ),
              CustomCard(
                imagePath:
                    'assets/images/onboardingimages/well-done-steak-homemade-potatoes 1@2x.png',
                foodKind: 'mmmm',
                foodName: 'ssssssss',
                ingredients: '12 ingrediantes',
                time: '30',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
