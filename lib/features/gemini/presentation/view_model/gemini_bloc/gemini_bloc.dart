import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/features/gemini/data/repo_impl.dart';
import 'package:meta/meta.dart';

part 'gemini_event.dart';
part 'gemini_state.dart';

class GeminiBloc extends Bloc<GeminiEvent, GeminiState> {
  GeminiBloc() : super(GeminiInitial()) {
    RepoImpl repoImpl = RepoImpl();
    on<GeminiRsponseEvent>((event, emit) async {
      final List<String> previousMessages = List.from(state.geminiResponse);
      emit(GeminiLoading(previousMessages: previousMessages));

      try {
        final String newResponse = await repoImpl.geminiChat(event.response);
        bool isMeal = false;
        Map<String, dynamic>? meal;
        String? image;

        final cleaned = cleanJsonString(newResponse);

        if (_isJson(cleaned)) {
          final meal = jsonDecode(cleaned);
          isMeal = true;
          final mealName = meal['name'];
          image = await repoImpl.getDishImage(mealName);
        }

        final List<String> lastResponse = List.from(previousMessages)
          ..add(newResponse);

        emit(
          GeminiRecieveResponse(
            geminiResponse: lastResponse,
            isMeal: isMeal,
            meal: meal,
            imageUrl: image,
          ),
        );
      } catch (e) {
        emit(GeminiError(errMessage: e.toString(), response: previousMessages));
      }
    });
  }

  bool _isJson(String str) {
    try {
      final decoded = jsonDecode(str);
      log("is Map<String, dynamic>");
      return decoded is Map<String, dynamic>;
    } catch (_) {
      log("catch");
      return false;
    }
  }

  String cleanJsonString(String raw) {
    return raw.replaceAll("```json", "").replaceAll("```", "").trim();
  }
}
