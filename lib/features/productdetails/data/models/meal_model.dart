import 'package:meal_app/features/productdetails/doamin/entits/meal.dart';


class MealModel extends Meal {
  MealModel({
    required super.id,
    required super.name,
    required super.category,
    required super.cookingTime,
    required super.servings,
    required super.imageUrl,
    required super.summary,
    required super.nutritions,
    required super.ingredients,
    required super.directions,
  });

  factory MealModel.demo() {
    return MealModel(
      id: '1',
      name: 'Shawrma',
      category: 'meat',
      cookingTime: 14,
      servings: 1,
      imageUrl: 'assets/images/onboardingimages/view-tasty-shawarma-dish 2.png',
      summary: ', consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum nutrations',
      nutritions: [
        Nutrition(name: 'Protein', amount: '40g'),
        Nutrition(name: 'Carb', amount: '40g'),
        Nutrition(name: 'Fat', amount: '40g'),
        Nutrition(name: 'Sugar', amount: '40g'),
        Nutrition(name: 'Vitamin', amount: '20mg'),
      ],
      ingredients: [
        Ingredient(name: 'bread', quantity: '2 pcs'),
        Ingredient(name: 'tomato', quantity: '2 pcs'),
        Ingredient(name: 'carrot', quantity: '2 pcs'),
      ],
      directions: [
        DirectionStep(stepNumber: 1, description: ', consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum'),
        DirectionStep(stepNumber: 2, description: ', consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum'),
      ],
    );
  }
}
