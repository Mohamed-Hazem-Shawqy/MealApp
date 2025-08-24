class Food {
  final String imagePath;
  final String foodKind;
  final String foodName;
  final String ingredients;
  final String time;

  Food({
    required this.imagePath,
    required this.foodKind,
    required this.foodName,
    required this.ingredients,
    required this.time,
  });

  factory Food.fromjson(Map<String, dynamic> json) {
    return Food(
      imagePath: json['imagePath'],
      foodKind: json['foodKind'],
      foodName: json['foodName'],
      ingredients: json['ingredients'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'foodKind': foodKind,
      'foodName': foodName,
      'ingredients': ingredients,
      'time': time,
    };
  }
}
