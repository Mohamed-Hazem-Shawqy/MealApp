import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:meta/meta.dart';

part 'gemini_event.dart';
part 'gemini_state.dart';

class GeminiBloc extends Bloc<GeminiEvent, GeminiState> {
  GeminiBloc() : super(GeminiInitial()) {
    on<GeminiRsponseEvent>((event, emit) async {
      emit(GeminiLoading());

      try {
        final gemini = Gemini.instance;

        final response = await gemini.chat([
          Content(parts: [Part.text(event.response)], role: 'user'),
        ]);
        final reply = response?.output ?? "No response";
        emit(GeminiRecieveResponse(geminiResponse: reply));
      } catch (e) {
        emit(GeminiError(errMessage: e.toString()));
      }
    });
  }
}
