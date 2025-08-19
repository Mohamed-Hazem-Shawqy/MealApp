class Food {
  final String imagePath;
  final String foodKind;
  final String foodName;
  final String ingredients;
  final String time;
  final bool favorite;

  Food({
    required this.imagePath,
    required this.foodKind,
    required this.foodName,
    required this.ingredients,
    required this.time,
    this.favorite = true,
  });
}
