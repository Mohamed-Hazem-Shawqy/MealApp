import '../../../domain/entites/foodCategory.dart';

sealed class TaskState {
  final List<Food> homeFood;
  final List<Food> favorites;

  const TaskState({required this.homeFood, required this.favorites});
}

class TaskInitial extends TaskState {
  TaskInitial() : super(favorites: [], homeFood: []);
}

class TaskLoaded extends TaskState {
  const TaskLoaded({required super.homeFood, required super.favorites});
}


