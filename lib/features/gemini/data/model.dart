class GeminiResponseShapeModel {
  final bool isGeneral;
  final String message;
  final String summary;
  final String protein;
  final String carp;
  final String fat;
  final String kcal;
  final String vetaimenes;
  final String image;
  final List<String> ingrediantes;
  final String direction;
  final String time;

  GeminiResponseShapeModel({
    required this.isGeneral,
    required this.message,
    this.summary = "",
    this.protein = "",
    this.carp = "",
    this.fat = "",
    this.kcal = "",
    this.vetaimenes = "",
    this.image = "",
    List<String>? ingrediantes,
    this.direction = "",
    this.time = "",
  }) : ingrediantes = ingrediantes ?? [];

  factory GeminiResponseShapeModel.general(String message) {
    return GeminiResponseShapeModel(isGeneral: true, message: message);
  }

  String get mealName => message;
}
