import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/models/recipe.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/core/utils/app_fonts.dart';
import 'package:meal_app/features/home/domain/entites/foodCategory.dart';
import 'package:meal_app/features/home/presentation/view_model/bloc/taskBloc.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailsScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final food = Food(
      imagePath: recipe.image,
      foodKind: recipe.diet ?? 'Unknown',
      foodName: recipe.title,
      ingredients:
          "${(recipe.usedIngredientCount ?? 0) + (recipe.missedIngredientCount ?? 0)} ingredients",
      time: recipe.readyInMinutes.toString(),
    );

    return Scaffold(
      backgroundColor: appWhiteColor,
      appBar: AppBar(
        title: Text(recipe.title, style: AppFonts.textStyle16),
        backgroundColor: appBlueColor,
        actions: [
          IconButton(
            icon: Icon(
              context.read<TaskBloc>().isFavorite(food)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              context.read<TaskBloc>().toggleFavorite(food);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              recipe.image,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset("assets/images/placeholder.png", height: 250),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.title, style: AppFonts.textStyle18),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.timer, color: appBlueColor),
                      SizedBox(width: 5),
                      Text(
                        "${recipe.readyInMinutes} min",
                        style: AppFonts.textStyle13,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.shopping_bag, color: appBlueColor),
                      SizedBox(width: 5),
                      Text(
                        "${(recipe.usedIngredientCount ?? 0) + (recipe.missedIngredientCount ?? 0)} ingredients",
                        style: AppFonts.textStyle13,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Description:",
                    style: AppFonts.textStyle16.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    recipe.diet ?? "No description available",
                    style: AppFonts.textStyle13,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
