import 'package:meal_app/features/gemini/data/model.dart';

class Food {
  final String imagePath;
  final String foodKind;
  final String foodName;
  final List<String> ingredients;
  final List<String> direction;
  final String time;
  final int portien;
  final int carp;
  final int fat;
  final int kcal;
  final int vetaimenes;
  

  Food({
    required this.portien,
    required this.carp,
    required this.fat,
    required this.kcal,
    required this.vetaimenes,
    required this.imagePath,
    required this.foodKind,
    required this.foodName,
    required this.ingredients,
    required this.direction,
    required this.time,
    
  });

  factory Food.fromjson(Map<String, dynamic> json) {
    return Food(
      imagePath: json['imagePath'] ?? '',
      foodKind: json['foodKind'] ?? "",
      foodName: json['foodName'] ?? '',
      ingredients:
          (json['ingredients'] as List?)?.map((e) => e.toString()).toList() ??
          [],
      direction:
          (json['direction'] as List?)?.map((e) => e.toString()).toList() ?? [],
      time: json['time'] ?? 0,
      portien: json['Portien'] ?? 0,
      carp: json['Carp'] ?? 0,
      fat: json['Fat'] ?? 0,
      kcal: json['Kcal'] ?? 0,
      vetaimenes: json['Vetaimenes'] ?? 0,
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'foodKind': foodKind,
      'foodName': foodName,
      'ingredients': ingredients,
      'direction': direction,
      'time': time,
      'portien': portien,
      'carp': carp,
      'fat': fat,
      'kcal': kcal,
      'vetaimenes': vetaimenes,
    };
  }
}

extension FoodToGeminiMapper on Food {
  GeminiResponseShapeModel toGemini() {
    return GeminiResponseShapeModel(
      general: "",
      mealName: foodName,
      summary: foodKind,
      ingrediantes: ingredients,

      direction: direction,
      portien: portien,
      carp: carp,
      fat: fat,
      kcal: kcal,
      vetaimenes: vetaimenes,
      time: time,
      image: imagePath,
      
    );
  }
}
