import 'package:equatable/equatable.dart';
import 'package:meal_app/features/productdetails/doamin/entits/meal.dart';

abstract class MealDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MealDetailsInitial extends MealDetailsState {}

class MealDetailsLoading extends MealDetailsState {}

class MealDetailsLoaded extends MealDetailsState {
  final Meal meal;
  MealDetailsLoaded(this.meal);

  @override
  List<Object?> get props => [meal];
}

class MealDetailsError extends MealDetailsState {
  final String message;
  MealDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
