import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meal_app/features/gemini/data/model.dart';
import 'package:meal_app/features/gemini/domain/repo_decl.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class RepoImpl implements RepoDecl {
  final GenerativeModel _model;

  RepoImpl()
    : _model = GenerativeModel(
        model: "gemini-2.0-flash",
        apiKey: "AIzaSyAbF7I-cHkU_EBXZlv23P29pFHwm0yEhfQ",
        generationConfig: GenerationConfig(
          responseMimeType: "application/json",
        ),
      );

  // AIzaSyCY5WBbA4EDbG-YQ-W5kW8hisEUmSBJNbA   (cloud)
  //AIzaSyCE_2j-vGUDY7ReUoIvynwsLJeor3T6_SU    (Ai Studio)

  @override
  Future geminiChat(String text) async {
    final prompt = '''
You are goldenGpt, a professional chef assistant.
Your ONLY job is to return valid JSON data as a SINGLE OBJECT.

Schema when user input is related to cooking:
{
  "Name": "meal name",
  "Summary": "String",
  "Ingrediantes": ["String"],
  "Direction": ["String"],
  "Portien": 0,
  "Carp": 0,
  "Fat": 0,
  "Kcal": 0,
  "Vetaimenes": 0,
  "time:0,
  
}
Special Rule:
- If the user input is UNRELATED to food, recipes, or cooking:
  Always return this simplified JSON:
  {
    "general": "<put your natural response here>"
    
  }
 
    
  

Additional Rules:
- Always return a JSON object, never a list or array.
- Do NOT include markdown, code blocks, or explanations.
- Never add text outside the JSON object.
''';

    final content = [Content.text(prompt)];
    final chat = _model.startChat(history: content);
    final response = await chat.sendMessage(Content.text(text));
    final reply = response.text ?? 'Error: No response';

    final jsonData = jsonDecode(reply);
    if (jsonData.containsKey("Name")) {
      final dishName = jsonData["Name"];
      final imageUrl = await getDishImage(dishName);
      jsonData["image"] = imageUrl ?? ""; // overwrite AI’s image
    }
    return GeminiResponseShapeModel.fromJson(jsonData);
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
        log(json['results'][0]['image']);
        return json['results'][0]['image'];
      } else {
        return null;
      }
    } catch (e) {
      log("Error: $e");
      return null;
    }
  }
}
