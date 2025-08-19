import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entites/foodCategory.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final List<Food> _favorites = [];

  TaskBloc() : super(TaskInitial()) {
    on<AddFavorite>((event, emit) {
      _favorites.add(event.food);
      emit(FavoriteUpdated(List.from(_favorites)));
    });

    on<RemoveFavorite>((event, emit) {
      _favorites.removeWhere((f) => f.foodName == event.food.foodName);
      emit(FavoriteUpdated(List.from(_favorites)));
    });
  }

  // الآن هذه الدوال متاحة خارج الـ constructor
  bool isFavorite(Food food) {
    return _favorites.any((f) => f.foodName == food.foodName);
  }

  void toggleFavorite(Food food) {
    if (isFavorite(food)) {
      add(RemoveFavorite(food));
    } else {
      add(AddFavorite(food));
    }
  }
}
