import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/productdetails/doamin/entits/meal.dart';

class SummaryTab extends StatelessWidget {
  final Meal meal;
  const SummaryTab({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(meal.summary, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: meal.nutritions.map((n) => Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color:appBlueColor, width: 3),
              ),
              alignment: Alignment.center,
              child: Text(
                "${n.amount}\n${n.name}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: appBlueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
