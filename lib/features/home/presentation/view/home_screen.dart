import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/models/recipe.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/core/utils/app_fonts.dart';
import 'package:meal_app/features/home/domain/entites/foodCategory.dart';
import 'package:meal_app/features/home/presentation/view/recipe_details_screen.dart';
import 'package:meal_app/features/home/presentation/view/widget/custom_button.dart';
import 'package:meal_app/features/home/presentation/view/widget/custom_card.dart';
import 'package:meal_app/features/home/presentation/view/widget/search.dart';
import 'package:meal_app/features/home/presentation/view_model/bloc/taskBloc.dart';
import 'package:meal_app/services/spoonacular_service.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  final SearchController _searchController = SearchController();
  final SpoonacularService _spoonacularService = SpoonacularService();

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
                searchController: _searchController,
                onSearch: (query) async {
                  final recipes = await _spoonacularService.searchRecipes(
                    query,
                  );
                  return recipes;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 145.0),
                child: CustomButton(
                  text: 'Add Your Ingredients',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Add ingredients feature not implemented yet',
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Top Recipes", style: AppFonts.textStyle18),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('View all recipes not implemented yet'),
                        ),
                      );
                    },
                    child: Text("See All", style: AppFonts.textStyle16),
                  ),
                ],
              ),
              FutureBuilder<List<Recipe>>(
                future: _spoonacularService.searchRecipes('pizza'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No recipes found'));
                  }
                  final recipes = snapshot.data!;
                  return Column(
                    children: recipes.map((recipe) {
                      final food = Food(
                        imagePath: recipe.image,
                        foodKind: recipe.diet ?? 'Unknown',
                        foodName: recipe.title,
                        ingredients:
                            "${(recipe.usedIngredientCount ?? 0) + (recipe.missedIngredientCount ?? 0)} ingredients",
                        time: recipe.readyInMinutes.toString(),
                      );
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  RecipeDetailsScreen(recipe: recipe),
                            ),
                          );
                        },
                        child: CustomCard(
                          imagePath: recipe.image,
                          foodKind: recipe.diet ?? 'Unknown',
                          foodName: recipe.title,
                          ingredients:
                              "${(recipe.usedIngredientCount ?? 0) + (recipe.missedIngredientCount ?? 0)} ingredients",
                          time: recipe.readyInMinutes.toString(),
                          isFavorite: context.read<TaskBloc>().isFavorite(food),
                          onFavoritePressed: () {
                            context.read<TaskBloc>().toggleFavorite(food);
                          },
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
