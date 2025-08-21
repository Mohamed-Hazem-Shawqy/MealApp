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
        // القديم  خزن
        final String newResponse = await repoImpl.geminiChat(event.response);
        final List<String> lastResponse = List.from(previousMessages)
          ..add(newResponse);

        emit(GeminiRecieveResponse(geminiResponse: lastResponse));
      } catch (e) {
        emit(GeminiError(errMessage: e.toString(), response: previousMessages));
      }
    });
  }
}
  