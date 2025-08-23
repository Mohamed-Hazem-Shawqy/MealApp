class Food {
  final String imagePath;
  final String foodKind;
  final String foodName;
  final String ingredients;
  final String time;
  // final bool favorite;

  Food({
    required this.imagePath,
    required this.foodKind,
    required this.foodName,
    required this.ingredients,
    required this.time,
    // this.favorite = true,
  });

  factory Food.fromjson(Map<String, dynamic> json) {
    return Food(
      imagePath: json['imagePath'],
      foodKind: json['foodKind'],
      foodName: json['foodName'],
      ingredients: json['ingredients'],
      time: json['time'],
      // favorite: json['favorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'foodKind': foodKind,
      'foodName': foodName,
      'ingredients': ingredients,
      'time': time,
      // 'favorite': favorite,
    };
  }
}
