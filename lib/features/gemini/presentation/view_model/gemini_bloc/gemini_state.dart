part of 'gemini_bloc.dart';

abstract class GeminiState extends Equatable {
  const GeminiState();
  @override
  List<Object?> get props => [];
}

class GeminiInitial extends GeminiState {}

class GeminiLoading extends GeminiState {}

class GeminiRecieveResponse extends GeminiState {
  final List<GeminiResponseShapeModel> geminiResponse;
  const GeminiRecieveResponse({required this.geminiResponse});
  @override
  List<Object?> get props => [geminiResponse];
}

class GeminiError extends GeminiState {
  final String message;
  const GeminiError(this.message);
  @override
  List<Object?> get props => [message];
}
