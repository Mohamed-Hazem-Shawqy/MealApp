import 'package:meal_app/features/productdetails/doamin/entits/meal.dart';

import '../repositories/meal_repository.dart';

class GetMealDetails {
  final MealRepository repository;

  GetMealDetails(this.repository);

  Future<Meal> call(String id) {
    return repository.getMealDetails(id);
  }
}
