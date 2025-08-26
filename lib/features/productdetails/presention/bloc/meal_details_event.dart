import 'package:equatable/equatable.dart';

abstract class MealDetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMealDetails extends MealDetailsEvent {
  final String mealId;

  LoadMealDetails(this.mealId);

  @override
  List<Object?> get props => [mealId];
}
