import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../domain/entites/foodCategory.dart';
import 'bloc_event.dart';
import 'bloc_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final List<Food> _favorites = [];

  TaskBloc() : super(TaskInitial()) {
    on<AddFavorite>((event, emit) async {
      try {
        _favorites.add(event.food);
        final userId = Supabase.instance.client.auth.currentUser?.id;
        if (userId != null) {
          await Supabase.instance.client.from('favorites').insert({
            'user_id': userId,
            'food_name': event.food.foodName,
            'image_path': event.food.imagePath,
            'food_kind': event.food.foodKind,
            'ingredients': event.food.ingredients,
            'time': event.food.time,
          });
        }
        emit(FavoriteUpdated(List.from(_favorites)));
      } catch (e) {
        emit(FavoriteUpdated(List.from(_favorites)));
      }
    });

    on<RemoveFavorite>((event, emit) async {
      try {
        _favorites.removeWhere((f) => f.foodName == event.food.foodName);
        final userId = Supabase.instance.client.auth.currentUser?.id;
        if (userId != null) {
          await Supabase.instance.client.from('favorites').delete().match({
            'user_id': userId,
            'food_name': event.food.foodName,
          });
        }
        emit(FavoriteUpdated(List.from(_favorites)));
      } catch (e) {
        emit(FavoriteUpdated(List.from(_favorites)));
      }
    });

    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId != null) {
        final response = await Supabase.instance.client
            .from('favorites')
            .select()
            .eq('user_id', userId);
        _favorites.clear();
        _favorites.addAll(
          response.map(
            (item) => Food(
              imagePath: item['image_path'],
              foodKind: item['food_kind'],
              foodName: item['food_name'],
              ingredients: item['ingredients'],
              time: item['time'],
            ),
          ),
        );
        emit(FavoriteUpdated(List.from(_favorites)));
      }
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

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
