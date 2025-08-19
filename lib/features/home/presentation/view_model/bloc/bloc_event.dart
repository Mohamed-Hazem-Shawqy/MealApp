import '../../../domain/entites/foodCategory.dart';

sealed class TaskEvent {}

class AddFavorite extends TaskEvent {
  final Food food;

  AddFavorite(this.food);
}

class RemoveFavorite extends TaskEvent {
  final Food food;

  RemoveFavorite(this.food);
}

class KeepFavorite extends TaskEvent {
  final Food food;

  KeepFavorite(this.food);
}
