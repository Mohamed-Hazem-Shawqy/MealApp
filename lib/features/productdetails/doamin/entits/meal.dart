class Meal {
  final String id;
  final String name;
  final String category;
  final int cookingTime;
  final int servings;
  final String imageUrl;
  final String summary;
  final List<Nutrition> nutritions;
  final List<Ingredient> ingredients;
  final List<DirectionStep> directions;

  Meal({
    required this.id,
    required this.name,
    required this.category,
    required this.cookingTime,
    required this.servings,
    required this.imageUrl,
    required this.summary,
    required this.nutritions,
    required this.ingredients,
    required this.directions,
  });
}

class Nutrition {
  final String name;
  final String amount;

  Nutrition({required this.name, required this.amount});
}

class Ingredient {
  final String name;
  final String quantity;

  Ingredient({required this.name, required this.quantity});
}

class DirectionStep {
  final int stepNumber;
  final String description;

  DirectionStep({required this.stepNumber, required this.description});
}
