import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/core/utils/app_routes.dart';
import 'package:meal_app/features/home/domain/entites/foodCategory.dart';

import 'package:meal_app/features/home/presentation/view/widget/custom_card.dart';

import '../view_model/bloc/bloc_state.dart';
import '../view_model/bloc/taskBloc.dart';

class FavoriteScreen extends StatelessWidget {
  static const String routeName = '/favorite';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, favoritestate) {
        if (favoritestate is TaskLoaded) {
          if (favoritestate.favorites.isEmpty) {
            return Center(child: Text("No favorites yet"));
          }
          return Scaffold(
            backgroundColor: appWhiteColor,
            body: ListView(
              children: favoritestate.favorites
                  .map(
                    (food) => GestureDetector(
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
                        portien: food.portien,
                        vetaimenes: food.vetaimenes,
                        kcal: food.kcal,
                        carp: food.carp,
                        fat: food.fat,
                        time: food.time,
                        imagePath: food.imagePath,
                        ingredients: food.ingredients,
                        direction: food.direction,
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        }
        return Center(child: Text("No favorites yet"));
      },
    );
  }
}
