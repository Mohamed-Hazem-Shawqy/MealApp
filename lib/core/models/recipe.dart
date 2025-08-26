import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable()
class Recipe {
  final int id;
  final String title;
  final String image;
  final String? diet;
  final int? readyInMinutes;
  final int? usedIngredientCount;
  final int? missedIngredientCount;

  Recipe({
    required this.id,
    required this.title,
    required this.image,
    this.diet,
    this.readyInMinutes,
    this.usedIngredientCount,
    this.missedIngredientCount,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}
