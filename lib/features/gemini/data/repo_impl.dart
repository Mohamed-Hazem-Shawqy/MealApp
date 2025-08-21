import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:meal_app/features/gemini/domain/repo_decl.dart';

class RepoImpl implements RepoDecl {
  @override
  Future<String> geminiChat(String text) async {
    final gemini = Gemini.instance;

    final response = await gemini.chat([
      Content(parts: [Part.text(text)], role: 'user'),
      Content(parts: [Part.text(text)], role: 'model'),
    ]);
    return response?.output ?? "No response";
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
