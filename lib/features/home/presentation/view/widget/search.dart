import 'package:flutter/material.dart';
import 'package:meal_app/core/models/recipe.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/core/utils/app_fonts.dart';

import '../recipe_details_screen.dart';

class CustomSearch extends StatelessWidget {
  final SearchController searchController;
  final Future<List<Recipe>> Function(String query) onSearch;

  const CustomSearch({
    super.key,
    required this.searchController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: searchController,
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          controller: controller,
          padding: const MaterialStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16.0),
          ),
          leading: const Icon(Icons.search),
          hintText: 'Search for recipes...',
          hintStyle: MaterialStatePropertyAll<TextStyle>(
            AppFonts.textStyle13.copyWith(color: Colors.grey),
          ),
          backgroundColor: MaterialStatePropertyAll<Color>(appWhiteColor),
          onTap: () {
            controller.openView();
          },
          onChanged: (_) {
            controller.openView();
          },
        );
      },
      suggestionsBuilder:
          (BuildContext context, SearchController controller) async {
            final query = controller.text;
            if (query.isEmpty) {
              return [Center(child: Text('Enter a recipe name'))];
            }
            try {
              final recipes = await onSearch(query);
              if (recipes.isEmpty) {
                return [Center(child: Text('No recipes found'))];
              }
              return recipes.map((recipe) {
                return ListTile(
                  leading: Image.network(
                    recipe.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      'assets/images/placeholder.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(recipe.title, style: AppFonts.textStyle16),
                  subtitle: Text(
                    '${recipe.readyInMinutes} min',
                    style: AppFonts.textStyle13,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecipeDetailsScreen(recipe: recipe),
                      ),
                    );
                  },
                );
              }).toList();
            } catch (e) {
              return [Center(child: Text('Error: $e'))];
            }
          },
    );
  }
}
