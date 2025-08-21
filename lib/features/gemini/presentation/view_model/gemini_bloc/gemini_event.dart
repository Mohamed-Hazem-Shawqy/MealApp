part of 'gemini_bloc.dart';

@immutable
sealed class GeminiEvent {}

class GeminiRsponseEvent extends GeminiEvent{
  

  final String response;

  GeminiRsponseEvent({required this.response});

}

