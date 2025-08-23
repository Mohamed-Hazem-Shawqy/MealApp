class GeminiResponseShapeModel {
  final String name;
  final String summary;
  final List<String> ingrediantes;
  final List<String> direction;
  final int portien;
  final int carp;
  final int fat;
  final int kcal;
  final int vetaimenes;

  GeminiResponseShapeModel({
    required this.name,
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
      name: json['name'] ?? '',
      summary: json['summary'] ?? '',
      ingrediantes: json['ingrediantes'] ?? [],
      direction: json['direction'] ?? [],
      portien: json['portien'] ?? 0,
      carp: json['carp'] ?? 0,
      fat: json['fat'] ?? 0,
      kcal: json['kcal'] ?? 0,
      vetaimenes: json['vetaimenes'] ?? 0,
    );
  }
}
