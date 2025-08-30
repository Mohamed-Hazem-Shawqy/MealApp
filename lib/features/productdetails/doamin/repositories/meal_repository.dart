import 'package:meal_app/features/productdetails/doamin/entits/meal.dart';

abstract class MealRepository {
  Future<Meal> getMealDetails(String id);
}