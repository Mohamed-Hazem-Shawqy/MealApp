import 'package:meal_app/features/productdetails/doamin/entits/meal.dart';
import 'package:meal_app/features/productdetails/doamin/repositories/meal_repository.dart';
import '../models/meal_model.dart';

class MealRepositoryImpl implements MealRepository {
  @override
  Future<Meal> getMealDetails(String id) async {
    return Future.value(MealModel.demo());
  }
}
