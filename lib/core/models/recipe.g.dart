// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  image: json['image'] as String,
  diet: json['diet'] as String?,
  readyInMinutes: (json['readyInMinutes'] as num?)?.toInt(),
  usedIngredientCount: (json['usedIngredientCount'] as num?)?.toInt(),
  missedIngredientCount: (json['missedIngredientCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'image': instance.image,
  'diet': instance.diet,
  'readyInMinutes': instance.readyInMinutes,
  'usedIngredientCount': instance.usedIngredientCount,
  'missedIngredientCount': instance.missedIngredientCount,
};
