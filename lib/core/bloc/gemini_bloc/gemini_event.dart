part of 'gemini_bloc.dart';

@immutable
sealed class GeminiEvent extends Equatable {
  const GeminiEvent();
}

class GeminiRsponseEvent extends GeminiEvent {
  final String response;

  const GeminiRsponseEvent({required this.response});

  @override
  List<Object?> get props => [response];
}
