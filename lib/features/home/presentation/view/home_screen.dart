import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_app/core/utils/app_routes.dart';
import 'package:meal_app/features/home/domain/entites/foodCategory.dart';
import 'package:meal_app/features/home/presentation/view/widget/custom_button.dart';
import 'package:meal_app/features/home/presentation/view/widget/custom_card.dart';
import 'package:meal_app/features/home/presentation/view/widget/search.dart';
import 'package:meal_app/features/home/presentation/view_model/bloc/bloc_state.dart';
import 'package:meal_app/features/home/presentation/view_model/bloc/taskBloc.dart';

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

              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, homestate) {
                  if (homestate is TaskLoaded) {
                    return Column(
                      children: homestate.homeFood.map((food) {
                        return GestureDetector(
                          onTap: () {
                            final geminiResponse = food.toGemini();
                            GoRouter.of(context).push(
                              AppRoutes.kMealDetailsPage,
                              extra: geminiResponse,
                            );
                          },
                          child: CustomCard(
                            foodKind: food.foodKind,
                            foodName: food.foodName,

                            time: food.time,
                            imagePath: food.imagePath,
                            ingredients: food.ingredients,
                            direction: food.direction,
                            portien: food.portien,
                            vetaimenes: food.vetaimenes,
                            kcal: food.kcal,
                            carp: food.carp,
                            fat: food.fat,
                          ),
                        );
                      }).toList(),
                    );
                  }
                  return const Center(child: Text("No Recipes Saved Yet"));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
