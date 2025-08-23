class GeminiResponseShapeModel {
  final String general;
  final String mealName;
  final String summary;
  final List<String> ingrediantes;
  final List<String> direction;
  final int portien;
  final int carp;
  final int fat;
  final int kcal;
  final int vetaimenes;

  GeminiResponseShapeModel({
    required this.general,
    required this.mealName,
    required this.summary,
    required this.ingrediantes,
    required this.direction,
    required this.portien,
    required this.carp,
    required this.fat,
    required this.kcal,
    required this.vetaimenes,
  });

  factory GeminiResponseShapeModel.fromJson(Map<String, dynamic> json) {
    return GeminiResponseShapeModel(
      general: json['general']?.toString() ?? '',
      mealName: json['Name']?.toString() ?? '',
      summary: json['Summary']?.toString() ?? '',
      ingrediantes:
          (json['Ingrediantes'] as List?)?.map((e) => e.toString()).toList() ??
          [],
      direction:
          (json['Direction'] as List?)?.map((e) => e.toString()).toList() ?? [],
      portien: json['Portien'] ?? 0,
      carp: json['Carp'] ?? 0,
      fat: json['Fat'] ?? 0,
      kcal: json['Kcal'] ?? 0,
      vetaimenes: json['Vetaimenes'] ?? 0,
    );
  }

  bool get isGeneral => general.isNotEmpty && mealName.isEmpty;
}
