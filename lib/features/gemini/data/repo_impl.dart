import 'package:flutter/material.dart';
import 'package:meal_app/features/gemini/domain/repo_decl.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class RepoImpl implements RepoDecl {
  final GenerativeModel _model;

  RepoImpl()
    : _model = GenerativeModel(
        model: "gemini-2.0-flash",
        apiKey: "AIzaSyAbF7I-cHkU_EBXZlv23P29pFHwm0yEhfQ",
      );

  // AIzaSyCY5WBbA4EDbG-YQ-W5kW8hisEUmSBJNbA   (cloud)
  //AIzaSyCE_2j-vGUDY7ReUoIvynwsLJeor3T6_SU    (Ai Studio)

  @override
  Future<String> geminiChat(String text) async {
    final prompt = '''You are ChefGPT, a professional chef.
      Give cooking advice and recipes. 
      Always introduce yourself as goldenGpt, the cooking assistant.''';

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