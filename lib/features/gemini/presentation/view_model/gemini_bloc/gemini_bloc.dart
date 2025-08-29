import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/features/gemini/data/repo_impl.dart';
import 'package:meal_app/features/gemini/data/model.dart';

part 'gemini_event.dart';
part 'gemini_state.dart';

class GeminiBloc extends Bloc<GeminiEvent, GeminiState> {
  final RepoImpl repo;
  GeminiBloc(this.repo) : super(GeminiInitial()) {
    on<GeminiRsponseEvent>((event, emit) async {
      emit(GeminiLoading());
      try {
        final res = await repo.askGemini(event.text);
        emit(GeminiRecieveResponse(geminiResponse: res));
      } catch (e) {
        emit(GeminiError(e.toString()));
      }
    });
  }
}
