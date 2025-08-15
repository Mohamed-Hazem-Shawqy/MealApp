import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/features/productdetails/doamin/usecase/get_meal_details.dart';
import 'meal_details_event.dart';
import 'meal_details_state.dart';

class MealDetailsBloc extends Bloc<MealDetailsEvent, MealDetailsState> {
  final GetMealDetails getMealDetails;

  MealDetailsBloc(this.getMealDetails) : super(MealDetailsInitial()) {
    on<LoadMealDetails>((event, emit) async {
      emit(MealDetailsLoading());
      try {
        final meal = await getMealDetails(event.mealId);
        emit(MealDetailsLoaded(meal));
      } catch (e) {
        emit(MealDetailsError(e.toString()));
      }
    });
  }
}
