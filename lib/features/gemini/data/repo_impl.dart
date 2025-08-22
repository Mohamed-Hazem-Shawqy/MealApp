import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meal_app/features/gemini/domain/repo_decl.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class RepoImpl implements RepoDecl {
  final GenerativeModel _model;

  RepoImpl()
    : _model = GenerativeModel(
        model: "gemini-2.0-flash",
        apiKey: "AIzaSyAbF7I-cHkU_EBXZlv23P29pFHwm0yEhfQ",
      );
  final prompt = '''
You are a nutrition assistant. 
Your behavior is strictly defined as follows:

1. If the user provides ingredients (e.g., "rice and chicken"), 
   respond ONLY with a valid JSON object that matches this exact Dart class structure:

{
  "id": "unique_id",
  "name": "Meal Name",
  "category": "Meal Category",
  "cookingTime": 30,
  "servings": 2,
  "imageUrl": "https://example.com/image.jpg",
  "summary": "Short description of the meal",
  "nutritions": [
    { "name": "Calories", "amount": "500 kcal" },
    { "name": "Protein", "amount": "25 g" }
  ],
  "ingredients": [
    { "name": "Rice", "quantity": "1 cup" },
    { "name": "Chicken", "quantity": "200 g" }
  ],
  "directions": [
    { "stepNumber": 1, "description": "Wash the rice thoroughly." },
    { "stepNumber": 2, "description": "Cook the chicken with spices." }
  ]
}

⚠️ Important rules:
- Do not include any text outside of the JSON. 
- Do not explain. 
- Return ONLY the JSON.

2. If the user writes normal text (like greetings, questions, or casual talk),
   respond normally with text (not JSON).

''';

  @override
  Future<String> geminiChat(String text) async {
    final content = [Content.text(prompt)];
    final chat = _model.startChat(history: content);
    final response = await chat.sendMessage(Content.text(text));
    return response.text ?? 'Error: No response';
  }

  @override
  void scrollToBottom(ScrollController scrollController) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<String?> getDishImage(String dishName) async {
    const String baseUrl = 'api.spoonacular.com';
    const String imageUrl = '/recipes/complexSearch';

    Uri url = Uri.https(baseUrl, imageUrl, {
      'apiKey': 'e2a21c9bc1754ab9bd830d5d65bf7a7d',
      'query': dishName,
      'number': '1',
    });

    try {
      final response = await http.get(url);
      final json = jsonDecode(response.body);

      if (json['results'] != null && json['results'].isNotEmpty) {
        return json['results'][0]['image'];
      } else {
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
