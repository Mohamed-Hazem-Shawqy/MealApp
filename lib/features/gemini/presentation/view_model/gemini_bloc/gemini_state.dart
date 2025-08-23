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
  final bool isMeal; // ⬅️ يفرق بين الرد العادي و الـ JSON
  final Map<String, dynamic>? meal; // ⬅️ لو Meal JSON موجود
  final String? imageUrl;
    const GeminiRecieveResponse({
    required super.geminiResponse,
    this.isMeal = false,
    this.meal,
    this.imageUrl,
  });
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
