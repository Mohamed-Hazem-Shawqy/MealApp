import 'dart:convert';

import 'package:flutter/material.dart';
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
  "Vetaimenes": 0
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
}



// class RepoImpl implements RepoDecl {
//   @override
//   Future<String> geminiChat(String text) async {
//     final gemini = Gemini.instance;
//     const systemPrompt = '''You are ChefGPT, a professional chef.
//       Give cooking advice and recipes. 
//       Always introduce yourself as goldenGpt, the cooking assistant.''';

//     final response = await gemini.chat([
//       Content(parts: [Part.text(systemPrompt)], role: 'user'), // instructions
//       Content(parts: [Part.text(text)], role: 'user'), // user message
//     ]);
//     return response?.output ?? "No response";
  // }