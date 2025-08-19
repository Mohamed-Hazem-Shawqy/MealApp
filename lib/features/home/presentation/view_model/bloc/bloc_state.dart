import '../../../domain/entites/foodCategory.dart';

sealed class TaskState {}

class TaskInitial extends TaskState {}

class FavoriteUpdated extends TaskState {
  final List<Food> favorites;

  FavoriteUpdated(this.favorites);
}

class KeepFavoriteUpdated extends TaskState {
  final List<Food> favorites;

  KeepFavoriteUpdated(this.favorites);
}
