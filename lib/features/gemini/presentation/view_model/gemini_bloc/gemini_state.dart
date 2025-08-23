part of 'gemini_bloc.dart';

@immutable
sealed class GeminiState extends Equatable {
  final List<GeminiResponseShapeModel> geminiResponse;
  const GeminiState({required this.geminiResponse});
}

final class GeminiInitial extends GeminiState {
  GeminiInitial() : super(geminiResponse: []);

  @override
  List<Object?> get props => [geminiResponse];
}

final class GeminiLoading extends GeminiState {
  final List<GeminiResponseShapeModel>? previousMessages;
  GeminiLoading({this.previousMessages}) : super(geminiResponse: []);

  @override
  List<Object?> get props => [geminiResponse];
}

final class GeminiRecieveResponse extends GeminiState {
  const GeminiRecieveResponse({required super.geminiResponse});

  @override
  List<Object?> get props => [geminiResponse];
}

final class GeminiError extends GeminiState {
  final String errMessage;
  final List<GeminiResponseShapeModel>? response;

  GeminiError({this.response, required this.errMessage})
    : super(geminiResponse: response??[]);

  @override
  List<Object?> get props => [errMessage,geminiResponse];
}
