import 'package:flutter/material.dart';
import 'package:meal_app/features/productdetails/doamin/entits/meal.dart';

class DirectionsTab extends StatelessWidget {
  final Meal meal;
  const DirectionsTab({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: meal.directions
          .map((d) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Step ${d.stepNumber}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(d.description, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                ],
              ))
          .toList(),
    );
  }
}
