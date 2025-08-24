import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/productdetails/doamin/entits/meal.dart';

class IngredientsTab extends StatelessWidget {
  final Meal meal;
  const IngredientsTab({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: meal.ingredients.length,
      itemBuilder: (context, index) {
        final ingredient = meal.ingredients[index];
        return ListTile(
          title: Text(ingredient.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: Text(ingredient.quantity, style: const TextStyle(fontWeight: FontWeight.bold)),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        thickness: 2,
        color: appBlueColor,
      ),
    );
  }
}
