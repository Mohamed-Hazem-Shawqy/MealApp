import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../domain/entites/foodCategory.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class TaskBloc extends HydratedBloc<TaskEvent, TaskState> {
  final List<Food> _favorites = [];
  final List<Food> _homeFood = [];

  TaskBloc() : super(TaskInitial()) {
    on<AddFavorite>((event, emit) {
      _favorites.add(event.food);
      emit(
        TaskLoaded(
          favorites: List.from(_favorites),
          homeFood: List.from(_homeFood),
        ),
      );
    });

    on<RemoveFavorite>((event, emit) {
      _favorites.removeWhere((f) => f.foodName == event.food.foodName);
      emit(
        TaskLoaded(
          favorites: List.from(_favorites),
          homeFood: List.from(_homeFood),
        ),
      );
    });
    on<AddfoodToHome>((event, emit) {
      _homeFood.add(event.food);
      emit(
        TaskLoaded(
          homeFood: List.from(_homeFood),
          favorites: List.from(_favorites),
        ),
      );
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

  // @override
  // TaskState? fromJson(Map<String, dynamic> json) {
  //   return HomeUpdated(
  //     favorites: (json['favorites'] as List)
  //         .map((element) => Food.fromjson(element))
  //         .toList(),
  //     homeFood: (json['homeFood'] as List)
  //         .map((element) => Food.fromjson(element))
  //         .toList(),
  //   );
  // }
  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    final loadedFavorites = (json['favorites'] as List)
        .map((element) => Food.fromjson(element))
        .toList();

    final loadedHomeFood = (json['homeFood'] as List)
        .map((element) => Food.fromjson(element))
        .toList();

    _favorites
      ..clear()
      ..addAll(loadedFavorites);

    _homeFood
      ..clear()
      ..addAll(loadedHomeFood);

    return TaskLoaded(
      favorites: List.from(_favorites),
      homeFood: List.from(_homeFood),
    );
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return {
      "homeFood": state.homeFood.map((e) => e.toJson()).toList(),
      "favorites": state.favorites.map((e) => e.toJson()).toList(),
    };
  }
}
