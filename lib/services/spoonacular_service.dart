import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meal_app/core/models/recipe.dart';

class SpoonacularService {
  final String apiKey = '100f65ea2f48435abeb9cb149b8adc38';
  final String baseUrl = 'https://api.spoonacular.com';

  Future<List<Recipe>> searchRecipes(String query) async {
    final url = Uri.parse(
      '$baseUrl/recipes/complexSearch?apiKey=$apiKey&query=$query&number=10',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching recipes: $e');
    }
  }

  Future<List<Recipe>> searchRecipesByIngredients(
    List<String> ingredients,
  ) async {
    final ingredientsQuery = ingredients.join(',');
    final url = Uri.parse(
      '$baseUrl/recipes/findByIngredients?apiKey=$apiKey&ingredients=$ingredientsQuery&number=10',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> results = jsonDecode(response.body);
        return results.map((json) => Recipe.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching recipes: $e');
    }
  }
}
