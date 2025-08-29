import 'package:flutter/material.dart';
import 'package:meal_app/core/utils/app_colors.dart';
import 'package:meal_app/features/gemini/data/model.dart';

class SummaryTab extends StatelessWidget {
  const SummaryTab({super.key, required this.geminiResponseShapeModel});
  final GeminiResponseShapeModel geminiResponseShapeModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            geminiResponseShapeModel.summary,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 30,
            runSpacing: 20,
            children: List.generate(5, (index) {
              final nutrients = [
                {
                  'name': 'Protein',
                  'value': '${geminiResponseShapeModel.protein}g',
                },
                {'name': 'Carbs', 'value': '${geminiResponseShapeModel.carp}g'},
                {'name': 'Fat', 'value': '${geminiResponseShapeModel.fat}g'},
                {
                  'name': 'Calories',
                  'value': '${geminiResponseShapeModel.kcal} kcal',
                },
                {
                  'name': 'Vitamins',
                  'value': '${geminiResponseShapeModel.vetaimenes} mg',
                },
              ];

              final nutrient = nutrients[index];

              return Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: appBlueColor, width: 3),
                ),
                alignment: Alignment.center,
                child: Text(
                  "${nutrient['value']}\n${nutrient['name']}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: appBlueColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
