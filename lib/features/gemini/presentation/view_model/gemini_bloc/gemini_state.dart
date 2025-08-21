part of 'gemini_bloc.dart';

@immutable
sealed class GeminiState {}

final class GeminiInitial extends GeminiState {}

final class GeminiLoading extends GeminiState {}

final class GeminiRecieveResponse extends GeminiState {

    final String geminiResponse;
  

  GeminiRecieveResponse({ required this.geminiResponse });
}

final class GeminiError extends GeminiState {
  final String errMessage;

  GeminiError({required this.errMessage});
}
