part of 'gemini_bloc.dart';

abstract class GeminiEvent extends Equatable {
  const GeminiEvent();
  @override
  List<Object?> get props => [];
}

/// اسم الحدث مطابق تمامًا لاستخدامك الحالي في InputField
class GeminiRsponseEvent extends GeminiEvent {
  final String text;
  const GeminiRsponseEvent(this.text);
  @override
  List<Object?> get props => [text];
}
