import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:meal_app/features/gemini/data/model.dart';

class RepoImpl {
  final String apiKey = "100f65ea2f48435abeb9cb149b8adc38"; // 🔑 ضع مفتاحك هنا

  Future<List<GeminiResponseShapeModel>> askGemini(String prompt) async {
    if (prompt.trim().isEmpty) {
      return [GeminiResponseShapeModel.general("Please enter a message.")];
    }

    final lowerPrompt = prompt.toLowerCase().trim();

    // ✅ الردود العامة
    if (lowerPrompt.contains("hello") || lowerPrompt.contains("hi")) {
      return [GeminiResponseShapeModel.general("Hello! How can I help you?")];
    }

    // ✅ جلب وصفة من Spoonacular
    final query = Uri.encodeComponent(prompt);
    final url = Uri.parse(
      "https://api.spoonacular.com/recipes/complexSearch?query=$query&number=1&addRecipeInformation=true&apiKey=$apiKey",
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["results"] != null && data["results"].isNotEmpty) {
        final recipe = data["results"][0];

        // معالجة التغذية بطريقة آمنة
        final nutrients =
            recipe["nutrition"]?["nutrients"] as List<dynamic>? ?? [];

        String getNutrient(int index) {
          if (nutrients.length > index && nutrients[index]?["amount"] != null) {
            return nutrients[index]["amount"].toString();
          }
          return "N/A";
        }

        return [
          GeminiResponseShapeModel(
            isGeneral: false,
            message: recipe["title"] ?? "",
            summary: recipe["summary"] ?? "",
            protein: recipe["servings"]?.toString() ?? "",
            carp: getNutrient(0),
            fat: getNutrient(1),
            kcal: getNutrient(2),
            vetaimenes: "N/A",
            image: recipe["image"] ?? "",
            ingrediantes: List<String>.from(
              (recipe["extendedIngredients"] as List<dynamic>? ?? []).map(
                (ing) => ing["original"].toString(),
              ),
            ),
            direction: recipe["instructions"] ?? "",
            time: recipe["readyInMinutes"]?.toString() ?? "",
          ),
        ];
      } else {
        return [
          GeminiResponseShapeModel.general(
            "I couldn’t find a recipe for $prompt.",
          ),
        ];
      }
    } else {
      print("Spoonacular Error: ${response.body}"); // لمعرفة الخطأ الحقيقي
      return [GeminiResponseShapeModel.general("Error fetching recipes.")];
    }
  }

  void scrollToBottom(ScrollController controller) {
    if (!controller.hasClients) return;
    controller.animateTo(
      controller.position.maxScrollExtent + 200,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }
}
